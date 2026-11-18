"""Validate active Catppuccin Mocha themes without starting interactive apps.

Run from any directory: python3 .tests/themes.test.py
"""
import json
import plistlib
from pathlib import Path
import tomllib
import unittest

ROOT = Path(__file__).resolve().parents[1]


class MochaThemes(unittest.TestCase):
    def test_pi_palette_and_selection(self):
        settings = json.loads((ROOT / "pi/.pi/agent/settings.json").read_text())
        self.assertEqual(settings["theme"], "catppuccin-mocha")
        theme = json.loads((ROOT / "pi/.pi/agent/themes/catppuccin-mocha.json").read_text())
        self.assertEqual(theme["name"], settings["theme"])
        self.assertEqual(theme["vars"]["bg"], "#1e1e2e")
        self.assertEqual(theme["vars"]["fg"], "#cdd6f4")
        for color in [*theme["colors"].values(), *theme["export"].values()]:
            self.assertTrue(color in theme["vars"] or color.startswith("#"))

    def test_bat_delta_and_yazi_share_syntax_theme(self):
        name = "Catppuccin Mocha"
        self.assertIn(f'--theme="{name}"', (ROOT / "bat/.config/bat/config").read_text())
        self.assertIn(f"syntax-theme = {name}", (ROOT / "git/.config/git/config").read_text())
        path = ROOT / "bat/.config/bat/themes/Catppuccin Mocha.tmTheme"
        with path.open("rb") as source:
            self.assertEqual(plistlib.load(source)["name"], name)
        yazi = tomllib.loads((ROOT / "yazi/.config/yazi/theme.toml").read_text())
        self.assertEqual(yazi["mgr"]["syntect_theme"], f"~/.config/bat/themes/{name}.tmTheme")
        self.assertEqual(yazi["status"]["overall"]["fg"], "#cdd6f4")

    def test_atuin_theme_resolves(self):
        config = tomllib.loads((ROOT / "atuin/.config/atuin/config.toml").read_text())
        self.assertEqual(config["theme"]["name"], "catppuccin-mocha")
        path = ROOT / "atuin/.config/atuin/themes/catppuccin-mocha.toml"
        theme = tomllib.loads(path.read_text())
        self.assertEqual(theme["theme"]["name"], config["theme"]["name"])
        self.assertEqual(theme["colors"]["Base"], "#cdd6f4")

    def test_ghostty_and_posting_selection(self):
        ghostty = (ROOT / "ghostty/.config/ghostty/config").read_text()
        self.assertIn('theme = "Catppuccin Mocha"', ghostty)
        self.assertIn("background = #1e1e2e", ghostty)
        self.assertIn("theme: catppuccin-mocha", (ROOT / "posting/.config/posting/config.yaml").read_text())
        self.assertIn("name: catppuccin-mocha", (ROOT / "posting/.local/share/posting/themes/catppuccin-mocha.yaml").read_text())

    def test_zsh_rgb_sequences_match_eza(self):
        zsh = (ROOT / "zsh/.zshrc").read_text()
        self.assertIn("di=1;38;2;137;180;250", zsh)
        self.assertIn("ln=38;2;148;226;213", zsh)
        self.assertIn("ex=1;38;2;166;227;161", zsh)
        self.assertIn("fi=38;2;205;214;244", zsh)
        eza = (ROOT / "eza/.config/eza/theme.yml").read_text()
        self.assertIn('directory: { foreground: "#89b4fa" }', eza)
        self.assertIn('symlink: { foreground: "#94e2d5" }', eza)


if __name__ == "__main__":
    unittest.main()
