---
type: modeling_decisions
title: Modeling Decisions
description: Entity modeling decisions for the VeloGroup ERE model — 6 entities modeled, 6 entities discarded (absorbed as attributes), and 7 attribute classifications governing the data model structure.
confidence: high
timestamp: 2026-07-15T16:00:00Z
entities_modeled: 6
entities_discarded: 6
attributes_classified: 7
tags: [modeling-decisions, entity-model, grain, hierarchy, attributes]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Modeling Decisions

## Key Decisions

### 1. Single Transactional Entity

[FinancialTransaction](/entities/financial-transaction.md) is the sole transactional entity. VeloGroup's data centers on a single fact table with 167,136 rows at the grain of account × customer × product × profit center × version × date. Both Actual and Budget versions share the same grain and structure. This entity serves 12 of 25 business questions directly.

### 2. GLAccount Absorbs Hierarchy

The GL Accounts Hierarchy has exactly 21 rows — the same 21 as the [GLAccount](/entities/gl-account.md) master. Each GL account IS a node in the P&L hierarchy. Rather than maintaining a separate hierarchy entity, the hierarchy metadata (`parent_account_id`, `hierarchy_level`, `is_leaf`) is modeled as attributes on GLAccount.

### 3. Type/Category Entities Demoted to Attributes

Three draft entities were demoted to classification attributes on their parent entities:

| Demoted Entity | Rows | Absorbed Into | Attribute |
|---------------|------|---------------|-----------|
| GLAccountType | 5 | [GLAccount](/entities/gl-account.md) | `account_type_id` |
| CustomerType | 4 | [Customer](/entities/customer.md) | `customer_type_id` |
| ProductCategory | 8 | [Product](/entities/product.md) | `product_category_id` |

These classification codes have no independent lifecycle. In every business question that references them, the answer comes from filtering or grouping on the parent entity's attribute.

### 4. Three Hierarchy Entities Discarded

| Hierarchy | Rows | Reason |
|-----------|------|--------|
| CustomersHierarchy | 56 | No business question requires customer hierarchy traversal |
| ProductHierarchy | 43 | No business question requires product hierarchy traversal |
| ProfitCenterHierarchy | 60 | Hierarchy metadata carried as attributes on [ProfitCenter](/entities/profit-center.md) |

### 5. FiscalCalendar Added as Implied Entity

No draft entity existed, but the fiscal calendar process is in-scope and 5 business questions depend on fiscal period definitions. [FiscalCalendar](/entities/fiscal-calendar.md) is modeled as a domain_dimension entity in the finance domain. Several operational process questions (close duration, budget cycle, extraction time) are answered via FiscalCalendar attributes rather than requiring separate entities.

### 6. Operational Process Questions Answered via Entity Attributes

Questions about close duration (Q003), budget cycle (Q005), extraction time (Q006), time savings (Q014), and P&L build time (Q015) reference known constants from workshop transcripts — stored as configuration attributes on [FiscalCalendar](/entities/fiscal-calendar.md) rather than modeled as separate entities.

## Entity Inventory

| ERE Entity | Type | Domain | Draft Entities Absorbed |
|------------|------|--------|------------------------|
| [FinancialTransaction](/entities/financial-transaction.md) | transaction | finance | FinancialTransaction |
| [Customer](/entities/customer.md) | master_data | mdm | Customer |
| [Product](/entities/product.md) | master_data | mdm | Product |
| [ProfitCenter](/entities/profit-center.md) | master_data | mdm | ProfitCenter |
| [GLAccount](/entities/gl-account.md) | domain_dimension | finance | GLAccount, GLAccountsHierarchy |
| [FiscalCalendar](/entities/fiscal-calendar.md) | domain_dimension | finance | (new — implied) |

## Attribute Classifications

| Attribute | Parent Entity | Questions | Reasoning |
|-----------|--------------|-----------|-----------|
| `account_type_id` | GLAccount | Q012, Q025 | 5-value enum, no lifecycle |
| `customer_type_id` | Customer | Q016, Q021 | 4-value enum (Z1/Z2/Z3/#) |
| `product_category_id` | Product | Q017, Q022 | 8-value enum (CR/MT/RC/YH/FG/TM/RB/#) |
| `parent_account_id` | GLAccount | Q002, Q012 | Absorbed from hierarchy |
| `hierarchy_level` | GLAccount | Q002, Q012 | Absorbed from hierarchy |
| `country` | Customer | Q011 | Geographic classification (US/Canada) |
| `version` | FinancialTransaction | Q013 | Actual vs Budget discriminator |

## Question Coverage

All 25 business questions are covered by the 6-entity model. See [Scope Map](/scope-map.md) for the complete question-to-process mapping and [Business Questions](/reference/business-questions.md) for individual question details.
