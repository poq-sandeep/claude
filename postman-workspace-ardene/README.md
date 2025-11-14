# Ardene - Claude Postman Workspace

Postman collections and environments for Ardene APIs.

## Directory Structure

```
postman-workspace-ardene/
├── collections/        # Postman collection files (.postman_collection.json)
├── environments/       # Postman environment files (.postman_environment.json)
└── README.md          # This file
```

## Setup

### 1. Import to Postman

**Option A: Link GitHub Repository (Recommended)**

1. Open Postman
2. Go to **Settings** → **Integrations** → **GitHub**
3. Authenticate with GitHub
4. Select this repository: `poq-sandeep/claude`
5. Choose the `postman-workspace-ardene` directory
6. Enable auto-sync

**Option B: Manual Import**

1. Open Postman
2. Click **Import**
3. Select **File** or **Folder**
4. Choose files from `collections/` or `environments/`
5. Click **Import**

### 2. Set Active Environment

1. In Postman, select the environment dropdown (top right)
2. Choose your environment (dev/staging/prod)
3. The variables will be available in requests as `{{variable_name}}`

## Collections

Collections will be added here as they are created.

## Environments

Environment files contain variables for different deployment contexts:
- **dev** - Development environment
- **staging** - Staging environment
- **prod** - Production environment

## Usage

### Making Changes

**If using GitHub sync:**
- Changes in Postman auto-sync to this repository
- Changes in GitHub can be pulled into Postman

**If importing manually:**
- Make changes in Postman
- Export the collection/environment
- Replace the file in this directory
- Commit and push to GitHub

### Adding New Collections

1. Create collection in Postman or have Claude create the JSON file
2. Save to `collections/` directory
3. Commit and push to GitHub
4. Sync in Postman if using GitHub integration

## Best Practices

- Use environment variables for all URLs, API keys, and tokens
- Never commit sensitive data (API keys, passwords) directly in collections
- Use Postman variables or secret management for credentials
- Document your requests with descriptions
- Add test scripts to validate responses
- Use pre-request scripts for dynamic data generation

## Resources

- [Postman Documentation](https://learning.postman.com/)
- [Postman GitHub Integration](https://learning.postman.com/docs/integrations/available-integrations/github/)
- [Collection Format v2.1](https://schema.postman.com/collection/json/v2.1.0/draft-07/docs/index.html)
