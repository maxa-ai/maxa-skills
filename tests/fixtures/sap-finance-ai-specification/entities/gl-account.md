---
type: entity
title: GL Account
entity_name: GLAccount
entity_slug: gl-account
description: A General Ledger account in VeloGroup's chart of accounts that classifies financial transactions by type; leaf accounts receive postings while rollup nodes are calculated aggregations in the P&L hierarchy.
confidence: high
entity_type: domain_dimension
domain: finance
version: "1.0.0"
last_updated: "2026-10-06T00:45:00Z"
relationships:
  - AccountType
  - GLAccountHierarchyNode
tags: [finance, chart-of-accounts, pl-hierarchy, domain-dimension]
sources:
  - VeloGroup-Maxa-Project-Kick-Off.md
  - VeloGroup-Maxa-FPA-Workshop.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| many_to_one | [AccountType](/entities/account-type.md) | Each GL account belongs to one account type (INC, EXP, AST, LEQ, NFIN) that classifies it as income, expense, asset, liability/equity, or non-financial for P&L reporting purposes. |
| one_to_one | [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) | Each GL account has a corresponding position in the P&L hierarchy tree that defines its rollup path for financial statement consolidation. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `account_type_id` | STRING | Yes | FK to [AccountType](/entities/account-type.md) — classifies this GL account by accounting category (INC, EXP, AST, LEQ, NFIN). Enables cross-entity analysis to separate income from expense accounts for Gross Margin, COGS ratio, and P&L computations. | Q001, Q009, Q013, Q025, Q026 |
| `status` | STRING | Yes | Lifecycle status of the GL account (e.g., active, inactive). The status [MUST] be current to determine the accurate chart of accounts composition used for account counts and reporting scope. | Q008 |
| `gl_account_hierarchy_node_id` | STRING | Yes | FK to [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) — the position of this GL account in the P&L hierarchy tree. Essential for traversing the rollup structure to compute Gross Margin, EBIT, Net Income, and Operating Expense splits. | Q001, Q009, Q013, Q021, Q025, Q026, Q027 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `gl_account_name` | STRING | Yes | Descriptive display name of the GL account in the chart of accounts (e.g., "Gross Revenue", "COGS", "Payroll"). An industry-expected attribute for every chart of accounts entry. |
| `account_type_name` | STRING | Yes | Denormalized display name of the account type (e.g., "Income", "Expense", "Assets"), carried directly on this record so it can be read without a separate lookup against AccountType. |
| `effective_date` | DATE | Yes | Operational business date when the GL account was added to (or last changed in) the chart of accounts (YYYY-MM-DD). |
| `effective_date_timezone` | STRING | Yes | Timezone offset for `effective_date` in +/-HH:MM format, needed to interpret the business date unambiguously across regions. |

## Supported Processes

- P&L Consolidation Reporting
- Master Data Governance
- Financial Transaction Flow

## Supported Questions

- [Q001: What is the Gross Margin percentage for VeloGroup (Net Revenue minus COGS divided by Net Revenue)?](/reference/business-questions.md)
- [Q002: What is the dollar variance between budget and actual for Net Income?](/reference/business-questions.md)
- [Q008: How many GL accounts are in the chart of accounts?](/reference/business-questions.md)
- [Q009: What percentage of all transactions are COGS (FPA1/020)?](/reference/business-questions.md)
- [Q013: What is the COGS ratio (COGS divided by Net Revenue)?](/reference/business-questions.md)
- [Q019: How many Gross Revenue transactions (FPA1/022) are there?](/reference/business-questions.md)
- [Q021: What is the Operating Expense total, split by Building vs Employee categories?](/reference/business-questions.md)
- [Q025: What is VeloGroup's Net Income (bottom line P&L)?](/reference/business-questions.md)
- [Q026: What is VeloGroup's Operating Income (EBIT)?](/reference/business-questions.md)
- [Q027: What is the Gross Margin by customer segment (Speciality vs Large vs Medium)?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### P&L Hierarchy Determines Sign Convention

**Rule Type:** sign_convention
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md)
**Rule Logic:** Revenue values are stored as positive. COGS and expense values are stored as positive. The P&L hierarchy structure determines arithmetic: revenue accounts add, cost accounts subtract. Gross Margin = Net Revenue - COGS. The hierarchy is both the display structure and the calculation structure.

### Transactions Only Post to Leaf Accounts

**Rule Type:** hierarchy
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md)
**Rule Logic:** Financial transactions only post to leaf-level GL accounts (e.g., FPA1/022 Gross Revenue, FPA1/020 COGS, FPA1/033 Payroll). Parent nodes (e.g., FPA1/017 Gross Margin, FPA1/018 Operating Expense, FPA1/016 Operating Income) are calculated by summing children. No transaction is ever posted directly to a parent node.

### Dimensional Grain Varies by Account Type

**Rule Type:** hierarchy
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Revenue (FPA1/022, FPA1/023) and COGS (FPA1/020) are tracked at full grain: customer × product × profit center. Operating expenses (FPA1/028–035) are at profit center level only, with CUSTOMERID=# and PRODUCTID=# because OpEx is organizational cost, not customer/product-specific.

## Data Conventions for This Entity

- **Multilingual Text Tables (EN/DE)**: Text tables store descriptions in multiple languages (EN, DE). Filter on LANGUAGE='EN' for English descriptions. Some entities have both EN and DE records (explains row count mismatch vs master tables).
- **FPA1 Prefix for GL Account IDs**: Account IDs follow FPA1/NNN pattern. FPA1 = Financial Planning and Analysis module 1 (BPC convention). Three digits after slash are the account number.
- **Hierarchy Level Numbering (Root=1)**: In GL hierarchy, Level 1 is root (Net Income), higher numbers are more granular. Parent-child adjacency list with HIERARCHYID, DESCRIPTION, and LEVEL fields.
- **Account Type Codes**: Five account types: INC (Income/Revenue), EXP (Expense), AST (Assets), LEQ (Liabilities & Equity), NFIN (Non-financial Income — statistical accounts for headcount, square footage, capacity).
