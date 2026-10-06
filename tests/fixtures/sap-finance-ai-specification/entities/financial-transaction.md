---
type: entity
title: FinancialTransaction
entity_name: FinancialTransaction
entity_slug: financial-transaction
description: An aggregated financial posting recorded in the general ledger at the dimensional grain of GL account, customer, product, profit center, version, and date. Covers both Actual and Budget versions and is immutable once posted.
confidence: high
entity_type: transactional
domain: finance
version: "1.0.0"
last_updated: "2026-10-05T20:33:03Z"
relationships:
  - GLAccount
  - Customer
  - Product
  - ProfitCenter
tags: [finance, financial-transaction, gl-posting, pl-hierarchy, budget-actual]
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
| references | [GLAccount](/entities/gl-account.md) | Each posting classifies itself via a GL account, which determines its placement in the P&L hierarchy (e.g., Gross Revenue, COGS, Payroll). |
| references | [Customer](/entities/customer.md) | Identifies the B2B customer for revenue and COGS postings. [MUST] be set to the unassigned sentinel value for Operating Expense postings, which are organizational costs not tied to a specific customer. |
| references | [Product](/entities/product.md) | Identifies the product for revenue and COGS postings. [MUST] be set to the unassigned sentinel value for Operating Expense postings. |
| references | [ProfitCenter](/entities/profit-center.md) | Organizational unit responsible for the posting — present on every transaction regardless of account type, since it is the primary management reporting dimension. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `gl_account_id` | STRING | Yes | Foreign key to [GLAccount](/entities/gl-account.md). Classifies the posting within the chart of accounts (e.g., Gross Revenue, COGS) and determines its placement in the P&L hierarchy. | Q003, Q009, Q019 |
| `customer_id` | STRING | Yes | Foreign key to [Customer](/entities/customer.md). Identifies the B2B customer for this posting. [MUST] be set to the unassigned sentinel value ('#') for Operating Expense postings, which are organizational costs rather than customer-specific. | Q006, Q012, Q016, Q024 |
| `product_id` | STRING | Yes | Foreign key to [Product](/entities/product.md). Identifies the product for this posting. [MUST] be set to the unassigned sentinel value ('#') for Operating Expense postings, which are organizational costs rather than product-specific. | Q003, Q024 |
| `profit_center_id` | STRING | Yes | Foreign key to [ProfitCenter](/entities/profit-center.md). Identifies the organizational unit responsible for this posting — present on every transaction regardless of account type, since profit center is the primary management reporting dimension. | Q024 |
| `version` | STRING | Yes | Discriminates between Actual and Budget postings. [MUST] be used to separate actual amounts from budget amounts whenever computing budget-vs-actual variance. | Q002, Q010, Q011 |
| `amount` | NUMERIC | Yes | Monetary value of the posting at the dimensional grain. The source system stores this value as text using European-style comma decimal formatting (e.g., "12734,04" = $12,734.04) — [MUST] be parsed into a numeric value with the decimal-separator conversion applied before use. This attribute underlies virtually every financial calculation (revenue, COGS, margin, variance). | Q001, Q002, Q003, Q006, Q007, Q009, Q012, Q013, Q016, Q017, Q018, Q019, Q020, Q021, Q024, Q025, Q026, Q027 |
| `posting_date` | DATE | Yes | Business date of the posting. The source system stores this as an 8-digit integer in YYYYMMDD format (e.g., 20210101 = January 1, 2021) — [MUST] be parsed into a proper date value. This is the primary date for period assignment and time-series analysis. | Q017, Q018 |
| `customer_segment_id` | STRING | Yes | Denormalized foreign key to the customer's segment, carried directly on the posting so segment-level analysis (e.g., Speciality vs. Large vs. Medium) does not require an additional join back to Customer. | Q006, Q027 |
| `product_category_id` | STRING | Yes | Denormalized foreign key to the product's category, carried directly on the posting so product-line analysis (e.g., Cruise, Mountain, Racing, Youth) does not require an additional join back to Product. | Q003 |
| `country` | STRING | Yes | Denormalized country of the customer, carried directly on the posting to enable geographic (US vs. Canada) revenue analysis without a join back to Customer. | Q012 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `gl_account_name` | STRING | Yes | Denormalized GL account description, carried directly on the posting for readability without a join back to GLAccount (e.g., "Gross Revenue", "Cost of Goods Sold", "Payroll"). |
| `customer_name` | STRING | Yes | Denormalized customer display name, carried directly on the posting for readability. Set to the unassigned sentinel value ('#') when the posting has no customer attribution. |
| `product_name` | STRING | Yes | Denormalized product display name, carried directly on the posting for readability. Set to the unassigned sentinel value ('#') when the posting has no product attribution. |
| `profit_center_name` | STRING | Yes | Denormalized profit center description, carried directly on the posting for readability. |
| `posting_date_timezone` | STRING | Yes | Timezone offset associated with the posting date. |
| `posting_type` | STRING | Yes | Semantic sub-type of the posting (e.g., revenue, COGS, cost allocation, adjusting entry, accrual). Distinguishes posting categories within a single unified transaction record rather than requiring a separate structure per sub-type. |
| `customer_segment_name` | STRING | Yes | Denormalized segment description, carried directly on the posting for readability (e.g., Speciality, Large, Medium). |
| `product_category_name` | STRING | Yes | Denormalized category description, carried directly on the posting for readability (e.g., Cruise, Mountain, Racing, Youth). |

## Supported Processes

- P&L Consolidation Reporting
- Budget vs Actual Variance Analysis
- Annual Budget Process
- FX Handling
- Fiscal Calendar
- Cost Allocation
- Financial Transaction Flow
- Month-End Close

## Supported Questions

- [Q001: What is the Gross Margin percentage for VeloGroup?](/reference/business-questions.md)
- [Q002: What is the dollar variance between budget and actual for Net Income?](/reference/business-questions.md)
- [Q003: What percentage of total financial transactions belong to the Cruise product line?](/reference/business-questions.md)
- [Q006: What percentage of financial transactions are Speciality (Z1) customer transactions?](/reference/business-questions.md)
- [Q007: Is the Youth bike line profitable on its own, or is it a loss leader?](/reference/business-questions.md)
- [Q009: What percentage of all transactions are COGS?](/reference/business-questions.md)
- [Q010: What is the total number of financial transactions (Actual + Budget)?](/reference/business-questions.md)
- [Q011: How many budget transactions vs actual transactions are there?](/reference/business-questions.md)
- [Q012: What percentage of total revenue is from US customers vs Canadian customers?](/reference/business-questions.md)
- [Q013: What is the COGS ratio (COGS divided by Net Revenue)?](/reference/business-questions.md)
- [Q016: Does any single customer represent more than 15% of total revenue?](/reference/business-questions.md)
- [Q017: What is the revenue trend by product line across 2018–2021?](/reference/business-questions.md)
- [Q018: What is the monthly trend of Gross Margin with year-over-year comparison?](/reference/business-questions.md)
- [Q019: How many Gross Revenue transactions are there?](/reference/business-questions.md)
- [Q020: What is each profit center's share of total revenue?](/reference/business-questions.md)
- [Q021: What is the Operating Expense total, split by Building vs Employee categories?](/reference/business-questions.md)
- [Q023: What is the current month-end close cycle time?](/reference/business-questions.md)
- [Q024: Which profit centers have OpEx transactions that are not customer- or product-specific?](/reference/business-questions.md)
- [Q025: What is VeloGroup's Net Income (bottom line P&L)?](/reference/business-questions.md)
- [Q026: What is VeloGroup's Operating Income (EBIT)?](/reference/business-questions.md)
- [Q027: What is the Gross Margin by customer segment?](/reference/business-questions.md)

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

### Fiscal Calendar — Calendar Year

**Rule Type:** temporal_rule
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md)
**Rule Logic:** Fiscal year runs on calendar year basis: January 1 through December 31. Monthly reporting periods. No 4-4-5 calendar, no offset fiscal year.

### Profit Center as Primary Management Reporting Dimension

**Rule Type:** hierarchy
**Affected Entities:** [Division](/entities/division.md), [FinancialTransaction](/entities/financial-transaction.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Profit center is the primary management reporting dimension. When the CFO asks 'how is Cruise doing?' the answer comes from profit centers under Cruise, not the product category. Profit centers capture both product line and channel (Large vs Speciality). Hierarchy: Division → Product Line → Channel.

### Budget Validation — Totals Must Tie to Approved Numbers

**Rule Type:** reconciliation
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md)
**Rule Logic:** After loading budget data into SAP BPC, the loaded totals [MUST] tie to Karen Liu's approved numbers to the penny before sign-off. This is an explicit validation gate.

### Single Currency Reporting — USD at Posting Rate

**Rule Type:** temporal_rule
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md)
**Rule Logic:** All financial transactions reported in USD. Canadian dollar transactions converted to USD equivalent at the posting rate recorded by SAP at transaction time. Primary currency is USD; all products priced in USD.

## Data Conventions for This Entity

- **European Comma Decimal Formatting**: VALUE column stored as VARCHAR with comma as decimal separator. '12734,04' = $12,734.04. Negative values use minus prefix '-5432,10'. No thousands separator.
- **Dates Stored as BIGINT YYYYMMDD**: Date field stored as BIGINT in YYYYMMDD format. 20210101 = January 1, 2021. No separators, no time component.
