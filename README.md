# CrosshairsPlus (WoW Forever Port)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**Original Author:** justLuther ([mikhaben/CrosshairsPlus](https://github.com/mikhaben/CrosshairsPlus))
**WoW Forever Port:** Mnxx29

A World of Warcraft: Forever (`1.60.1`, interface `16001`) port of **CrosshairsPlus**, an addon that displays a customizable crosshair overlay on your target's nameplate. Great for PvP targeting and dungeon/raid awareness.

> For the official Retail version, see [CrosshairsPlus on CurseForge](https://www.curseforge.com/wow/addons/crosshairsplus) or [Wago](https://addons.wago.io/addons/crosshairsplus).

## Features

- Attaches to target's nameplate in real-time
- 73 arrow styles with optional rotation animation
- 6 circle crosshair styles with glow and shadow effects
- Range display using LibRangeCheck-3.0 (LoadOnDemand sub-addon)
- Target info display (name or name + level)
- LibSharedMedia font integration for text elements
- Target filtering (enemy/friendly players, hostile/friendly NPCs, critters)
- Color mode selection: Reaction, Class, or Custom colors for enemy/friendly targets
- Action Targeting support (soft enemy targets)
- Frame strata control (rendering layer selection)
- Customizable lines, scale, opacity, arrow distance and size
- Smooth fade animations
- Modular architecture (11 Crosshair modules, 9 Settings modules)

## Installation

1. Download the latest release ZIP
2. Extract **both** `CrosshairsPlus` and `CrosshairsPlus_Range` into your WoW AddOns directory:
   - **Retail (Windows):** `World of Warcraft\_retail_\Interface\AddOns\`
   - **Retail (macOS):** `World of Warcraft/_retail_/Interface/AddOns/`
   - **WoW Forever (Windows):** `World of Warcraft\_forever_\Interface\AddOns\`
   - **WoW Forever (macOS):** `World of Warcraft/_forever_/Interface/AddOns/`
3. `/reload` in-game

> **Note:** `CrosshairsPlus_Range` is an optional LoadOnDemand sub-addon that provides range display via LibRangeCheck-3.0. The main addon works without it, but the Range tab and range numbers will not be available.

**Settings:** ESC > Interface > AddOns > CrosshairsPlus

## Commands

| Command | Description |
|---------|-------------|
| `/chp` or `/crosshairsplus` | Open settings |
| `/chp debug` | Toggle debug logging |
| `/chp test` | Show diagnostic info |
| `/chp preview` | Toggle crosshair at screen center |

## Development

```bash
git clone <repo>
./build.sh  # creates build/CrosshairsPlus_VERSION_YYYY-MM-DD.zip
```

The build includes both `CrosshairsPlus/` and `CrosshairsPlus_Range/` in the ZIP.

Before opening a PR, run `./check.sh` (see [CONTRIBUTING.md](CONTRIBUTING.md)). The architecture notes are in [AGENTS.md](AGENTS.md).

**Useful Console Commands:**

| Command | Description |
|---------|-------------|
| `/console scriptErrors 1` | Show Lua errors in-game |
| `/console taintLog 2` | Enable taint logging |
| `/framestack` | Show frame hierarchy under cursor |

## Releasing

Releases are cut by the maintainer by pushing a version tag on `main`; the steps are in the header of
[`.github/workflows/release.yml`](.github/workflows/release.yml).

## Credits

**Original Author:** justLuther ([mikhaben/CrosshairsPlus](https://github.com/mikhaben/CrosshairsPlus))
**WoW Forever Port:** Mnxx29

**Special Thanks:**
- **ElvUI** - Arrow icon textures
- **Mesostealthy** - weizPvP inspiration
- **semlar** - Crosshairs addon inspiration

See the [`release-notes/`](release-notes/) folder for per-version changelogs.

## Contributing

Found a bug or have a feature request? Open an issue or submit a pull request — see [CONTRIBUTING.md](CONTRIBUTING.md) for how to build, test, and what to expect in review.

## License

CrosshairsPlus is released under the [MIT License](LICENSE).
