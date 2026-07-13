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

Anti-patterns — do NOT:
• Chain ctx_search -> ctx_read -> ctx_search(action=symbol) — one ctx_compose replaces all three
• Use ctx_read(mode=full) for orientation — use mode=signatures
• Use ctx_callgraph/ctx_graph for const/static/variable refs — they track call edges and file deps only; use ctx_search instead

PARALLEL: fire independent tool calls in the SAME turn — ctx_compose bundles multiple lookups into one call.

Auto: preload/dedup/compress run in background. ctx_session=memory, ctx_knowledge=facts, ctx_shell raw=true=uncompressed. Full guide: LEAN-CTX.md

RECOVER: compression is reversible — read the shown path (no MCP) or ctx_read(raw=true), never re-read line-by-line.

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