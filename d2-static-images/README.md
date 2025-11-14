# D2 Static Images

A static SVG image hosting solution using [D2 diagrams](https://d2lang.com/).

## Overview

This directory contains everything needed to create, generate, and host diagram images. Write diagrams as code using D2's declarative syntax, and the automated build script handles the rest.

## Directory Structure

```
d2-static-images/
├── d2-sources/          # Your D2 diagram source files (.d2)
│   ├── clients/         # Client-specific diagrams (strict naming required)
│   │   └── <clientname>-<featurename>-<diagramname>.d2
│   ├── example-architecture.d2
│   └── example-simple.d2
├── images/              # Generated SVG files (auto-generated, committed to git)
│   ├── clients/         # Client diagram outputs
│   │   └── <clientname>-<featurename>-<diagramname>.svg
│   ├── example-architecture.svg
│   └── example-simple.svg
├── generate.sh          # Automated build, commit, and push script
├── generation.log       # Historical log of all generation runs
├── .gitignore          # Git ignore rules (allows generation.log, blocks other logs)
├── CLAUDE.md           # Technical documentation for Claude Code
└── README.md           # This file
```

## Quick Start

### Prerequisites

Install D2:
```bash
# macOS
brew install d2

# Or from source
curl -fsSL https://d2lang.com/install.sh | sh -s --

# Verify installation
d2 --version
```

### File Naming Conventions

#### General Diagrams
Place general-purpose diagrams in `d2-sources/` root:
- Any filename is acceptable (e.g., `my-diagram.d2`, `architecture.d2`)

#### Client-Specific Diagrams
Place client diagrams in `d2-sources/clients/` with **strict naming**:

**Format:** `<clientname>-<featurename>-<diagramname>.d2`

**Examples:**
- `ardene-swym-integration.d2`
- `ardene-shopify-checkout.d2`
- `client-feature-workflow.d2`

**Requirements:**
- Must have at least 2 hyphens (3 parts: client, feature, diagram)
- Lowercase recommended for consistency
- Files not following this format will be **skipped** with an error

### Creating Your First Diagram

1. Create a new `.d2` file:
   ```bash
   # General diagram
   nano d2-sources/my-diagram.d2

   # OR client-specific diagram
   nano d2-sources/clients/ardene-swym-integration.d2
   ```

2. Write your diagram:
   ```d2
   user: User {
     shape: person
     style.fill: "#ffe0b2"
   }

   api: API Server {
     style.fill: "#c8e6c9"
   }

   database: Database {
     shape: cylinder
     style.fill: "#f8bbd0"
   }

   user -> api: HTTPS Request
   api -> database: SQL Query
   database -> api: Data
   api -> user: JSON Response
   ```

3. Run the generation script:
   ```bash
   ./generate.sh
   ```

### What `generate.sh` Does

The script automates the entire workflow:

1. **Validation**: Checks if D2 is installed
2. **Filename Validation**: For client diagrams, validates naming convention (`<clientname>-<featurename>-<diagramname>.d2`)
3. **Generation**: Compiles all `.d2` files to SVG with `--theme=0` (neutral theme)
   - General diagrams: `d2-sources/*.d2` → `images/*.svg`
   - Client diagrams: `d2-sources/clients/*.d2` → `images/clients/*.svg`
4. **Logging**: Records timestamp, D2 version, processed files, and results to `generation.log`
5. **Git Operations**:
   - Stages generated SVG files and the log file
   - Commits with timestamped message
   - Pushes to GitHub remote automatically
6. **Error Handling**:
   - Skips client files with invalid naming
   - Logs failures with descriptive messages
   - Displays error count at the end

#### Script Output Examples

**Successful Generation:**
```
=== D2 SVG Generator ===

✓ d2 found: 0.7.1

Generating SVG files...

  Processing: d2-sources/my-diagram.d2 -> images/my-diagram.svg
  Processing: d2-sources/clients/ardene-swym-integration.d2 -> images/clients/ardene-swym-integration.svg
✓ Generated 2 SVG file(s)

Committing and pushing changes to git...
✓ Changes committed
Pushing to remote...
✓ Changes pushed to remote

=== Done ===
```

**With Naming Errors:**
```
=== D2 SVG Generator ===

✓ d2 found: 0.7.1

Generating SVG files...

  Processing: d2-sources/my-diagram.d2 -> images/my-diagram.svg
  ✗ SKIPPED: d2-sources/clients/invalid.d2
    Error: Invalid filename format
    Expected: <clientname>-<featurename>-<diagramname>.d2
    Example: ardene-swym-integration.d2
  Processing: d2-sources/clients/ardene-swym-integration.d2 -> images/clients/ardene-swym-integration.svg

✓ Generated 2 SVG file(s)
✗ 1 error(s) occurred

=== Done ===
```

#### Generation Log Format

The `generation.log` file maintains a historical record:

```
========================================
Generation Run: 2025-11-14 07:08:36
========================================
D2 Version: 0.7.1
Files processed:
  ✓ d2-sources/example-architecture.d2 -> images/example-architecture.svg
  ✓ d2-sources/example-simple.d2 -> images/example-simple.svg
Total files generated: 2

Git commit: SUCCESS (2025-11-14 07:08:36)
Git push: SUCCESS
```

## Accessing Generated Images

Once pushed to GitHub, your images are accessible via:

**Raw GitHub URLs** (for direct embedding):
```
https://raw.githubusercontent.com/poq-sandeep/claude/main/d2-static-images/images/<filename>.svg
```

**GitHub Pages URLs** (if enabled):
```
https://poq-sandeep.github.io/claude/d2-static-images/images/<filename>.svg
```

### Current Examples

- [example-architecture.svg](https://poq-sandeep.github.io/claude/d2-static-images/images/example-architecture.svg)
- [example-simple.svg](https://poq-sandeep.github.io/claude/d2-static-images/images/example-simple.svg)

### Using in Markdown

Embed images directly in README files or documentation:

```markdown
![Architecture Diagram](https://raw.githubusercontent.com/poq-sandeep/claude/main/d2-static-images/images/example-architecture.svg)
```

### Using in HTML

```html
<img src="https://raw.githubusercontent.com/poq-sandeep/claude/main/d2-static-images/images/example-architecture.svg" alt="Architecture">
```

## Testing Your Diagrams

Before running `generate.sh`, you can test and preview your D2 diagrams in the **[D2 Playground](https://play.d2lang.com/)**.

### How to Test:

1. Open the [D2 Playground](https://play.d2lang.com/)
2. Copy the content from your `.d2` file in `d2-sources/`
3. Paste it into the playground editor
4. Preview the rendered diagram in real-time
5. Experiment with different layouts, themes, and styles
6. Once satisfied, save your changes back to the `.d2` file
7. Run `./generate.sh` to generate the SVG

The playground provides instant feedback and helps you iterate quickly on your diagram designs before committing them to the repository.

## D2 Syntax Guide

### Basic Connections

```d2
A -> B: Label
A -> B -> C: Multi-step flow
```

### Shapes

```d2
person: User {
  shape: person
}

server: Web Server {
  shape: rectangle
}

database: DB {
  shape: cylinder
}

queue: Message Queue {
  shape: queue
}

cloud: Cloud Service {
  shape: cloud
}
```

### Styling

```d2
component: My Component {
  style.fill: "#b3e5fc"       # Fill color
  style.stroke: "#01579b"     # Border color
  style.font-color: "#000000" # Text color
  style.bold: true            # Bold text
}
```

### Layout Direction

```d2
direction: right  # Options: up, down, left, right (default: down)
```

### Comments

```d2
# This is a comment
user -> server  # Inline comment
```

## Advanced Usage

### Manual Generation (Without Git)

If you want to generate SVGs without committing:

```bash
d2 d2-sources/my-diagram.d2 images/my-diagram.svg --theme=0
```

### Using Different Themes

The script uses `--theme=0` (neutral), but you can manually generate with other themes:

```bash
# Theme options: 0-8
d2 d2-sources/my-diagram.d2 images/my-diagram.svg --theme=3
```

### Batch Processing

The script automatically processes all `.d2` files in `d2-sources/`. Just add multiple files:

```bash
d2-sources/
├── architecture.d2
├── database-schema.d2
├── api-flow.d2
└── deployment.d2
```

Run `./generate.sh` once to process all of them.

## Troubleshooting

### D2 Not Found

If you see "Error: d2 is not installed":
- Install D2 using the commands in Prerequisites
- Ensure D2 is in your PATH: `which d2`

### Git Push Fails

If push fails with authentication error:
- Check your GitHub authentication (SSH keys or personal access token)
- Manually push: `git push`

### SVG Not Updating

If changes don't appear:
- Check if the D2 file was saved
- Look for errors in the generation output
- Verify the SVG file timestamp: `ls -la images/`

### Script Won't Run

If you get "Permission denied":
```bash
chmod +x generate.sh
```

## Use Cases

- **Documentation**: Architecture diagrams in project READMEs
- **Blog Posts**: Technical diagrams in articles
- **Presentations**: Reference diagrams via URLs in slides
- **Internal Wikis**: Embed diagrams in Confluence, Notion, etc.
- **Web Applications**: Display dynamic diagrams via CDN URLs

## Resources

- [D2 Official Documentation](https://d2lang.com/)
- [D2 Tour (Interactive Tutorial)](https://d2lang.com/tour/intro)
- [D2 Playground (Online Editor)](https://play.d2lang.com/)
- [D2 GitHub Repository](https://github.com/terrastruct/d2)

## Contributing

To add new diagrams:
1. Create `.d2` file in `d2-sources/`
2. Run `./generate.sh`
3. That's it! The script handles the rest.

## License

MIT
