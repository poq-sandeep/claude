# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains various tools and workspaces for the Solutions team.

## Directory Structure

- `d2-static-images/` - Static SVG image hosting using D2 diagrams
- `postman-workspace-*/` - Postman collections and environments for various clients
- `README.md` - Repository overview

## Postman Workspaces

### Naming Conventions

When working with Postman workspaces in `postman-workspace-*` directories, follow these naming conventions:

**Collection Names:**
```
<clientname> - Solution Artefacts
```
Example: `Ardene - Solution Artefacts`

**Environment Names:**
```
SLN: <clientname> - <environmentname>
```
Examples:
- `SLN: Ardene - dev`
- `SLN: Ardene - staging`
- `SLN: Ardene - prod`

### Directory Structure

Each Postman workspace follows this structure:
```
postman-workspace-<clientname>/
├── collections/        # .postman_collection.json files
├── environments/       # .postman_environment.json files
└── README.md          # Workspace-specific documentation
```

### File Naming

- Collections: `<clientname>-solution-artefacts.postman_collection.json`
- Environments: `sln-<clientname>-<env>.postman_environment.json`

Examples:
- `ardene-solution-artefacts.postman_collection.json`
- `sln-ardene-dev.postman_environment.json`

## Other Projects

See individual project directories for specific documentation:
- `d2-static-images/CLAUDE.md` - D2 diagram generation documentation
- `postman-workspace-*/README.md` - Client-specific Postman workspace documentation
