# Personal Wiki

An LLM-maintained personal knowledge base built on the [LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f). Drop raw sources into a folder, let the LLM compile them into a structured wiki, and browse it all in Obsidian!

## How It Works

You feed raw material (articles, papers, notes, transcripts) into a `raw/` folder. The LLM reads everything, writes structured wiki pages, creates cross-references, and maintains an index. You browse the results in Obsidian — following links, exploring the graph view, and asking questions.

The LLM is the librarian. You're the curator.

## Prerequisites

- **[Obsidian](https://obsidian.md)** — the markdown editor you'll browse your wiki in
- **[Claude Code](https://claude.ai/code)** — the AI agent that reads sources, writes wiki pages, and maintains everything

## Install

```bash
npx skills add Ajwaldsouza/personal-wiki
```

Then install the slash commands:

```bash
bash scripts/install-commands.sh
```

This gives you six `/wiki-*` commands in Claude Code:

| Skill           | What it does                             |
| --------------- | ---------------------------------------- |
| `/wiki-new`     | Set up a new vault (guided wizard)       |
| `/wiki-ingest`  | Process raw sources into wiki pages      |
| `/wiki-query`   | Ask questions against your wiki          |
| `/wiki-lint`    | Health-check the wiki                    |
| `/wiki-explore` | Discover cross-domain connections        |
| `/wiki-spark`   | Generate creative prompts from your wiki |

## Quick Start

1. **Install the skills** (see above)
2. **Run the wizard:** type `/wiki-new` in Claude Code — it walks you through naming, location, and domain
3. **Install Web Clipper:** [Obsidian Web Clipper](https://chromewebstore.google.com/detail/obsidian-web-clipper/cnjifjpddelmedmihgijeibhnjfabmlf) — configure it to save to your vault's `raw/` folder
4. **Open in Obsidian** — launch Obsidian, choose "Open folder as vault", select your vault folder
5. **Clip your first article** to `raw/`, then run `/wiki-ingest` — the LLM processes it into wiki pages automatically
6. **Browse your wiki** in Obsidian — follow `[[wikilinks]]`, explore the graph view, check `wiki/index.md`
7. **Keep going** — `/wiki-query` to ask questions, `/wiki-lint` to health-check, `/wiki-explore` to find connections

## What You Get

```
your-vault/
├── raw/                    # Your inbox — drop sources here
│   └── assets/             # Images and attachments
├── wiki/                   # LLM-maintained wiki
│   ├── sources/            # One summary per ingested source
│   ├── entities/           # People, orgs, products, tools
│   ├── concepts/           # Ideas, frameworks, theories
│   ├── synthesis/          # Comparisons, analyses, themes
│   ├── index.md            # Master catalog of all pages
│   └── log.md              # Chronological operation record
├── output/                 # Reports and generated artifacts
└── CLAUDE.md               # Agent config
```

## FAQ

**The wizard failed or I need to re-run setup.**
Run `/wiki-new` again — the onboarding script is idempotent. It won't overwrite existing files, so your data is safe. If you need a fresh start, delete the vault folder and re-run.

**I accidentally modified a file in `raw/`.**
That's OK. The wiki was built from the original content. If you need the original back, check your git history (if the vault is a git repo) or re-clip the source. The wiki pages are unaffected.

**`wiki/index.md` is out of sync with actual pages.**
Run `/wiki-lint` — it auto-fixes index consistency issues (missing entries, stale entries).

**Wikilinks are broken after renaming a page.**
Run `/wiki-lint` — it auto-fixes broken links where the target page exists under a similar name.

**How do I handle images in clipped articles?**
In Obsidian, set Settings → Files and links → Attachment folder path to `raw/assets/`. After clipping an article, use "Download attachments for current file" to save images locally.

**How often should I lint?**
After every 10 ingests or monthly — whichever comes first. Also run it before any major query or synthesis work.

**Can I process multiple sources at once?**
Yes. Run `/wiki-ingest` without specifying a file — it detects all unprocessed files in `raw/` and processes them sequentially.

## Based On

- [Andrej Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [Agent Skills open standard](https://agentskills.io)
- [Blueprint & origin story](docs/REQUIREMENTS.md) — the founding document for this project
