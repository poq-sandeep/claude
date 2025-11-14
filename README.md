# Claude Repository

This repository contains various tools and projects.

## d2-static-images/

A static SVG image hosting solution using [D2 diagrams](https://d2lang.com/).

### What is it?

The `d2-static-images/` directory is a self-contained system for creating and hosting diagram images. It allows you to:

- Write diagrams as code using D2's declarative syntax
- Automatically generate SVG images from D2 source files
- Host these images on GitHub for easy access via URLs
- Track generation history with automated logging

### Quick Usage

```bash
cd d2-static-images
# Add/edit .d2 files in d2-sources/
./generate.sh
```

The script automatically generates SVGs, commits them, and pushes to GitHub.

### Accessing Images

Generated images are accessible via:
```
https://raw.githubusercontent.com/poq-sandeep/claude/main/d2-static-images/images/<filename>.svg
```

### Learn More

See `d2-static-images/CLAUDE.md` for detailed documentation on:
- D2 syntax and examples
- Build pipeline architecture
- Development workflow
- Troubleshooting

## License

MIT
