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
LOG_FILE="generation.log"
COMMIT_MESSAGE="Update generated SVG images"

echo -e "${BLUE}=== D2 SVG Generator ===${NC}\n"

# Initialize log entry
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "========================================" >> "$LOG_FILE"
echo "Generation Run: $TIMESTAMP" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

# Check if d2 is installed
if ! command -v d2 &> /dev/null; then
    echo -e "${RED}Error: d2 is not installed${NC}"
    echo "ERROR: d2 is not installed" >> "$LOG_FILE"
    echo "Please install d2 from https://d2lang.com/"
    echo "  macOS: brew install d2"
    echo "  Or: curl -fsSL https://d2lang.com/install.sh | sh -s --"
    exit 1
fi

D2_VERSION=$(d2 --version)
echo -e "${GREEN}✓ d2 found: $D2_VERSION${NC}\n"
echo "D2 Version: $D2_VERSION" >> "$LOG_FILE"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Check if there are any .d2 files
d2_files=("$D2_SOURCE_DIR"/*.d2)
if [ ! -e "${d2_files[0]}" ]; then
    echo -e "${YELLOW}Warning: No .d2 files found in $D2_SOURCE_DIR${NC}"
    echo "WARNING: No .d2 files found in $D2_SOURCE_DIR" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    exit 0
fi

# Generate SVGs from all D2 files
echo -e "${BLUE}Generating SVG files...${NC}\n"
echo "Files processed:" >> "$LOG_FILE"
count=0
for d2_file in "$D2_SOURCE_DIR"/*.d2; do
    if [ -f "$d2_file" ]; then
        filename=$(basename "$d2_file" .d2)
        output_file="$OUTPUT_DIR/${filename}.svg"

        echo -e "  Processing: ${YELLOW}$d2_file${NC} -> ${GREEN}$output_file${NC}"

        # Generate SVG with d2
        if d2 "$d2_file" "$output_file" --theme=0 2>&1; then
            echo "  ✓ $d2_file -> $output_file" >> "$LOG_FILE"
            ((count++))
        else
            echo "  ✗ FAILED: $d2_file" >> "$LOG_FILE"
        fi
    fi
done

echo -e "\n${GREEN}✓ Generated $count SVG file(s)${NC}\n"
echo "Total files generated: $count" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Git operations
if [ -d .git ]; then
    echo -e "${BLUE}Committing and pushing changes to git...${NC}\n"

    # Add generated SVG files and log file
    git add "$OUTPUT_DIR"/*.svg "$LOG_FILE" 2>/dev/null

    # Check if there are any staged changes to commit
    if ! git diff --cached --quiet --exit-code 2>/dev/null; then
        # Create commit with timestamp
        commit_timestamp=$(date '+%Y-%m-%d %H:%M:%S')

        # Commit only the images and log file, leaving other staged changes alone
        if git diff --cached --quiet --exit-code -- "$OUTPUT_DIR" "$LOG_FILE" 2>/dev/null; then
            echo -e "${YELLOW}No changes detected in generated files${NC}"
            echo "No changes to commit" >> "$LOG_FILE"
        else
            if git commit -m "$COMMIT_MESSAGE - $commit_timestamp" -- "$OUTPUT_DIR" "$LOG_FILE" 2>&1; then
                echo -e "${GREEN}✓ Changes committed${NC}"
                echo "Git commit: SUCCESS ($commit_timestamp)" >> "$LOG_FILE"

                # Push to remote
                echo -e "${BLUE}Pushing to remote...${NC}"
                if git push 2>&1; then
                    echo -e "${GREEN}✓ Changes pushed to remote${NC}"
                    echo "Git push: SUCCESS" >> "$LOG_FILE"
                else
                    echo -e "${RED}✗ Failed to push to remote${NC}"
                    echo "Git push: FAILED" >> "$LOG_FILE"
                fi
            else
                echo -e "${RED}✗ Failed to commit changes${NC}"
                echo "Git commit: FAILED" >> "$LOG_FILE"
            fi
        fi
    else
        echo -e "${YELLOW}No changes detected${NC}"
        echo "No changes to commit" >> "$LOG_FILE"
    fi
else
    echo -e "${YELLOW}Warning: Not a git repository. Skipping git operations.${NC}"
    echo -e "To initialize: ${YELLOW}git init${NC}"
    echo "ERROR: Not a git repository" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"
echo -e "\n${GREEN}=== Done ===${NC}"
