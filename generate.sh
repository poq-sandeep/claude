#!/bin/bash

# D2 SVG Generation and Commit Script
# This script generates SVG files from D2 sources and commits them to the repository

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
D2_SOURCE_DIR="d2-sources"
OUTPUT_DIR="images"
COMMIT_MESSAGE="Update generated SVG images"

echo -e "${BLUE}=== D2 SVG Generator ===${NC}\n"

# Check if d2 is installed
if ! command -v d2 &> /dev/null; then
    echo -e "${RED}Error: d2 is not installed${NC}"
    echo "Please install d2 from https://d2lang.com/"
    echo "  macOS: brew install d2"
    echo "  Or: curl -fsSL https://d2lang.com/install.sh | sh -s --"
    exit 1
fi

echo -e "${GREEN}✓ d2 found: $(d2 --version)${NC}\n"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Check if there are any .d2 files
d2_files=("$D2_SOURCE_DIR"/*.d2)
if [ ! -e "${d2_files[0]}" ]; then
    echo -e "${YELLOW}Warning: No .d2 files found in $D2_SOURCE_DIR${NC}"
    exit 0
fi

# Generate SVGs from all D2 files
echo -e "${BLUE}Generating SVG files...${NC}\n"
count=0
for d2_file in "$D2_SOURCE_DIR"/*.d2; do
    if [ -f "$d2_file" ]; then
        filename=$(basename "$d2_file" .d2)
        output_file="$OUTPUT_DIR/${filename}.svg"

        echo -e "  Processing: ${YELLOW}$d2_file${NC} -> ${GREEN}$output_file${NC}"

        # Generate SVG with d2
        d2 "$d2_file" "$output_file" --theme=0

        ((count++))
    fi
done

echo -e "\n${GREEN}✓ Generated $count SVG file(s)${NC}\n"

# Git operations
if [ -d .git ]; then
    echo -e "${BLUE}Committing changes to git...${NC}\n"

    # Check if there are any changes
    if git diff --quiet "$OUTPUT_DIR" && git diff --cached --quiet "$OUTPUT_DIR"; then
        echo -e "${YELLOW}No changes detected in $OUTPUT_DIR${NC}"
    else
        # Add generated SVG files
        git add "$OUTPUT_DIR"/*.svg

        # Create commit with timestamp
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        git commit -m "$COMMIT_MESSAGE - $timestamp"

        echo -e "${GREEN}✓ Changes committed${NC}"
        echo -e "\nTo push changes, run: ${YELLOW}git push${NC}"
    fi
else
    echo -e "${YELLOW}Warning: Not a git repository. Skipping git operations.${NC}"
    echo -e "To initialize: ${YELLOW}git init${NC}"
fi

echo -e "\n${GREEN}=== Done ===${NC}"
