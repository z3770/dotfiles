export interface LimitWindow {
  used: number;
  minutes?: number;
  resetAt?: number;
  observedAt: number;
}

export interface Limits {
  primary?: LimitWindow;
  secondary?: LimitWindow;
}

function number(value: unknown): number | undefined {
  if (typeof value !== "number" && typeof value !== "string") return;
  if (typeof value === "string" && value.trim() === "") return;
  const result = Number(value);
  return Number.isFinite(result) ? result : undefined;
}

function window(used: unknown, minutes: unknown, reset: unknown, now: number): LimitWindow | undefined {
  const percent = number(used);
  if (percent === undefined || percent < 0) return;
  const duration = number(minutes);
  const resetAt = number(reset);
  return {
    used: percent,
    minutes: duration !== undefined && duration > 0 ? duration : undefined,
    resetAt: resetAt !== undefined && resetAt > 0 ? resetAt : undefined,
    observedAt: now,
  };
}

export function limitsFromHeaders(headers: Record<string, string>, now = Date.now()): Limits {
  const h = Object.fromEntries(Object.entries(headers).map(([key, value]) => [key.toLowerCase(), value]));
  const read = (name: string) => window(
    h[`x-codex-${name}-used-percent`],
    h[`x-codex-${name}-window-minutes`],
    h[`x-codex-${name}-reset-at`],
    now,
  );
  return { primary: read("primary"), secondary: read("secondary") };
}

export function limitsFromEvent(data: unknown, now = Date.now()): Limits {
  if (!data || typeof data !== "object") return {};
  const event = data as Record<string, any>;
  // Do not confuse named/model-specific limits with the default Codex allowance.
  if (event.type !== "codex.rate_limits" ||
      (event.metered_limit_name && event.metered_limit_name !== "codex") ||
      (event.limit_name && event.limit_name !== "codex")) return {};
  const read = (name: string) => {
    const value = event.rate_limits?.[name];
    return window(value?.used_percent, value?.window_minutes, value?.reset_at, now);
  };
  return { primary: read("primary"), secondary: read("secondary") };
}

export function compactTokens(value: number): string {
  if (value < 1_000) return String(Math.round(value));
  if (value < 1_000_000) return `${(value / 1_000).toFixed(1).replace(/\.0$/, "")}k`;
  return `${(value / 1_000_000).toFixed(1).replace(/\.0$/, "")}M`;
}

function duration(minutes: number): string {
  if (minutes >= 1440 && minutes % 1440 === 0) return `${minutes / 1440}d`;
  if (minutes >= 60 && minutes % 60 === 0) return `${minutes / 60}h`;
  return `${minutes}m`;
}

export function allowanceLabels(limits: Limits, now = Date.now()): string[] {
  return (["primary", "secondary"] as const).flatMap((key) => {
    const value = limits[key];
    // Never silently present an expired or old observation as current quota.
    if (!value || now - value.observedAt > 15 * 60_000 ||
        (value.resetAt !== undefined && value.resetAt * 1000 <= now)) return [];
    const label = value.minutes ? duration(value.minutes) : key;
    const remaining = Math.max(0, Math.min(100, 100 - value.used));
    const reset = value.resetAt === undefined ? "" :
      ` ↻${duration(Math.max(1, Math.ceil((value.resetAt * 1000 - now) / 60_000)))}`;
    return [`${label} ${Math.floor(remaining)}% left${reset}`];
  });
}

export function safeLabel(value: string): string {
  return value.replace(/\x1b\[[0-?]*[ -/]*[@-~]/g, "").replace(/[\x00-\x1f\x7f-\x9f]/g, "");
}
