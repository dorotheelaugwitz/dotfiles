# dotfiles

Personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

- **Shell:** [fish](https://fishshell.com/)
- **Terminal:** [Ghostty](https://ghostty.org/)
- **Editors:** [Zed](https://zed.dev/) (GUI) + [micro](https://micro-editor.github.io/) (terminal/git)
- **Runtimes:** [mise](https://mise.jdx.dev/) (python, node, terraform, …)
- **dbt:** [dbt Fusion](https://docs.getdbt.com/docs/fusion/about-fusion) (standalone binary, BigQuery built in)

Work and personal machines are distinguished **by hostname** (see setup),
so the same repo produces the right config on each.

## Quick start on a new machine

```sh
# Installs chezmoi, pulls this repo, and applies everything (incl. the
# toolchain bootstrap script).
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dorotheelaugwitz
```

(`dorotheelaugwitz` expands to `https://github.com/dorotheelaugwitz/dotfiles.git`
because the repo is named `dotfiles`.)

On first apply, `run_onchange_after_install-packages.sh` installs Homebrew,
fish (and sets it as the default shell), mise (+ the runtimes for this
machine), and — on work machines — dbt Fusion.

## One-time setup before your first push

1. **Set your work hostname.** Edit `.chezmoi.toml.tmpl` and replace
   `CHANGE-ME-work-hostname` with your work machine's hostname. To see the
   value chezmoi uses:

   ```sh
   chezmoi execute-template '{{ .chezmoi.hostname }}'
   ```

2. **Set your work git email.** Edit `dot_gitconfig.tmpl` and replace
   `CHANGE_ME@work.example` (under the `work` branch) with your work address.

## Repository layout

chezmoi encodes the target path and attributes in the source filename
(`dot_` → `.`, `.tmpl` → rendered as a Go template).

| Source file | Applied to |
| --- | --- |
| `dot_config/fish/config.fish` | `~/.config/fish/config.fish` |
| `dot_config/fish/conf.d/aliases.fish` | `~/.config/fish/conf.d/aliases.fish` |
| `dot_config/fish/functions/g.fish` | `~/.config/fish/functions/g.fish` |
| `dot_config/zed/settings.json` | `~/.config/zed/settings.json` |
| `dot_config/zed/keymap.json` | `~/.config/zed/keymap.json` |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` (font + `Sea Shells` theme) |
| `dot_config/micro/settings.json` | `~/.config/micro/settings.json` |
| `dot_config/mise/config.toml.tmpl` | `~/.config/mise/config.toml` (per-machine) |
| `dot_gitconfig.tmpl` | `~/.gitconfig` (templated email/paths) |
| `dot_gitignore` | `~/.gitignore` (git `excludesfile`) |
| `dot_vimrc` | `~/.vimrc` |
| `.chezmoi.toml.tmpl` | generates `~/.config/chezmoi/chezmoi.toml` on init |
| `run_onchange_after_install-packages.sh.tmpl` | toolchain bootstrap |

## Daily workflow

```sh
chezmoi edit ~/.config/fish/config.fish   # edit a managed file
chezmoi diff                              # preview pending changes
chezmoi apply                             # apply to the home directory
chezmoi cd                                # jump into the source repo to commit
chezmoi update                            # git pull + apply (e.g. on the other machine)
```

> Unlike a symlink setup, edits to the live file in `~` don't flow back
> automatically — use `chezmoi edit`/`chezmoi apply`, or `chezmoi add <file>`
> to re-capture a file you changed directly.

## Managing tool versions (mise)

Global versions live in `dot_config/mise/config.toml.tmpl` (work vs personal).
Pin per project instead with a committed `.mise.toml` in that project's repo:

```sh
mise use node@20        # writes/updates ./.mise.toml for the current project
mise use -g rust        # add a tool globally (e.g. when exploring a language)
mise install            # install everything declared in scope
```

## Zed notes

Install these extensions from the Zed extensions panel (`cmd-shift-p` →
`zed: extensions`) to match the settings:

- **Palenight Theme**, **Material Icon Theme**, **Ruff** (Python).
- A **dbt / Jinja-SQL** extension if you want the 120-col `jinja-sql` ruler.

> The repo's `dot_config/zed/settings.json` is the translated baseline from the
> old Cursor config. Any personal/machine-specific Zed bits (MCP servers,
> agent/model config) can be layered on top — Zed also reads project-level
> `.zed/settings.json`.

## Terminal & editors

- **Ghostty** is configured in `dot_config/ghostty/config`. The `Sea Shells`
  theme is built into Ghostty (from the iterm2-color-schemes collection) and
  is identical to the old `SeaShells.itermcolors`, so no theme file is shipped.
  Browse themes with `ghostty +list-themes`. fish shell integration is
  automatic — nothing extra needed. Install the app separately (it's not in
  the bootstrap): `brew install --cask ghostty`.
- **micro** is the modeless terminal editor, set as `$EDITOR`/`$VISUAL` and as
  git's `core.editor` (so `git commit` opens micro). Its config lives in
  `dot_config/micro/settings.json`. Open files in the GUI by running `zed`.
- **Note on SSH:** Ghostty advertises `TERM=xterm-ghostty`. If you later start
  SSHing into machines without that terminfo entry, copy it once with
  `infocmp -x xterm-ghostty | ssh HOST -- tic -x -` (skipped for now).
