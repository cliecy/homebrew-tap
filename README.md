# cliecy/homebrew-tap

Personal Homebrew formulae for Cliecy's command-line tools.

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

## Packages

| Formula | Upstream | Description |
| --- | --- | --- |
| `proxytop` | [cliecy/proxytop](https://github.com/cliecy/proxytop) | macOS proxy, VPN, tunnel, and process traffic TUI |
| `cc-switch-ui` | [cliecy/cc-switch-ui](https://github.com/cliecy/cc-switch-ui) | Local Web UI for managing Claude Code and Codex CLI connections |

Formulae use immutable upstream releases and are updated by pull request. A
formula is only added after it has a versioned upstream release, a clean
installation path, and a meaningful Homebrew test.

## Maintenance

The scheduled updater checks upstream releases daily and opens a pull request
when a new version is available. Changes are reviewed before merging.

This is an unofficial tap. Review formula changes before trusting the tap as a
whole.
