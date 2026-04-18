# Wiki Schema

Canonical rules for LLM-maintained knowledge base wikis. This is the single source of truth — the CLAUDE.md config pulls from this document.

## Architecture

Three directories, three roles:

- **raw/** — immutable source documents. The LLM reads from here but NEVER modifies these files.
- **wiki/** — the LLM's workspace. Create, update, and maintain all files here.
- **output/** — reports, query results, and generated artifacts go here.

Wiki subdirectories:
- `wiki/sources/` — one summary page per ingested source
- `wiki/entities/` — pages for people, organizations, products, tools
- `wiki/concepts/` — pages for ideas, frameworks, theories, patterns
- `wiki/synthesis/` — comparisons, analyses, cross-cutting themes

Two special files:
- `wiki/index.md` — master catalog of every wiki page, organized by category. Update on every ingest.
- `wiki/log.md` — append-only chronological record. Never edit existing entries.

## Page Format

Every wiki page MUST include YAML frontmatter:

    ---
    tags: [tag1, tag2]
    sources: [source-filename-1.md, source-filename-2.md]
    created: YYYY-MM-DD
    updated: YYYY-MM-DD
    ---

Tags are organic — let them emerge naturally from content. Don't force a domain taxonomy. When a source spans multiple domains, tag with all relevant domains.

Use `[[wikilink]]` syntax for all internal links. When you mention a concept, entity, or source that has its own page, link it.

Every factual paragraph on entity, concept, and source summary pages must end with an inline parenthetical citation: `([[Source - Title]])`. When multiple sources support the same paragraph, comma-separate them: `([[Source - A]], [[Source - B]])`.

## Operations

### Ingest (processing a new source)

When the user adds a file to raw/ and asks you to process it:

1. Read the source completely
2. Create a source summary page in `wiki/sources/` with: title, source metadata, key claims, and a structured summary
3. Identify all entities and concepts mentioned. For each:
   - If a wiki page exists: update it with new information, citing the source inline as `([[Source - Title]])`. Backfill citations on existing uncited paragraphs.
   - If no wiki page exists and the topic is substantive: create one with inline citations on every paragraph
   - If mentioned only in passing: use a `[[wikilink]]` without creating a page
4. Add `[[wikilinks]]` between all related pages
5. Update `wiki/index.md` with any new pages
6. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | Source Title`

A single source may touch 10-15 wiki pages. That is normal.

When processing multiple sources (batch), process sequentially and report aggregate results.

### Query (answering questions)

When the user asks a question:

1. Read `wiki/index.md` to find relevant pages
2. Read the relevant wiki pages
3. Synthesize an answer with `[[wikilink]]` citations to wiki pages
4. Use tables for comparisons and Mermaid diagrams for relationships when the question calls for it
5. Only save answers to the wiki if the user explicitly asks

The wiki is self-contained — do not search the web.

### Lint (health check)

When the user asks you to lint or health-check the wiki:

1. Scan for contradictions between pages
2. Find stale claims that newer sources have superseded
3. Identify orphan pages (no inbound links)
4. Find important concepts mentioned but lacking their own page
5. Check for missing cross-references
6. Suggest data gaps that could be filled with additional sources
7. Auto-fix safe issues (missing index entries, stale index entries, fixable broken links)
8. Report remaining findings and offer to fix
9. Log the lint pass: `## [YYYY-MM-DD] lint | Summary of findings`

## Discovery

Two skills support exploration and creativity across the wiki:

- `/wiki-explore` — full wiki scan to surface cross-domain analogies, tensions, and unexpected connections
- `/wiki-spark` — generate creative prompts, thought experiments, research questions, and writing seeds from wiki content

Both are read-only and present results in chat without modifying the wiki.

## Index Format

Each entry in `wiki/index.md` is one line:

    - [[Page Name]] — one-line summary

Organized under category headers: Sources, Entities, Concepts, Synthesis.

## Log Format

Each entry in `wiki/log.md`:

    ## [YYYY-MM-DD] operation | Title
    Brief description of what was done.

## Page Naming

Filenames use **kebab-case** with `.md` extension. Page titles inside the file use **Title Case**.

- Source pages: `wiki/sources/article-title-here.md` → `# Article Title Here`
- Entity pages: `wiki/entities/entity-name.md` → `# Entity Name`
- Concept pages: `wiki/concepts/concept-name.md` → `# Concept Name`
- Synthesis pages: `wiki/synthesis/comparison-topic.md` → `# Comparison Topic`

When creating `[[wikilinks]]`, use the page title (Title Case), not the filename:
- Correct: `[[Entity Name]]`
- Wrong: `[[entity-name]]`

To slugify a title into a filename: lowercase, replace spaces with hyphens, remove special characters, trim to reasonable length.

## Image Handling

Web-clipped articles often include images. Handle them as follows:

1. **Download images locally.** In Obsidian Settings → Files and links, set "Attachment folder path" to `raw/assets/`. Then use "Download attachments for current file" (bind it to a hotkey like Ctrl+Shift+D) after clipping an article.
2. **Reference images from wiki pages** using standard markdown: `![description](../raw/assets/image-name.png)`. Keep the image in `raw/assets/` — never copy images into `wiki/`.
3. **During ingestion**, note any images in the source. If an image contains important information (diagrams, charts, data), describe its contents in the wiki page so the knowledge is captured in text form.

## Contradictions

When new information contradicts existing wiki content, add an Obsidian callout block:

```
> [!warning] Contradiction
> Source A claims X, but Source B claims Y.
> Sources: [[Source A]], [[Source B]]
```

Always cite both sources. Do not silently overwrite existing claims.

## Lint Frequency

Run a lint pass (`/wiki-lint`) on this schedule:
- **After every 10 ingests** — catches cross-reference gaps while they're fresh
- **Monthly at minimum** — catches stale claims and orphan pages that accumulate over time
- **Before any major query or synthesis** — ensures the wiki is healthy before you rely on it for analysis

## Rules

1. Never modify files in `raw/`. They are immutable source material.
2. Always update `wiki/index.md` when you create or delete a page.
3. Always append to `wiki/log.md` when you perform an operation.
4. Use `[[wikilinks]]` for all internal references. Never use raw file paths in page content.
5. Every wiki page must have YAML frontmatter with tags, sources, created, and updated fields.
6. When new information contradicts existing wiki content, add a `> [!warning] Contradiction` callout with both sources cited.
7. Keep source summary pages factual. Save interpretation and synthesis for concept and synthesis pages.
8. When asked a question, search the wiki first. Only go to raw sources if the wiki doesn't have the answer. Never search the web.
9. Prefer updating existing pages over creating new ones. Only create a new page when the topic is substantive enough to warrant it.
10. Keep `wiki/index.md` concise — one line per page, under 120 characters per entry.
