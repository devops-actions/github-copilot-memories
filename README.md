# github-copilot-memories
Workflow to scan for GitHub Copilot's memories

## Overview

This repository contains a workflow that monitors configured repositories for GitHub Copilot memories and creates an issue when memories are detected. This helps maintain awareness of what information Copilot is storing about your repositories.

## Workflows

### Fetch Copilot Memories

The Fetch Copilot Memories workflow checks configured repositories for GitHub Copilot memories and creates an issue when memories are found (runs daily at 8 AM UTC).

#### Configuration

The workflow requires the following configuration:

**Secrets:**
- `COPILOT_MEMORY_PAT`: A GitHub Personal Access Token with `repo` scope or fine-grained read access to the repositories you want to check. This token is used to call the GitHub Copilot API.

**Variables (optional):**
- `COPILOT_MEMORY_REPOSITORIES`: Comma-separated list of repositories to check in `owner/repo` format (e.g., `rajbos/actions-marketplace-checks,actions/checkout`). If not set, the workflow will check the current repository by default.
- `COPILOT_MEMORY_TAGGED_USER`: GitHub username to mention in the issue when memories are found (e.g., `rajbos`). The `@` symbol is optional.

#### Running the Workflow

The workflow runs automatically on a daily schedule at 8 AM UTC. You can also run it manually:

1. Go to the Actions tab in the repository
2. Select "Fetch Copilot Memories" workflow
3. Click "Run workflow"
4. Optionally, provide a custom list of repositories to check

#### What It Does

1. Fetches recent Copilot memories (up to 20 per repository) using the GitHub Copilot API
2. Generates a summary of found memories
3. If memories are found, creates an issue with:
   - List of repositories with memories
   - Count of memories per repository
   - Sample of recent memories (first 5 per repo)
   - Mention of the configured user (if set)
4. Uploads results as a workflow artifact for later review

#### API Endpoint

The workflow uses the following GitHub Copilot API endpoint:

```
GET https://api.githubcopilot.com/agents/swe/internal/memory/v0/{owner}/{repo}/recent?limit=20
```

This requires a Personal Access Token with appropriate repository access.

## Testing

Tests for the Copilot memories functionality are located in `tests/copilotMemories.Tests.ps1`. To run the tests:

```powershell
# Install Pester if not already installed
Install-Module -Name Pester -Force -SkipPublisherCheck

# Run the tests
Invoke-Pester -Path ./tests/copilotMemories.Tests.ps1
```
