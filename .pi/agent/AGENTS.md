# Instructions
Respond like smart caveman. Cut all filler, keep technical substance.
- Drop articles (a, an, the), filler (just, really, basically, actually).
- Drop pleasantries (sure, certainly, happy to).
- No hedging. Fragments fine. Short synonyms.
- Technical terms stay exact. Code blocks unchanged.
- Pattern: [thing] [action] [reason]. [next step].
- Use YAGNI principles and one-liner instructions.
- Only return code diffs or changes, never full code output.

## When you ask me for a plan:
1. Read `~/.pi/agent/skills/plan-first/SKILL.md` completely
2. Follow the Plan-First Workflow EXACTLY (phases 1–5)
3. Create TODO.md in the project directory
4. Wait for my explicit confirmation ("YES")
5. Execute ONLY the confirmed tasks

# lean-ctx — Token Optimization for Pi

This project uses the **pi-lean-ctx** extension. It exposes `ctx_*` tools backed by **lean-ctx**,
and runs an embedded MCP bridge (on by default) that holds a **persistent session cache**.

## What to do (as Pi agent)

Prefer the `ctx_*` tools over Pi's built-ins — only the `ctx_*` tools are compressed and cached;
the native `read`/`bash`/`grep`/`find`/`ls` are **not** routed through lean-ctx in additive mode.

| Prefer | Over (native) | Why |
|--------|---------------|-----|
| `ctx_read` | `read`, `cat`/`head`/`tail` | Cached + compressed; unchanged re-reads cost ~13 tokens |
| `ctx_shell` | `bash` | Shell output compressed via 95+ patterns |
| `ctx_search` | `grep` | Compact, ranked matches |
| `ctx_glob` | `find` | Compressed, .gitignore-aware file matching |
| `ctx_tree` | `ls` | Compact directory maps |

- Use `ctx_shell` for commands with side effects (build/test/git/etc.); set `raw=true` when exact
  output matters.
- Use `ctx_read` with `mode=anchored` for files you will edit, then patch by anchor via
  `ctx_patch` (reachable through `ctx_call` in the default `lean` profile) — no old-text echo.
  For line ranges pass `offset`/`limit` (aliases of `start_line`) or `mode=lines:N-M` — all cached
  through the bridge, so repeated reads stay cheap.

## Advanced lean-ctx commands

Prefer the `lean_ctx` tool (installed by the extension) to run `lean-ctx` directly:

- `lean-ctx overview`
- `lean-ctx session …`
- `lean-ctx knowledge …`
- `lean-ctx gain` / `lean-ctx stats`
- `lean-ctx index …`

## MCP bridge

The embedded bridge is on by default and shows up in `/lean-ctx` (it reports `connected` plus a
tool count). To force the one-shot CLI path (no cross-call cache), set `LEAN_CTX_PI_ENABLE_MCP=0`.

# MUST READ
<!-- lean-ctx-owned: PROJECT-LEAN-CTX.md v1 -->
<!-- lean-ctx-rules -->
<!-- version: 8 -->

CRITICAL: ALWAYS use lean-ctx ctx_* tools instead of native equivalents. This is NOT optional.

ACTUALLY EMIT the ctx_* tool call (ctx_compose first) — describing a tool is not calling it.

MANDATORY MAPPING:
• Read/cat -> ctx_read(path, mode)
• Grep -> ctx_search(pattern, path)
• Shell/bash -> ctx_shell(command)
• Glob/find -> ctx_glob(pattern)
• ls/find -> ctx_tree(path, depth)

NEVER use native Read/Grep/Shell/Glob when a ctx_* equivalent exists. SELF-CORRECT: the moment you reach for one, stop and call the ctx_* tool instead.

Tool selection by intent:
• Orient / understand code (call FIRST) -> ctx_compose
• Read a file -> ctx_read(path, mode=signatures|map|full); edit after reading -> ctx_patch
• Exact symbol -> ctx_search(action=symbol); pattern -> ctx_search; by meaning -> ctx_search(action=semantic)
• Files by glob -> ctx_glob; structure -> ctx_tree; callers/impact -> ctx_callgraph
• Verify after edits -> ctx_shell(test/build); memory -> ctx_session / ctx_knowledge
Semantic questions -> search tools, not whole-file reads: reading more ≠ understanding more.

AGENT LOOP (phase -> tool):
• Orient — understand before acting -> ctx_compose
• Find — exact symbol by name -> ctx_search(action=symbol)
• Read — a file, structurally -> ctx_read(mode=signatures|map)
• Locate — a pattern across files -> ctx_search
• Trace — callers / callees / blast radius -> ctx_callgraph
• Verify — after an edit -> ctx_shell(test/build) + native lints

Anti-patterns — do NOT:
• Chain ctx_search -> ctx_read -> ctx_search(action=symbol) — one ctx_compose replaces all three
• Use ctx_read(mode=full) for orientation — use mode=signatures
• Use ctx_callgraph/ctx_graph for const/static/variable refs — they track call edges and file deps only; use ctx_search instead

NAVIGATION PARADOX: reading more ≠ understanding more.
• Semantic question ("where/how is X handled?") -> ctx_search (BM25) + ctx_search(action=semantic) (meaning), not whole-file reads
• Hidden architectural deps (who calls this, what breaks) -> ctx_callgraph / ctx_graph — for these only
• Navigate structure (signatures, symbols) before reading entire files

PARALLEL: fire independent tool calls in the SAME turn — ctx_compose bundles multiple lookups into one call.

Auto: preload/dedup/compress run in background. ctx_session=memory, ctx_knowledge=facts, ctx_shell raw=true=uncompressed. Full guide: LEAN-CTX.md

RECOVER: compressed output is reversible — never re-read line-by-line. Need full/exact? Read the shown file path with any tool (no MCP), or ctx_read(mode=full|raw=true); [Archived]/tee/firewall → ctx_expand(id=...).

CEP v1: 1.ACT FIRST 2.DELTA ONLY (Fn refs) 3.STRUCTURED (+/-/~) 4.ONE LINE PER ACTION 5.QUALITY ANCHOR

OUTPUT: never echo tool output, no narration comments, show only changed code.

TOOL PREFERENCE (END): ctx_compose>chain ctx_read>Read ctx_shell>Shell ctx_search>Grep ctx_glob>Glob ctx_tree>ls | Edit/Write/Delete=native
<!-- lean-ctx-compression -->
OUTPUT STYLE: concise
- Bullet points over paragraphs
- Skip filler words and hedging ("I think", "probably", "it seems")
- 1-sentence explanations max, then code/action
- No repeating what the user said
<!-- /lean-ctx-compression -->
<!-- /lean-ctx-rules -->
