---
name: check-model
description: >-
  Review, audit, or validate an existing data model or set of transforms
  against the Maxa Business Knowledge Bundle. Use when the user asks to
  check their model, validate transforms, audit business rule compliance,
  run pre-flight checks, or verify that an implementation matches the
  bundle's requirements. Also use when the user says "does my model
  cover everything?", "what am I missing?", or "check against the specs."
---

# Check Model

You are auditing an existing data model or set of transforms against a Maxa Business Knowledge Bundle. Your job is to systematically verify that every business rule, data convention, and pre-flight requirement is addressed — and produce a structured pass/fail report.

## Step 0: Locate the bundle

Search for the Business Knowledge Bundle in the project:

1. Search for `project.yaml` files: `find . -name project.yaml -not -path '*/node_modules/*' -not -path '*/.git/*'`
2. For each result, check if it contains `bundle_format_version`
3. The directory containing that file is the bundle root
4. If nothing found, try common locations: `./business-knowledge-bundle/`, `./project/`, `./bundle/`, `./specs/`
5. If still not found, ask the user where they extracted the bundle
6. Read `index.md` from the bundle root to understand available content

Remember the bundle root path — every file reference below is relative to it.

## Step 1: Identify scope

Read `index.md` and identify all entities in the bundle. Then identify which entities the user's implementation touches — read the user's code/models to determine this. The audit covers every entity present in both the bundle and the implementation.

**Flag missing entities.** If the bundle defines entities the user has NOT implemented, flag them — especially if they appear as foreign keys on implemented entities. A missing dimension table (e.g., FiscalCalendar) that other entities reference is a structural gap, not an optional omission.

## Step 2: Audit business rules

For each entity file in `entities/`:

1. Read the "Business Rules Affecting This Entity" section
2. For each rule, search the user's codebase for how it's addressed
3. Record one of:
   - **PASS** — the rule is implemented correctly (cite the file and line)
   - **FAIL** — the rule is not implemented or implemented incorrectly (state what's wrong)
   - **N/A** — the entity is not in scope for the current implementation
4. Rules marked [MUST] that FAIL are blockers. Rules marked [SHOULD] that FAIL are warnings. Rules without explicit markers should be treated as [MUST] unless clearly advisory.

When a rule appears on multiple entities (e.g., Hash # sentinel), report it once with all affected entities listed — do not duplicate the same finding per entity.

## Step 3: Run pre-flight checklists

Read `specialized-instructions.md` — the Pre-Flight Checklist section. For each entity the implementation touches:

1. Walk every checklist item
2. Search the user's code for evidence that the item is addressed
3. Record PASS / FAIL per item with citations

Pay special attention to:
- Data type conversions (comma decimals, BIGINT dates, VARCHAR amounts)
- Sentinel value handling (hash # as a legitimate dimension member)
- Leaf-vs-rollup account filtering
- Version field filtering (Actual vs Budget)

## Step 4: Validate against numerical examples

Read `reference/numerical-examples.md`. For each documented value:

1. Determine whether the user's model should be able to reproduce it
2. If yes, trace the computation through the model — does the logic produce the expected result?
3. If the model cannot reproduce a value, flag it as a validation gap and cite the computation recipe from `specialized-instructions.md` that shows how it should be computed

## Step 5: Check business question coverage

Read `reference/business-questions.md`. For each validated business question:

1. Can the user's model answer this question? (i.e., are the required entities, attributes, and joins present?)
2. Record YES / NO per question
3. For NO answers, state what's missing (which entity, attribute, or join)

## Step 6: Surface relevant gaps and observations

Read `known-gaps.md`, `follow-up-questions.md`, and `expert-observations.md`. Surface any items that:

- Affect entities the user has implemented
- Represent risks the implementation should account for
- Highlight non-obvious behavior the user may have missed

These are informational — they don't produce PASS/FAIL results, but they contextualize the audit.

## Step 7: Produce the report

Output a structured report. Lead with the summary, then provide section details. Provide full per-item breakdowns only if the user asks to expand a section.

### Summary
Total counts: X rules passed, Y failed, Z N/A. Blockers (MUST-level failures) listed first, ranked by impact — data-corrupting issues (wrong type conversions, filtered sentinel values, missing sign logic) above cosmetic ones (naming, text language filters).

### Missing Entities
Bundle entities not implemented, with which implemented entities reference them.

### Business Rules Compliance
Per entity, per rule: PASS / FAIL / N/A with citations.

### Pre-Flight Checklist
Per entity, per item: PASS / FAIL with citations.

### Numerical Validation
Per example value: REPRODUCIBLE / GAP / N/A.

### Business Question Coverage
Per question: COVERED / NOT COVERED with what's missing.

### Risks and Observations
Relevant items from known-gaps, follow-up-questions, and expert-observations.
