# dotfiles

Personal macOS dotfiles, managed with [chezmoi](https://www.chezmoi.io/) and
synced across machines through this Git repo.

|          |                                                                                           |
| -------- | ----------------------------------------------------------------------------------------- |
| Shell    | [fish](https://fishshell.com/)                                                            |
| Terminal | [Ghostty](https://ghostty.org/)                                                           |
| Editors  | [Zed](https://zed.dev/) (GUI) · [micro](https://micro-editor.github.io/) (terminal & git) |
| Runtimes | [mise](https://mise.jdx.dev/)                                                             |

Machines are identified by hostname, so the same repo produces the right config
on each — see [Configuration](#configuration).

## Quick start on a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dorotheelaugwitz
```

This installs chezmoi, clones this repo, applies it, and runs the bootstrap
script — which installs Homebrew, fish (and makes it the default shell), micro,
and mise, then installs the runtimes declared for this machine.

GUI apps are not installed by the bootstrap. Install them once with:

```sh
brew install --cask ghostty zed
```

## Configuration

Machine-specific behaviour is driven by the hostname:

- `.chezmoi.toml.tmpl` sets `machine` to `work` or `personal` from the hostname,
  and the other templates key off that value. Check what chezmoi sees with:

  ```sh
  chezmoi execute-template '{{ .chezmoi.hostname }}'
  ```

  Give each machine a distinct, stable hostname (e.g.
  `sudo scutil --set HostName my-mac`) so the two never collide.

- `dot_gitconfig.tmpl` selects the git email per machine.

## Repository layout

chezmoi encodes the target path and attributes in the source filename
(`dot_` → `.`, `.tmpl` → rendered as a Go template).

| Source                                        | Applied to                                         |
| --------------------------------------------- | -------------------------------------------------- |
| `dot_config/fish/config.fish`                 | `~/.config/fish/config.fish`                       |
| `dot_config/fish/conf.d/aliases.fish`         | `~/.config/fish/conf.d/aliases.fish`               |
| `dot_config/fish/functions/g.fish`            | `~/.config/fish/functions/g.fish`                  |
| `dot_config/ghostty/config`                   | `~/.config/ghostty/config`                         |
| `dot_config/micro/settings.json`              | `~/.config/micro/settings.json`                    |
| `dot_config/mise/config.toml.tmpl`            | `~/.config/mise/config.toml`                       |
| `dot_gitconfig.tmpl`                          | `~/.gitconfig`                                     |
| `dot_gitignore`                               | `~/.gitignore` (git `excludesfile`)                |
| `.chezmoi.toml.tmpl`                          | generates `~/.config/chezmoi/chezmoi.toml` on init |
| `run_onchange_after_install-packages.sh.tmpl` | toolchain bootstrap                                |

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
- **Ghostty** uses the built-in `Sea Shells` theme (`ghostty +list-themes` to
  browse); fish shell integration is automatic. Ghostty advertises
  `TERM=xterm-ghostty`, so to SSH into hosts that lack that terminfo entry, copy
  it once: `infocmp -x xterm-ghostty | ssh HOST -- tic -x -`.
