---
type: entity
title: GLAccountHierarchyNode
entity_name: GLAccountHierarchyNode
entity_slug: gl-account-hierarchy-node
description: A node in the P&L hierarchy tree defining the parent-child rollup structure for financial reporting. Levels range from Net Income (L1 root) to leaf accounts. Central to P&L consolidation and Gross Margin, EBIT, and Net Income computation.
confidence: high
entity_type: domain_dimension
domain: finance
version: "1.0.0"
last_updated: "2026-10-05T20:33:03Z"
relationships:
  - GLAccount
  - GLAccountHierarchyNode
tags: [finance, pl_hierarchy, gl_account, master_data_governance, pl_consolidation_reporting]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| self-referential (parent-child) | [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) | Each node has at most one parent node in the adjacency list, forming the P&L rollup tree. The root node (Net Income) has no parent. |
| one_to_one | [GLAccount](/entities/gl-account.md) | Each leaf-level GL account maps to exactly one position in the P&L hierarchy tree, which determines its placement when building P&L statement lines. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `node_name` | STRING | Yes | Display name of the P&L hierarchy node (e.g., "Net Income", "EBIT", "Gross Margin", "COGS"). Identifies the financial statement line item this node represents in the P&L rollup structure. | Q001, Q002, Q007, Q009, Q013, Q018, Q021, Q025, Q026 |
| `hierarchy_level` | NUMERIC | Yes | Depth level of the node in the P&L hierarchy tree (L1 = root/Net Income, L2 = EBIT, higher numbers are more granular). Determines the rollup aggregation path used to build financial statements. | Q001, Q002, Q007, Q009, Q013, Q018, Q021, Q025, Q026 |
| `parent_gl_account_hierarchy_node_id` | STRING | No | Foreign key to the parent node in the P&L hierarchy adjacency list. Null for the root node (Net Income). Defines the parent-child rollup structure that transforms leaf-level GL postings into P&L statement lines. The value may change if the hierarchy is restructured (a node reassigned to a different parent). | Q001, Q002, Q007, Q009, Q013, Q018, Q021, Q025, Q026 |
| `is_leaf` | BOOLEAN | Yes | Whether this node is a leaf account that receives direct financial postings (true) or a rollup node whose value is computed by aggregating its children (false). Leaf accounts (e.g., COGS, Gross Revenue) receive transaction postings; rollup nodes (e.g., Gross Margin, EBIT, Net Income) are calculated aggregations. This leaf-vs-rollup distinction is fundamental to correct P&L construction. | Q001, Q002, Q007, Q009, Q013, Q018, Q021, Q025, Q026 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `effective_date` | DATE | Yes | Operational business date on which this P&L hierarchy node configuration became effective. [MUST] be captured because hierarchy configurations can be restructured over time, and the effective date identifies which configuration applies to a given reporting period. |
| `effective_date_timezone` | STRING | Yes | Timezone offset for `effective_date` in +/-HH:MM format. [MUST] accompany `effective_date` so the operational business date can be interpreted unambiguously across regions rather than relying on an assumed default timezone. |

## Supported Processes

- P&L Consolidation Reporting
- Master Data Governance

## Supported Questions

- [Q001: What is the Gross Margin percentage for VeloGroup (Net Revenue minus COGS divided by Net Revenue)?](/reference/business-questions.md)
- [Q002: What is the dollar variance between budget and actual for Net Income?](/reference/business-questions.md)
- [Q007: Is the Youth bike line profitable on its own, or is it a loss leader?](/reference/business-questions.md)
- [Q009: What percentage of all transactions are COGS (FPA1/020)?](/reference/business-questions.md)
- [Q013: What is the COGS ratio (COGS divided by Net Revenue)?](/reference/business-questions.md)
- [Q018: What is the monthly trend of Gross Margin with year-over-year comparison?](/reference/business-questions.md)
- [Q021: What is the Operating Expense total, split by Building vs Employee categories?](/reference/business-questions.md)
- [Q025: What is VeloGroup's Net Income (bottom line P&L)?](/reference/business-questions.md)
- [Q026: What is VeloGroup's Operating Income (EBIT)?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### P&L Hierarchy Determines Sign Convention

**Rule Type:** sign_convention
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md)
**Rule Logic:** Revenue values are stored as positive. COGS and expense values are stored as positive. The P&L hierarchy structure determines arithmetic: revenue accounts add, cost accounts subtract. Gross Margin = Net Revenue - COGS. The hierarchy is both the display structure and the calculation structure.

### Transactions Only Post to Leaf Accounts

**Rule Type:** hierarchy
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md)
**Rule Logic:** Financial transactions only post to leaf-level GL accounts (e.g., FPA1/022 Gross Revenue, FPA1/020 COGS, FPA1/033 Payroll). Parent nodes (e.g., FPA1/017 Gross Margin, FPA1/018 Operating Expense, FPA1/016 Operating Income) are calculated by summing children. No transaction is ever posted directly to a parent node.

## Data Conventions for This Entity

No data conventions directly affect this entity.
