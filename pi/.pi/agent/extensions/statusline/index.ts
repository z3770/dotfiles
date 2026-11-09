import { basename } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";
import { allowanceLabels, compactTokens, limitsFromEvent, limitsFromHeaders, safeLabel, type Limits } from "./helpers.ts";

export default function (pi: ExtensionAPI) {
  let limits: Limits = {};
  let dirty = false;
  let active = false;
  let render = () => {};
  let gitCheck: Promise<void> | undefined;

  const updateGit = (ctx: ExtensionContext) => {
    if (gitCheck) return gitCheck;
    gitCheck = (async () => {
      try {
        const result = await pi.exec("git", ["status", "--porcelain", "--untracked-files=normal"], {
          cwd: ctx.cwd, timeout: 3000, maxBuffer: 64 * 1024,
        });
        if (active) dirty = (result.code === 0 || result.truncated === true) && result.stdout.trim().length > 0;
      } catch {
        if (active) dirty = false;
      } finally {
        gitCheck = undefined;
        if (active) render();
      }
    })();
    return gitCheck;
  };

  const acceptLimits = (next: Limits) => {
    if (next.primary) limits.primary = next.primary;
    if (next.secondary) limits.secondary = next.secondary;
    if (next.primary || next.secondary) render();
  };

  pi.on("session_start", (_event, ctx) => {
    if (ctx.mode !== "tui") return;
    active = true;
    ctx.ui.setFooter((tui, theme, footerData) => {
      render = () => tui.requestRender();
      const unsubscribe = footerData.onBranchChange(() => {
        void updateGit(ctx);
        render();
      });
      return {
        invalidate() {},
        dispose() {
          unsubscribe();
          render = () => {};
        },
        render(width: number): string[] {
          const branch = footerData.getGitBranch();
          const project = safeLabel(basename(ctx.cwd) || ctx.cwd);
          const left = theme.fg("accent", project) + (branch
            ? theme.fg("muted", ` · ${safeLabel(branch)}`) + (dirty ? theme.fg("warning", "*") : "")
            : "");
          const usage = ctx.getContextUsage();
          const percent = usage?.percent;
          const context = usage?.tokens == null ? "ctx ?" :
            `ctx ${compactTokens(usage.tokens)}/${compactTokens(usage.contextWindow)}` +
            (percent == null ? "" : ` (${Math.round(percent)}%)`);
          const right = [
            theme.fg("muted", safeLabel(ctx.model?.id ?? "no model")),
            theme.fg("muted", ctx.thinkingLevel ?? pi.getThinkingLevel()),
            theme.fg(percent != null && percent >= 90 ? "error" :
              percent != null && percent >= 75 ? "warning" : "muted", context),
          ].join(theme.fg("dim", " · "));
          const gap = width - visibleWidth(left) - visibleWidth(right);
          const lines = gap >= 2 ? [left + " ".repeat(gap) + right] : [left, right];
          const allowance = ctx.model && ctx.modelRegistry.isUsingOAuth(ctx.model) &&
            ["openai", "openai-codex"].includes(ctx.model.provider)
            ? allowanceLabels(limits) : [];
          if (allowance.length) lines.push(theme.fg("muted", `Codex · ${allowance.join(" · ")}`));
          // Preserve useful statuses supplied by any future extensions.
          const statuses = [...footerData.getExtensionStatuses().values()];
          if (statuses.length) lines.push(statuses.join(" · "));
          return lines.map((line) => truncateToWidth(line, Math.max(0, width)));
        },
      };
    });
    void updateGit(ctx);
  });

  pi.on("agent_settled", (_event, ctx) => {
    if (active) void updateGit(ctx);
  });
  pi.on("model_select", () => {
    limits = {};
    render();
  });
  pi.on("thinking_level_select", () => render());
  pi.on("after_provider_response", (event, ctx) => {
    if (!active || !ctx.model || !["openai", "openai-codex"].includes(ctx.model.provider) ||
        !ctx.modelRegistry.isUsingOAuth(ctx.model)) return;
    acceptLimits(limitsFromHeaders(event.headers));
  });
  pi.on("provider_stream_event", (event, ctx) => {
    if (!active || !["openai", "openai-codex"].includes(event.provider) ||
        !ctx.model || !ctx.modelRegistry.isUsingOAuth(ctx.model)) return;
    acceptLimits(limitsFromEvent(event.data));
  });
  pi.on("session_shutdown", () => {
    active = false;
    limits = {};
    render = () => {};
  });
}
