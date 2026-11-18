"""Validate active Tokyo Night night themes without starting interactive apps.

Run from any directory: python3 .tests/themes.test.py
"""
import json
import plistlib
from pathlib import Path
import tomllib
import unittest

ROOT = Path(__file__).resolve().parents[1]


class TokyoNightThemes(unittest.TestCase):
    def test_pi_palette_and_selection(self):
        settings = json.loads((ROOT / "pi/.pi/agent/settings.json").read_text())
        self.assertEqual(settings["theme"], "tokyonight-night")
        theme = json.loads((ROOT / "pi/.pi/agent/themes/tokyonight-night.json").read_text())
        self.assertEqual(theme["name"], settings["theme"])
        self.assertEqual(theme["vars"]["bg"], "#1a1b26")
        self.assertEqual(theme["vars"]["fg"], "#c0caf5")
        for color in [*theme["colors"].values(), *theme["export"].values()]:
            self.assertTrue(color in theme["vars"] or color.startswith("#"))

    def test_bat_delta_and_yazi_share_syntax_theme(self):
        name = "tokyonight_night"
        self.assertIn(f'--theme="{name}"', (ROOT / "bat/.config/bat/config").read_text())
        self.assertIn(f"syntax-theme = {name}", (ROOT / "git/.config/git/config").read_text())
        path = ROOT / "bat/.config/bat/themes/tokyonight_night.tmTheme"
        # The upstream asset starts with a DOCTYPE, without an XML declaration.
        theme = plistlib.loads(b'<?xml version="1.0"?>\n' + path.read_bytes())
        self.assertEqual(theme["name"], "TokyoNight")
        yazi = tomllib.loads((ROOT / "yazi/.config/yazi/theme.toml").read_text())
        self.assertEqual(yazi["mgr"]["syntect_theme"], f"~/.config/bat/themes/{name}.tmTheme")
        self.assertEqual(yazi["status"]["overall"]["fg"], "#c0caf5")

    def test_atuin_theme_resolves(self):
        config = tomllib.loads((ROOT / "atuin/.config/atuin/config.toml").read_text())
        self.assertEqual(config["theme"]["name"], "tokyonight-night")
        path = ROOT / "atuin/.config/atuin/themes/tokyonight-night.toml"
        theme = tomllib.loads(path.read_text())
        self.assertEqual(theme["theme"]["name"], config["theme"]["name"])
        self.assertEqual(theme["colors"]["Base"], "#c0caf5")

    def test_ghostty_selection(self):
        ghostty = (ROOT / "ghostty/.config/ghostty/config").read_text()
        self.assertIn('theme = "TokyoNight Night"', ghostty)
        self.assertIn("background = #16161e", ghostty)

    def test_zsh_rgb_sequences_match_eza(self):
        zsh = (ROOT / "zsh/.zshrc").read_text()
        self.assertIn("di=1;38;2;122;162;247", zsh)
        self.assertIn("ln=38;2;42;195;222", zsh)
        self.assertIn("ex=1;38;2;158;206;106", zsh)
        self.assertIn("fi=38;2;192;202;245", zsh)
        self.assertIn("ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'", zsh)
        self.assertIn("ZSH_HIGHLIGHT_STYLES[arg0]='fg=#7aa2f7'", zsh)
        eza = (ROOT / "eza/.config/eza/theme.yml").read_text()
        self.assertIn('directory: { foreground: "#7aa2f7" }', eza)
        self.assertIn('symlink: { foreground: "#2ac3de" }', eza)

    def test_prompt_borders_and_lazygit_palette(self):
        prompt = (ROOT / "zsh/.p10k.zsh").read_text()
        self.assertIn("local blue='#7aa2f7' cyan='#7dcfff' purple='#bb9af7' red='#f7768e'", prompt)
        self.assertIn("local yellow='#e0af68' green='#9ece6a' comment='#565f89'", prompt)
        borders = (ROOT / "borders/.config/borders/bordersrc").read_text()
        self.assertIn("active_color=0xff7aa2f7", borders)
        lazygit = (ROOT / "lazygit/Library/Application Support/lazygit/config.yml").read_text()
        self.assertIn('      - "#c0caf5"', lazygit)
        self.assertIn('      - "#7aa2f7"', lazygit)


if __name__ == "__main__":
    unittest.main()
