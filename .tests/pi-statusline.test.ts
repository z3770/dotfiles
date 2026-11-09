import assert from "node:assert/strict";
import test from "node:test";
import { allowanceLabels, compactTokens, limitsFromEvent, limitsFromHeaders, safeLabel } from "../pi/.pi/agent/extensions/statusline/helpers.ts";

const now = 1_800_000_000_000;

test("formats context token counts", () => {
  assert.equal(compactTokens(48000), "48k");
  assert.equal(compactTokens(1234), "1.2k");
  assert.equal(compactTokens(200000), "200k");
  assert.equal(compactTokens(1000000), "1M");
});

test("missing and malformed headers never invent account allowance", () => {
  for (const headers of [{}, { "x-codex-primary-used-percent": "" },
    { "x-codex-primary-used-percent": "NaN" }, { "x-codex-primary-used-percent": "-1" }]) {
    assert.deepEqual(allowanceLabels(limitsFromHeaders(headers, now), now), []);
  }
});

test("parses case-insensitive headers and displays remaining allowance and reset", () => {
  const limits = limitsFromHeaders({
    "X-Codex-Primary-Used-Percent": "22.5",
    "x-codex-primary-window-minutes": "300",
    "x-codex-primary-reset-at": String(now / 1000 + 7200),
    "x-codex-secondary-used-percent": "0",
    "x-codex-secondary-window-minutes": "10080",
  }, now);
  assert.deepEqual(allowanceLabels(limits, now), ["5h 77% left ↻2h", "7d 100% left"]);
});

test("drops stale or reset observations instead of guessing new allowance", () => {
  const limits = limitsFromHeaders({
    "x-codex-primary-used-percent": "80",
    "x-codex-primary-reset-at": String(now / 1000 + 60),
    "x-codex-secondary-used-percent": "50",
  }, now);
  assert.equal(allowanceLabels(limits, now + 60_000).length, 1);
  assert.deepEqual(allowanceLabels(limits, now + 16 * 60_000), []);
});

test("parses Codex stream telemetry but ignores other events and named limits", () => {
  const data = { type: "codex.rate_limits", rate_limits: {
    primary: { used_percent: 35, window_minutes: 300 },
    secondary: { used_percent: 101, window_minutes: 10080 },
  } };
  assert.deepEqual(allowanceLabels(limitsFromEvent(data, now), now), ["5h 65% left", "7d 0% left"]);
  for (const event of [null, {}, { ...data, type: "response.completed" },
    { ...data, metered_limit_name: "another_model" }]) {
    assert.deepEqual(limitsFromEvent(event, now), {});
  }
});

test("removes terminal control sequences from project and branch labels", () => {
  assert.equal(safeLabel("repo\n\x1b[31mred\x1b[0m"), "repored");
});
