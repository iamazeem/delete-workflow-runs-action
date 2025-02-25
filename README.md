# delete-workflow-runs-action

[![CI](https://github.com/iamazeem/delete-workflow-runs-action/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/iamAzeem/delete-workflow-runs-action/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-darkgreen.svg?style=flat-square)](https://github.com/iamAzeem/delete-workflow-runs-action/blob/master/LICENSE)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/iamAzeem/delete-workflow-runs-action?style=flat-square)

GitHub Action to delete workflow runs.

## Usage

### Inputs

|            Input             | Required |        Default        | Description                                         |
| :--------------------------: | :------: | :-------------------: | :-------------------------------------------------- |
|           `token`            |  false   | `${{ github.token }}` | GitHub Token                                        |
| `include-disabled-workflows` |  false   |        `true`         | Include disabled workflows                          |
|           `branch`           |  false   |                       | Filter by branch                                    |
|         `commit-sha`         |  false   |                       | Filter by commit SHA                                |
|       `creation-date`        |  false   |                       | Filter by creation date e.g. `2025-02-24T01:00:00Z` |
|           `event`            |  false   |                       | Filter by event e.g. `pull_request`                 |
|           `status`           |  false   |                       | Filter by status e.g. `cancelled`                   |
|          `username`          |  false   |                       | Filter by username                                  |
|          `workflow`          |  false   |                       | Filter by workflow filename e.g. `ci.yml`           |
|            `keep`            |  false   |          `0`          | Keep last workflow runs [min=0, max=10]             |

For `event`, see [Events that trigger
workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)
for the complete list.

For `status`, see
[List workflow runs for a repository](https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2022-11-28#list-workflow-runs-for-a-repository)
API for all its supported values.

### Permissions

The permissions `actions: write` are required to delete workflow runs. See
[Automatic token authentication](https://docs.github.com/en/actions/security-for-github-actions/security-guides/automatic-token-authentication)
for more details.

### Examples

Assume that the required permissions are set:

```yml
permissions:
  actions: write
```

#### Delete all workflow runs

```yml
- uses: iamazeem/delete-workflow-runs-action@v1
```

#### Delete all workflow runs excluding the disabled ones

```yml
- uses: iamazeem/delete-workflow-runs-action@v1
  with:
    include-disabled-workflows: false
```

#### Delete all workflow runs except the last one

```yml
- uses: iamazeem/delete-workflow-runs-action@v1
  with:
    keep: 1
```

## Contribute

Open an
[issue](https://github.com/iamazeem/delete-workflow-runs-action/issues/new/choose)
to report bugs or propose new features and enhancements.

PRs are always welcome. Please follow this workflow for submitting PRs:

- [Fork](https://github.com/iamazeem/delete-workflow-runs-action/fork) the repo.
- Check out the latest `main` branch.
- Create a `feature` or `bugfix` branch from `main`.
- Commit and push changes to your forked repo.
- Make sure to add tests. See [CI](./.github/workflows/ci.yml).
- Lint and fix
  [Bash](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
  issues with [shellcheck](https://www.shellcheck.net/) online or with
  [vscode-shellcheck](https://github.com/vscode-shellcheck/vscode-shellcheck)
  extension.
- Lint and fix README Markdown issues with
  [vscode-markdownlint](https://github.com/DavidAnson/vscode-markdownlint)
  extension.
- Submit the PR.

## License

[MIT](LICENSE)
