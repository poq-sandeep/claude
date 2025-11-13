# D2 Static Images Repository

A repository for serving static SVG images generated from [D2 diagrams](https://d2lang.com/).

## Directory Structure

```
d2-static-images/
├── d2-sources/       # D2 source files (.d2)
├── images/           # Generated SVG files
├── generate.sh       # Script to generate and commit SVGs
└── README.md         # This file
```

## Setup

1. Install D2:
   ```bash
   # macOS
   brew install d2

   # Or install from source
   curl -fsSL https://d2lang.com/install.sh | sh -s --
   ```

2. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd d2-static-images
   ```

## Usage

### Creating Diagrams

1. Add your D2 source files to the `d2-sources/` directory with a `.d2` extension
2. Run the generation script:
   ```bash
   ./generate.sh
   ```

The script will:
- Generate SVG files from all D2 sources in `d2-sources/`
- Save them to the `images/` directory
- Automatically commit and push the changes

### Accessing Images

Once pushed to GitHub, you can access your SVG images directly via:
```
https://raw.githubusercontent.com/<username>/<repo-name>/main/images/<filename>.svg
```

Or use GitHub Pages for a cleaner URL (see below).

## GitHub Pages (Optional)

To serve images via GitHub Pages:

1. Go to repository Settings > Pages
2. Set Source to "main" branch
3. Access images at: `https://<username>.github.io/<repo-name>/images/<filename>.svg`

## Examples

Example D2 files are included in `d2-sources/` to get you started.

## License

MIT
