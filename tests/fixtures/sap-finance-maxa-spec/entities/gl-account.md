---
type: entity
title: GL Account
entity_name: GLAccount
entity_slug: gl-account
description: General Ledger account used to classify financial transactions by type (revenue, cost, expense), organized in a parent-child P&L hierarchy that defines how leaf accounts roll up into subtotals from Gross Revenue through Net Income.
confidence: high
entity_type: domain_dimension
domain: finance
version: "1.0.0"
last_updated: 2026-05-28T00:00:00Z
relationships:
  - FinancialTransaction
tags: [chart-of-accounts, p-and-l-hierarchy, gl-classification, finance]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| referenced_by | [FinancialTransaction](/entities/financial-transaction.md) | Each financial transaction is classified by exactly one GL account that determines its P&L placement. GLAccount is a dimension of the central fact table. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `account_name` | STRING | Yes | Descriptive name of the GL account (e.g., 'Gross Revenue', 'COGS', 'Payroll'). Used for chart of accounts identification and P&L line labeling. | Q001, Q002, Q003, Q010, Q011, Q012, Q013 |
| `account_type_id` | STRING | Yes | Account type classification code (INC=Income, EXP=Expense, AST=Asset, LEQ=Liabilities & Equity, NFIN=Non-Financial). Determines the nature of the account for financial statement classification. | Q001, Q007, Q010, Q012 |
| `parent_account_id` | STRING | No | ID of the parent GL account in the P&L hierarchy. Null for the root node (Net Income). Enables P&L rollup construction from leaf accounts to subtotals. | Q001, Q002, Q003, Q010 |
| `hierarchy_level` | NUMBER | Yes | Depth level in the P&L hierarchy tree (1=root/Net Income, 6=leaf accounts). Distinguishes postable leaf accounts from rollup nodes. | Q001, Q002, Q012 |
| `is_leaf` | STRING | Yes | Whether this account is a leaf (postable) node or a rollup node. Only leaf accounts receive transaction postings. | Q001, Q002, Q010, Q011, Q012, Q013 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `defined_date` | DATETIME | Yes | Business date when the GL account was established in the chart of accounts. |
| `defined_date_timezone` | STRING | Yes | Timezone offset for the defined date, because timestamps [MUST] include timezone metadata to support cross-timezone data processing. |
| `updated_date` | DATETIME | Yes | Business date when the GL account was last updated. |
| `updated_date_timezone` | STRING | Yes | Timezone offset for the updated date, because timestamps [MUST] include timezone metadata to support cross-timezone data processing. |

## Supported Processes

- Chart of Accounts and P&L Hierarchy — GLAccount defines the P&L structure (levels 1–6) and determines how leaf accounts roll up into subtotals
- Financial Transaction Flow (Revenue/COGS) — Revenue and COGS transactions post to leaf-level GL accounts (FPA1/022, FPA1/023, FPA1/020)
- Financial Transaction Flow (OpEx) — Operating expense transactions post to leaf-level GL accounts under the Operating Expense rollup node (FPA1/018)
- P&L Consolidation and Reporting — GL account hierarchy drives the P&L statement structure from Gross Revenue through Net Income

## Supported Questions

- [Q001: What is the Gross Margin percentage?](/reference/business-questions.md)
- [Q002: What is the budget vs actual dollar variance for Gross Revenue?](/reference/business-questions.md)
- [Q003: What is the budget vs actual percentage variance for a given P&L line item?](/reference/business-questions.md)
- [Q004: What is the revenue by product line?](/reference/business-questions.md)
- [Q005: What percentage of total revenue does each individual customer represent?](/reference/business-questions.md)
- [Q006: Is the Youth bike line profitable on its own, or is it a loss leader?](/reference/business-questions.md)
- [Q007: Which channel is more profitable per unit — Speciality or Large?](/reference/business-questions.md)
- [Q010: What is the COGS ratio?](/reference/business-questions.md)
- [Q011: What is the total Gross Revenue?](/reference/business-questions.md)
- [Q012: What is the Net Revenue?](/reference/business-questions.md)
- [Q013: What is the total COGS?](/reference/business-questions.md)
- [Q014: What is the contribution margin by product line?](/reference/business-questions.md)
- [Q015: What is each profit center's share of total revenue?](/reference/business-questions.md)
- [Q019: What was the monthly revenue trend during 2020?](/reference/business-questions.md)
- [Q020: What is the e-bike revenue growth rate year-over-year?](/reference/business-questions.md)
- [Q022: Which customers rank highest by contribution to gross margin?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### Hierarchy-Driven P&L Arithmetic

**Rule Type:** hierarchy
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md)
**Rule Logic:** Revenue accounts add, cost accounts subtract. The P&L hierarchy (modeled as attributes on GLAccount) implicitly defines the arithmetic — parent node values are computed by summing or subtracting children based on their position in the hierarchy. Gross Margin = Net Revenue children minus COGS children.
**Supporting KPIs:** FKPI-04, FKPI-05, FKPI-08, FKPI-09

### Transactions Post Only to Leaf Accounts

**Rule Type:** hierarchy
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md)
**Rule Logic:** Financial transactions only post to leaf-level GL accounts (identified by `is_leaf` attribute on GLAccount). Parent/rollup nodes (e.g., Gross Margin FPA1/017, Operating Expense FPA1/018) are calculated by summing children — never posted to directly.

## Data Conventions for This Entity

- **Multilingual Text Tables with Language Filter**: Text tables store descriptions in multiple languages (EN, DE). Join on ID and filter LANGUAGE='EN' for English descriptions. When multiple language entries exist, the English-language variant [MUST] be used for reporting and analysis.
- **FPA1 Account Naming Convention**: GL accounts use FPA1/NNN format. FPA1 = Financial Planning and Analysis module 1 (BPC convention). Three digits are the account number within that module. Account IDs [MUST] be preserved in their original FPA1/NNN format — do not strip or reformat.
