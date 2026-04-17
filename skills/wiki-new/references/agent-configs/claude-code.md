# Claude Code Agent Config Template

This template generates a `CLAUDE.md` file at the vault root.

## Output File
- **Filename:** `CLAUDE.md`
- **Location:** Vault root

## Template

The onboarding skill should generate a file with this structure, replacing all `{{placeholder}}` values with the user's wizard answers:

---

    # {{VAULT_NAME}}

    > {{DOMAIN_DESCRIPTION}}

    ## Knowledge Base Rules

    You are a librarian and wiki maintainer for a personal knowledge base. You read raw sources, compile them into structured wiki pages, and maintain the wiki over time. You never improvise structure — you follow these rules exactly.

    {{WIKI_SCHEMA}}

## Placeholder Definitions

- `{{VAULT_NAME}}` — the vault name from wizard step 1
- `{{DOMAIN_DESCRIPTION}}` — the domain/topic from wizard step 3, formatted as a one-line description
- `{{WIKI_SCHEMA}}` — the full contents of `references/wiki-schema.md`, starting from the `## Architecture` section
