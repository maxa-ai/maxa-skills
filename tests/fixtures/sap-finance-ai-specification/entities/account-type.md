---
type: entity
title: AccountType
entity_name: AccountType
entity_slug: account-type
description: A classification of General Ledger accounts into one of five accounting categories — Income, Expense, Assets, Liabilities & Equity, and Non-financial Income. Static reference data with five values.
confidence: high
entity_type: domain_dimension
domain: finance
version: "1.0.0"
last_updated: "2026-10-06T00:00:00Z"
relationships:
  - GLAccount
tags: [classification, reference-data, finance]
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
| classifies | [GLAccount](/entities/gl-account.md) | An account type classifies one or more GL accounts into one of five accounting categories. There are five account type values — Income (INC), Expense (EXP), Assets (AST), Liabilities & Equity (LEQ), and Non-financial Income (NFIN) — against a compact chart of 21 GL accounts. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|

AccountType has no core attributes because no business question directly references account-type-level data — it functions as a classification dimension for GL Account (the `account_type_id` and `account_type_name` attributes that carry this classification into reporting are core attributes of [GLAccount](/entities/gl-account.md), not of AccountType itself).

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `account_type_name` | STRING | Yes | Display name of the accounting classification category (e.g., Income, Expense, Assets, Liabilities & Equity, Non-financial Income). |
| `description` | STRING | No | Extended description of the account type's purpose and scope (e.g., "Statistical accounts — headcount, square footage, capacity metrics; non-monetary amounts used for allocation and reporting" for the Non-financial Income category). |
| `status` | STRING | Yes | Lifecycle status of the account type record (e.g., active, inactive). Classified as standard rather than core because AccountType has no supported business questions — per the entity-level classification rule, an entity with no directly supported questions has no core attributes. |
| `effective_date` | DATE | Yes | Operational business date when the account type classification record was loaded or became effective (YYYY-MM-DD). Account type records [MUST] carry an effective date establishing when the classification became effective, because reference data changes need a traceable effective-dated history even when changes are rare. |
| `effective_date_timezone` | STRING | Yes | Timezone offset paired with `effective_date` (e.g., +00:00). Account type records [MUST] carry an explicit timezone offset alongside every operational date so that date comparisons remain unambiguous across reporting regions. |

## Supported Processes

- Master Data Governance
- P&L Consolidation Reporting

## Supported Questions

AccountType has no directly supported business questions. It is retained as a classification entity because it groups the 21 GL accounts into five accounting categories (Income, Expense, Assets, Liabilities & Equity, Non-financial Income) that determine how each account behaves in P&L, balance sheet, and cash flow reporting. Questions that rely on this classification (e.g., isolating Income accounts for Gross Revenue, or identifying the Non-financial Income statistical accounts used in cost allocation) are answered through the denormalized `account_type_id` and `account_type_name` attributes carried on [GLAccount](/entities/gl-account.md), not through AccountType directly.

## Business Rules Affecting This Entity

No business rules directly affect this entity.

## Data Conventions for This Entity

No data conventions directly affect this entity.
