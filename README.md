# cliecy/homebrew-tap

Personal Homebrew formulae and casks for Cliecy's tools.

The `proxytop` formula targets macOS on Apple Silicon (arm64).

## Install

Install an individual formula directly:

```bash
brew install cliecy/tap/proxytop
brew install cliecy/tap/cc-switch-ui
```

Or add the tap first:

```bash
brew tap cliecy/tap
brew install proxytop
```

The Proxytop **menu bar app** is distributed as a cask:

```bash
brew install --cask cliecy/tap/proxytop-app
```

## Packages

| Formula | Upstream | Description |
| --- | --- | --- |
| `proxytop` | [cliecy/proxytop](https://github.com/cliecy/proxytop) | macOS proxy, VPN, tunnel, and process traffic TUI |
| `cc-switch-ui` | [cliecy/cc-switch-ui](https://github.com/cliecy/cc-switch-ui) | Local Web UI for managing Claude Code and Codex CLI connections |

| Cask | Upstream | Description |
| --- | --- | --- |
| `proxytop-app` | [cliecy/proxytop](https://github.com/cliecy/proxytop) | macOS menu bar proxy / VPN / network path inspector |

Formulae and casks use immutable upstream releases and are updated by pull
request. A package is only added after it has a versioned upstream release, a
clean installation path, and a meaningful Homebrew test.

> **Note:** the app cask is currently unsigned, so Gatekeeper blocks the first
> launch of a downloaded build, and it requires macOS 14 (Sonoma) or newer.
> Open it once with right-click → Open, or run:
> `xattr -dr com.apple.quarantine "/Applications/Proxytop.app"`

## Maintenance

The scheduled updater checks upstream releases daily and opens a pull request
when a new version is available. Changes are reviewed before merging.

This is an unofficial tap. Review package changes before trusting the tap as a
whole.
