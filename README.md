# dotfiles

Personal macOS dotfiles, managed with [chezmoi](https://www.chezmoi.io/) and
synced across machines through this Git repo.

|          |                                                                                           |
| -------- | ----------------------------------------------------------------------------------------- |
| Shell    | [fish](https://fishshell.com/)                                                            |
| Terminal | [Ghostty](https://ghostty.org/)                                                           |
| Editors  | [Zed](https://zed.dev/) (GUI) · [micro](https://micro-editor.github.io/) (terminal & git) |
| Runtimes | [mise](https://mise.jdx.dev/)                                                             |
| CLI      | eza · bat · fd · fzf · delta · zoxide                                                     |

Machines are identified by hostname, so the same repo produces the right config
on each — see [Configuration](#configuration).

## Quick start on a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dorotheelaugwitz
```

That one command installs chezmoi, clones this repo, applies it, and runs the
bootstrap, which installs:

- Homebrew
- CLI tools: fish (set as the default shell), micro, mise, eza, bat, fd, fzf, git-delta, jj, zoxide
- GUI apps: Ghostty, Zed
- the mise runtimes for this machine

It also applies macOS defaults once (`run_once_macos-defaults.sh`).

### Remaining manual steps

- **Machine type** — `chezmoi init` asks whether this is a `work` or `personal`
  machine (see [Configuration](#configuration)).
- **Git push** — add an SSH key to GitHub so `autoPush` works.
- **Zed** — its settings aren't managed (see [Editors & terminal](#editors--terminal)); configure it as you like.

## Configuration

Each machine is either `work` or `personal`. `chezmoi init` asks once and stores
the answer in `~/.config/chezmoi/chezmoi.toml`; every template keys off it (git
email, mise tools, etc.).

```sh
chezmoi init --source=~/dotfiles --promptString machine=work   # or =personal
```

To change it later, edit `machine` in `~/.config/chezmoi/chezmoi.toml` (or delete
that file and re-run `chezmoi init`).

## Repository layout

chezmoi encodes the target path and attributes in the source filename
(`dot_` → `.`, `.tmpl` → rendered as a Go template).

| Source                                        | Applied to                                         |
| --------------------------------------------- | -------------------------------------------------- |
| `dot_config/fish/config.fish`                 | `~/.config/fish/config.fish`                       |
| `dot_config/fish/conf.d/aliases.fish`         | `~/.config/fish/conf.d/aliases.fish`               |
| `dot_config/fish/functions/g.fish`            | `~/.config/fish/functions/g.fish`                  |
| `dot_config/fish/fish_plugins`                | `~/.config/fish/fish_plugins` (Fisher plugins)     |
| `dot_config/ghostty/config`                   | `~/.config/ghostty/config`                         |
| `dot_config/micro/settings.json`              | `~/.config/micro/settings.json`                    |
| `dot_config/bat/config`                       | `~/.config/bat/config`                             |
| `dot_config/mise/config.toml.tmpl`            | `~/.config/mise/config.toml`                       |
| `dot_gitconfig.tmpl`                          | `~/.gitconfig`                                     |
| `dot_gitignore`                               | `~/.gitignore` (git `excludesfile`)                |
| `.chezmoi.toml.tmpl`                          | generates `~/.config/chezmoi/chezmoi.toml` on init |
| `run_onchange_after_install-packages.sh.tmpl` | toolchain bootstrap                                |
| `run_once_macos-defaults.sh`                  | macOS system defaults (runs once)                  |

## Daily workflow

```sh
chezmoi edit ~/.config/fish/config.fish   # edit a managed file
chezmoi diff                              # preview pending changes
chezmoi apply                             # apply to the home directory
chezmoi update                            # pull + apply (e.g. on the other machine)
```

Source changes are committed and pushed automatically (`autoCommit`/`autoPush`
in `.chezmoi.toml.tmpl`). Editing the live file in `~` does not flow back on its
own — use `chezmoi edit`, or `chezmoi add <file>` to re-capture a direct edit.

## Tool versions (mise)

Global versions live in `dot_config/mise/config.toml.tmpl`. Pin per project with
a committed `.mise.toml` in that project's repo, which overrides the global set:

```sh
mise use node@20        # writes ./.mise.toml for the current project
mise use -g rust        # add a tool globally
mise install            # install everything in scope
```

## Editors & terminal

- **Zed** — its config is intentionally **not** managed here. Zed uses a single
  user `settings.json` with no local-override mechanism, and it holds
  machine-specific values (MCP servers, model/agent config), so it's kept local
  per machine.
- **micro** is the modeless terminal editor, set as `$EDITOR`/`$VISUAL` and
  git's `core.editor`. Open files in the GUI with `zed`.
- **Prompt** — [hauleth/agnoster](https://github.com/hauleth/agnoster) (powerline)
  via Fisher; the plugin list is `dot_config/fish/fish_plugins` and the bootstrap
  runs `fisher update`. `jj` is installed so agnoster's jujutsu segment doesn't error.
- **Ghostty** uses the built-in `Sea Shells` theme (`ghostty +list-themes` to
  browse); fish shell integration is automatic. Ghostty advertises
  `TERM=xterm-ghostty`, so to SSH into hosts that lack that terminfo entry, copy
  it once: `infocmp -x xterm-ghostty | ssh HOST -- tic -x -`.
