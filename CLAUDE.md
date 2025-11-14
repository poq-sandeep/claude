# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository serves static SVG images generated from D2 diagrams (https://d2lang.com/). It acts as a hosting solution for diagram images that can be referenced via GitHub raw URLs or GitHub Pages.

## Architecture

**Single-Purpose Repository**: This is a specialized repository for diagram hosting, not a general application codebase.

**Directory Layout**:
- `d2-sources/` - Source .d2 files (text-based diagram definitions)
- `images/` - Generated SVG output (committed to git)
- `generate.sh` - Automated build and commit script
- `generation.log` - Historical log of all generation runs with timestamps

**Build Pipeline**: The workflow is intentionally simple:
1. Edit/add .d2 files in `d2-sources/`
2. Run `./generate.sh` to compile all .d2 files to SVG
3. Script auto-commits generated SVGs and log file
4. Script auto-pushes to GitHub to make images available via URLs

## Common Commands

**Generate SVGs from D2 sources**:
```bash
./generate.sh
```
This will:
- Compile all .d2 files to SVG in `images/`
- Log the operation to `generation.log` with timestamp
- Auto-commit the SVGs and log file
- Auto-push to GitHub remote

**Install D2** (required dependency):
```bash
# macOS
brew install d2

# Or from source
curl -fsSL https://d2lang.com/install.sh | sh -s --
```

**Verify D2 installation**:
```bash
d2 --version
```

**Manual D2 compilation** (if needed):
```bash
d2 d2-sources/filename.d2 images/filename.svg --theme=0
```

**Access generated images**:
- Raw URL: `https://raw.githubusercontent.com/poq-sandeep/claude/main/images/<filename>.svg`
- GitHub Pages (if enabled): `https://poq-sandeep.github.io/claude/images/<filename>.svg`

## D2 Syntax Notes

D2 uses a simple text-based syntax for diagrams:
- Basic connection: `A -> B: label`
- Shapes: `shape: person`, `shape: cylinder`, `shape: hexagon`
- Styling: `style.fill: "#color"`
- Direction: `direction: right` (top-to-bottom is default)
- See example files in `d2-sources/` for reference patterns

## Key Constraints

- The `generate.sh` script uses `--theme=0` (neutral theme) for all SVG generation
- Generated SVGs should always be committed to version control (they're the deliverable)
- No complex build system or dependencies beyond D2 itself
- This is not a web application - it's a static file hosting repository
