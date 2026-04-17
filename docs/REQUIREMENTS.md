# Personal Wiki — Blueprint

> This is the genesis document for this project. It describes the pattern, the requirements, and how we implemented it. You can use this as a blueprint to build your own version from scratch, or just install our implementation via `npx skills add` (see README.md).

## ORIGIN

Andrej Karpathy posted a thread about using LLMs to build personal knowledge bases — dump raw source material into a folder, let the LLM compile it into a structured wiki, and use Obsidian to browse the whole thing.

https://x.com/karpathy/status/2039805659525644595

A few days later he extended the theory to include a pattern via an idea file that is intentionally vague to allow creativity. The idea file is available here: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f and also stored locally in `llm-wiki.md`.

---

## THE PATTERN

You end up with three folders:

- **raw/** is your inbox. Articles, papers, notes, transcripts — you dump them here and never think about organizing them.
- **wiki/** is what the LLM builds for you. It reads everything in raw, writes articles, creates topic folders, links concepts together, and maintains an index. You barely touch this folder.
- **output/** is where reports and query results go.

Once it's running, you can ask the LLM questions against your wiki and it'll navigate the files, pull in the relevant material, and answer. No fancy RAG setup needed — just markdown files and a good prompt.

The magic is in the CLAUDE.md file at the root of the vault. That's where you tell the LLM how to behave as your librarian — the architecture, operations, page format, and rules it must follow.

---

## WHAT YOU NEED TO BUILD THIS

**Obsidian** — the frontend. It's a markdown editor that treats a folder of .md files like a wiki, with backlinks and a graph view.
> Download it from obsidian.md.

**Claude Code** — the AI agent that reads sources, writes wiki pages, and maintains everything. You tell it the rules via `CLAUDE.md` at the vault root.

**Obsidian Web Clipper** — a browser extension that saves web articles as clean markdown files directly into your vault's `raw/` folder. This is the primary way to feed source material in.
> https://chromewebstore.google.com/detail/obsidian-web-clipper/cnjifjpddelmedmihgijeibhnjfabmlf

---

## SIX OPERATIONS

Whether you build this yourself or use our skills, the system has six operations:

**Onboarding** (`/wiki-new`) — scaffold the vault structure and generate the CLAUDE.md config file. Create `raw/`, `wiki/` (with subdirectories for sources, entities, concepts, synthesis), and `output/`. Bootstrap `wiki/index.md` and `wiki/log.md`.

**Ingest** (`/wiki-ingest`) — process raw sources into wiki pages. Autonomous — reads the source, creates a summary in `wiki/sources/`, creates or updates entity and concept pages, adds wikilinks, updates the index and log. Supports batch processing of multiple sources. A single source typically touches 10-15 wiki pages.

**Query** (`/wiki-query`) — answer questions against the wiki. Read the index to find relevant pages, synthesize an answer with wikilink citations. Supports tables and Mermaid diagrams. The wiki is self-contained — no web search.

**Lint** (`/wiki-lint`) — health-check the wiki. Scan for broken wikilinks, orphan pages, contradictions, stale claims, missing cross-references, and data gaps. Auto-fixes safe issues, asks before fixing judgement calls.

**Explore** (`/wiki-explore`) — discover cross-domain connections. Full wiki scan to surface analogies (same pattern in different fields), tensions (conflicting claims across domains), and unexpected links between concepts.

**Spark** (`/wiki-spark`) — generate creative prompts. Produces what-if questions, research questions, synthesis prompts, and writing seeds drawn from wiki content.

---

## THE AGENT CONFIG FILE

The CLAUDE.md config is the brain of the system. It tells the LLM exactly how to behave. The key sections:

- **Architecture** — three directories (raw, wiki, output), wiki subdirectories (sources, entities, concepts, synthesis), two special files (index.md, log.md)
- **Page format** — YAML frontmatter (tags, sources, created, updated) + wikilink syntax
- **Operations** — step-by-step workflows for ingest, query, lint, explore, and spark
- **Rules** — 10 rules governing the LLM's behavior (never modify raw, always update index, etc.)

You can write this by hand (see `llm-wiki.md` for the conceptual foundation) or let the onboarding wizard generate it. The canonical rules live in `skills/wiki-new/references/wiki-schema.md`.

---

## HOW IT ALL FITS TOGETHER

Karpathy's pattern: dump raw sources, let the LLM compile a wiki, browse it in Obsidian.

| Concept | Implementation |
|---|---|
| "Dump raw sources" | `raw/` directory + Obsidian Web Clipper |
| "LLM compiles a wiki" | Ingest operation — reads sources, creates/updates wiki pages, maintains index and log |
| "Browse in Obsidian" | Obsidian reads `wiki/` with backlinks and graph view |
| "Ask questions" | Query operation — searches wiki, synthesizes answers with citations |
| "Maintain quality" | Lint operation — audits for contradictions, orphans, stale claims |
| "Discover connections" | Explore operation — surfaces cross-domain analogies and tensions |
| "Get inspired" | Spark operation — generates creative prompts from wiki content |
| "Set it up" | Onboarding operation — wizard scaffolds everything |
| "The prompt" | CLAUDE.md config file generated from wiki-schema rules |

The idea file (`llm-wiki.md`) is the creative seed. This document is the blueprint. The `skills/` directory is the executable implementation — but you could build your own from this blueprint using any LLM and any tooling you prefer.
