# sublime-text

Portable Sublime Text config for Laravel / PHP development on macOS.
Part of the [dotfiles](https://github.com/ibrahim-gabr/dotfiles) repo.
Catppuccin Macchiato, LSP (intelephense, Tailwind, TypeScript, JSON, HTML, CSS),
Blade tooling, and build systems for Pint / Pest / Artisan / Vite.

## Install on a new machine

```bash
git clone git@github.com:ibrahim-gabr/dotfiles.git ~/dev/dotfiles
~/dev/dotfiles/sublime-text/install.sh
```

Then launch Sublime Text. On first start **Package Control auto-installs the
24 packages** listed in `User/Package Control.sublime-settings`, and the LSP
servers download themselves the first time you open a PHP/Blade file.

Requires: Homebrew, Node.js/npm, and PHP + Composer (e.g. Laravel Herd).

## What's here

| Path | Purpose |
| --- | --- |
| `User/Preferences.sublime-settings` | Theme, font, editor behaviour |
| `User/Package Control.sublime-settings` | **The package list** — drives auto-install |
| `User/LSP*.sublime-settings` | PHP (intelephense) + Tailwind language servers |
| `User/BladeFormatter.sublime-settings` | Blade formatter options |
| `User/Laravel *.sublime-build` | Pint / Pest / Artisan / Vite build systems |
| `User/Default (OSX).sublime-keymap` | Terminus toggle (`⌥⌘T`), Blade format (`⌥⌘F`) |
| `vendor/Package Control.sublime-package` | Package Control **4.2.8** |

`install.sh` symlinks each file in `User/` into
`~/Library/Application Support/Sublime Text/Packages/User/`, backing up any
existing file to `*.bak`.

## Why these choices

- **Only `Packages/User/` is portable.** Everything else — installed packages,
  LSP server binaries, caches, sessions — regenerates. That's why the repo is
  tiny and there are no machine paths in it.
- **Package Control must be 4.2.8+.** Version 3.4.1 does not run on current
  Sublime builds (Python 3.14), and packagecontrol.io's download link still
  serves 3.4.1 — that's why the correct build is vendored here.
- **`blade-formatter` is a global npm tool**, not a package: the BladeFormatter
  package shells out to it.

## Gotchas

- **Never reference a color scheme or theme that isn't installed.** Sublime
  throws a *modal* error at startup and that blocks the plugin host — no
  plugin loads, so nothing works. Install the package first.
- **First-run prompts block startup too** (Package Control telemetry, Emmet).
  They're pre-answered here (`submit_usage: false`, Emmet `telemetry: false`).
- Don't symlink the whole `Packages/User` directory — Sublime writes generated
  files there (`Terminus.hidden-color-scheme`, etc.). Linking file-by-file keeps
  generated state out of the repo.

## Adding a package

1. Add its name to `installed_packages` in `User/Package Control.sublime-settings`.
2. Restart Sublime — Package Control installs it.

## Notes

- `project.sublime-project` lives in the project repo, not here.
- Sublime Text nags "UNREGISTERED" until you enter your license
  (Help → Enter License); it does not affect functionality.
