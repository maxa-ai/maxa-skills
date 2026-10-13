---
type: specialized_instructions
title: Specialized Instructions
description: Project-specific computation recipes, implementation checklists, and entity relationship patterns for VeloGroup International's FP&A analytics platform, synthesized from the Maxa AI Specification content.
confidence: high
timestamp: "2026-10-06T02:00:00Z"
tags: [specialized_instructions]
---

# Specialized Instructions

This file contains project-specific procedural knowledge for VeloGroup International's FP&A analytics platform — a B2B cycling manufacturer/distributor built on SAP FI financial data. Every instruction below is grounded in a specific AI specification file.

## Computation Recipes

### Gross Revenue (FKPI-01)

1. Source: `FinancialTransaction` entity, `amount` attribute, filtered to `gl_account_id = FPA1/022` (the Gross Revenue leaf account).
2. Filter to `version = 'Actual'` for actuals, or `version = 'Budget'` for budget figures — `version` is the Actual/Budget discriminator.
3. Parse `amount`: the source stores it as text with European comma-decimal formatting (e.g., `"12734,04"` = $12,734.04); it [MUST] be converted to numeric before summation.
4. Aggregate: SUM(amount) across the dimensional grain (customer × product × profit center).

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-01, [FinancialTransaction](/entities/financial-transaction.md) > Core Attributes (`amount`, `gl_account_id`, `version`), Data Conventions (European Comma Decimal Formatting).

### Net Revenue (FKPI-02)

1. Net Revenue = SUM(Gross Revenue, FPA1/022) − SUM(Sales Deductions, FPA1/023).
2. Net Revenue is calculated node FPA1/021 — it is **not** a leaf account, and no transaction ever posts directly to it. It [MUST] be computed as a hierarchy rollup, never looked up as a stored value.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-02, [GLAccount](/entities/gl-account.md) > Business Rules (Transactions Only Post to Leaf Accounts).

### COGS (FKPI-03)

1. SUM(amount) for `gl_account_id = FPA1/020`.
2. COGS is tracked at full dimensional grain (customer × product × profit center) — the same grain as revenue.
3. COGS represents approximately 75% of all transaction volume (source type: `stakeholder_statement` — unverified approximation, use for order-of-magnitude validation only), because it is posted at the most granular customer-product-profit center combination for every sale.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-03, [Business Questions](/reference/business-questions.md) > Q009, [FinancialTransaction](/entities/financial-transaction.md) > Business Rules (Dimensional Grain Varies by Account Type).

### Gross Margin (FKPI-04)

1. Gross Margin = Net Revenue − COGS = (FPA1/022 − FPA1/023) − FPA1/020.
2. Calculated node FPA1/017.
3. Sign convention: revenue values and COGS/expense values are both stored as positive; the P&L hierarchy structure (not the sign of the stored value) determines whether an account adds or subtracts — revenue accounts add, cost accounts subtract.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-04, [FinancialTransaction](/entities/financial-transaction.md) > Business Rules (P&L Hierarchy Determines Sign Convention).

### Gross Margin % (FKPI-05)

1. Gross Margin % = (Net Revenue − COGS) / Net Revenue × 100.
2. This is the CFO's #1 priority KPI; a slipping Gross Margin % [SHOULD] be treated as a signal requiring investigation of either a cost problem or a pricing problem.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-05.

### Budget vs Actual Variance — $ and % (FKPI-06)

1. Dollar variance = Actual − Budget.
2. Percentage variance = (Actual − Budget) / Budget × 100.
3. Variance [MUST] be computed for all P&L line items, both leaf and calculated/rollup nodes, using the `version` attribute on `FinancialTransaction` to separate Actual from Budget postings before differencing.
4. Supports cross-dimensional drill-down by product line, customer type, and profit center.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-06, [FinancialTransaction](/entities/financial-transaction.md) > Core Attributes (`version`).

### Operating Expense Total (FKPI-07)

1. OpEx Total = SUM of all Operating Expense accounts: Building Expense (FPA1/028, FPA1/029, under node FPA1/024) + Employee Expense (FPA1/032–035, under node FPA1/026) + Other Operating Expense (FPA1/027; specific leaf accounts not documented in this Maxa spec).
2. Calculated node FPA1/018.
3. Dimensional grain: profit center only. `customer_id` and `product_id` [MUST] be the unassigned sentinel (`#`) for these postings, because Operating Expense is an organizational cost, not customer- or product-specific — [MUST NOT] be filtered out as invalid.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-07, [FinancialTransaction](/entities/financial-transaction.md) > Business Rules (Dimensional Grain Varies by Account Type), [Customer](/entities/customer.md) > Data Conventions (Hash (#) Means Unassigned Dimension).

### EBIT / Operating Income (FKPI-08)

1. Operating Income = Gross Margin − Operating Expense, hierarchy node FPA1/016, rolling up to EBIT at FPA1/09.
2. Stakeholders use "EBIT" and "Operating Income" interchangeably; in the 21-account hierarchy with no distinct interest or tax leaf accounts, EBIT is functionally equivalent to Operating Income. EBITDA is not a tracked KPI in this project.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-08.

### Net Income (FKPI-09)

1. Net Income is the root node of the P&L hierarchy, FPA1/08 (Level 1) — the rollup of all income and expense accounts beneath it.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-09.

### COGS Ratio (FKPI-10)

1. COGS Ratio = COGS / Net Revenue × 100.
2. This is the inverse framing of Gross Margin %, for analysts who prefer viewing cost as a percentage of revenue rather than margin as a percentage of revenue.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-10.

### Revenue by Product Line (FKPI-11)

1. SUM(Gross Revenue, FPA1/022), grouped by product line via the `ProfitCenter` hierarchy or via `ProductCategory`.
2. Product lines: Cruise, Mountain, Racing, Youth.
3. This differs from Product Mix (KPI-02): Revenue by Product Line tracks absolute revenue amounts to show growth/flat/decline trends; Product Mix computes percentage composition.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-11, [ProfitCenter](/entities/profit-center.md), [ProductCategory](/entities/product-category.md).

### Amount Field Parsing (cross-cutting)

1. The `amount` field on `FinancialTransaction` is stored as VARCHAR text using a comma as the decimal separator and no thousands separator (e.g., `"12734,04"` = $12,734.04; negative values use a minus prefix, e.g., `"-5432,10"`).
2. This conversion [MUST] be applied before any aggregation, comparison, or ranking operation on `amount` — it underlies virtually every financial calculation in this project.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Data Conventions (European Comma Decimal Formatting).

### Posting Date Parsing (cross-cutting)

1. The `posting_date` field is stored as a BIGINT in YYYYMMDD format (e.g., `20210101` = January 1, 2021), with no separators and no time component.
2. This [MUST] be parsed into a proper date value before any period assignment or time-series computation (e.g., Monthly Revenue Trend, Gross Margin monthly trend).

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Data Conventions (Dates Stored as BIGINT YYYYMMDD).

### Transaction Volume by Account Type (KPI-01)

1. COUNT(transactions) grouped by GL account type (`account_type_id`: INC, EXP, AST, LEQ, NFIN) and by individual `gl_account_id`.
2. Filter to `version = 'Actual'` when tracking real anomaly signals (per the KPI's stated use for spotting business-change anomalies).
3. Known benchmark shares (source type: `stakeholder_statement` for the COGS and Gross Revenue percentages — unverified approximations, use for order-of-magnitude validation only): COGS (FPA1/020) ≈ 75% of transactions; Gross Revenue (FPA1/022) ≈ 18%; Sales Deductions (FPA1/023) ≈ 5%.

**Grounded in:** [Operational KPIs](/kpis/operational-kpis.md) > KPI-01, [Business Questions](/reference/business-questions.md) > Q009, Q019.

### Product Mix (KPI-02)

1. Product Mix % = SUM(Gross Revenue) per product line / SUM(Gross Revenue) total × 100.
2. Requires a join: `FinancialTransaction` → `Product` → `ProductCategory` (or using the denormalized `product_category_id`/`product_category_name` already carried on `FinancialTransaction`).
3. Cruise transaction share ≈ 30% (source type: `stakeholder_statement` — unverified approximation, use for order-of-magnitude validation only; this is a transaction-count share, not a revenue share).

**Grounded in:** [Operational KPIs](/kpis/operational-kpis.md) > KPI-02, [Business Questions](/reference/business-questions.md) > Q003, [FinancialTransaction](/entities/financial-transaction.md) > Core Attributes (`product_category_id`).

### Customer Concentration — Top 10 as % of Revenue (KPI-03)

1. Customer Concentration % = SUM(Gross Revenue for top 10 customers) / SUM(Gross Revenue total) × 100.
2. Requires a join: `FinancialTransaction` → `Customer`.
3. Target: no single customer [SHOULD NOT] exceed 15% of total revenue — the CFO's stated concentration threshold (source type: `stakeholder_statement` — unverified approximation; the current value for any specific customer against this threshold was not stated in this Maxa spec and [MUST NOT] be inferred).
4. Note: transaction share does not equal revenue share — Speciality shops have higher transaction counts but may have lower per-transaction value than Large customers who place fewer, larger orders.

**Grounded in:** [Operational KPIs](/kpis/operational-kpis.md) > KPI-03, [Business Questions](/reference/business-questions.md) > Q016.

### Profit Center Contribution — % of Total Revenue (KPI-04)

1. Profit Center Contribution % = SUM(Revenue for profit center) / SUM(Revenue total) × 100.
2. Requires grouping `FinancialTransaction` by `ProfitCenter`.
3. Classified as operational (not financial) because it analyzes organizational composition rather than a P&L line item — revenue is the denominator for an organizational-contribution lens, not a P&L output.

**Grounded in:** [Operational KPIs](/kpis/operational-kpis.md) > KPI-04, [ProfitCenter](/entities/profit-center.md).

### Monthly Revenue Trend with YoY Comparison (KPI-05)

1. SUM(Gross Revenue) per month, compared to the same calendar month in the prior year.
2. Use `posting_date` (parsed per the Posting Date Parsing recipe above) for period assignment; fiscal year = calendar year (Jan 1 – Dec 31), 12 monthly periods, no 4-4-5 or offset calendar.
3. Note 2020 seasonality: Q2 dipped (COVID shutdown), then Q3–Q4 surged — the annual total alone does not reveal this pattern; monthly granularity is required.

**Grounded in:** [Operational KPIs](/kpis/operational-kpis.md) > KPI-05, [Fiscal Calendar](/reference/fiscal-calendar.md) > Fiscal Year, Period Mapping.

---

## Implementation Checklist

### FinancialTransaction

- [ ] `amount` parsed from European comma-decimal text format before any numeric operation (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Data Conventions > European Comma Decimal Formatting)
- [ ] `posting_date` parsed from BIGINT YYYYMMDD format before any date/period operation (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Data Conventions > Dates Stored as BIGINT YYYYMMDD)
- [ ] Revenue/COGS postings carry full grain (customer × product × profit center); OpEx postings carry profit center only with `customer_id`/`product_id` = `#` — do not treat `#` rows as invalid or filter them out (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Dimensional Grain Varies by Account Type)
- [ ] Aggregations use leaf-level GL accounts only — no transaction ever posts to a parent/rollup node (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Transactions Only Post to Leaf Accounts)
- [ ] `version` attribute used to separate Actual from Budget before computing any variance (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Core Attributes > `version`)
- [ ] Fiscal period assignment uses calendar-year boundaries (Jan 1–Dec 31), not a 4-4-5 or offset calendar (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Fiscal Calendar — Calendar Year)
- [ ] All monetary values treated as single-currency USD — no FX conversion logic needed, since CAD is already converted to USD at posting rate in the source extract (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Single Currency Reporting — USD at Posting Rate)
- [ ] Budget totals validated to tie to approved numbers before sign-off, if loading new budget data (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Budget Validation — Totals Must Tie to Approved Numbers)

### Customer

- [ ] `country` populated for every customer record before computing US vs. Canada revenue splits (grounded in: [Customer](/entities/customer.md) > Core Attributes > `country`)
- [ ] `#` (unassigned) `customer_id` values on transactions [MUST NOT] be filtered out — they represent legitimate OpEx postings, not missing data (grounded in: [Customer](/entities/customer.md) > Data Conventions > Hash (#) Means Unassigned Dimension)
- [ ] Text/description lookups filtered to `LANGUAGE='EN'` to avoid duplicate EN/DE rows (grounded in: [Customer](/entities/customer.md) > Data Conventions > Multilingual Text Tables)
- [ ] `status` current/accurate before computing customer counts (grounded in: [Customer](/entities/customer.md) > Core Attributes > `status`)
- [ ] Customer segment classification (Z1=Speciality, Z2=Large, Z3=Medium) treated as a persistent business decision independent of source system (grounded in: [Customer](/entities/customer.md) > Business Rules > Customer Segment Definitions)

### CustomerSegment

- [ ] Segment record `status` = active before including it in transaction-share or revenue-mix analysis by tier (grounded in: [CustomerSegment](/entities/customer-segment.md) > Core Attributes > `status`)
- [ ] Z-prefix codes (Z1/Z2/Z3) recognized as customer-defined (non-SAP-standard) namespace values (grounded in: [CustomerSegment](/entities/customer-segment.md) > Data Conventions > Z Prefix for Custom Namespace)

### CustomerHierarchyNode

- [ ] Null `parent_customer_hierarchy_node_id` expected and valid for the root node — not treated as a data-quality defect (grounded in: [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) > Standard Attributes > `parent_customer_hierarchy_node_id`)
- [ ] `is_leaf` used to distinguish individual customer placements from type/geography grouping nodes before aggregation (grounded in: [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) > Standard Attributes > `is_leaf`)
- [ ] Detailed parent-child node identifiers for the 56-row hierarchy are not fully documented in this Maxa spec (confidence: medium) — do not infer specific node IDs beyond type (Speciality/Large/Medium) and geography (US/Canada) groupings (grounded in: [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) > Supported Questions > Known gap)

### Division

- [ ] Division retained in any model despite having zero directly-supported business questions — it is the required parent of `ProfitCenter` and provides top-level organizational context (grounded in: [Modeling Decisions](/modeling-decisions.md) > Division Retained Despite Zero Direct Questions)
- [ ] Profit center analysis treats `ProfitCenter`, not `Division` or `ProductCategory`, as the primary management reporting lens (grounded in: [Division](/entities/division.md) > Business Rules > Profit Center as Primary Management Reporting Dimension)

### GLAccount

- [ ] `gl_account_hierarchy_node_id` resolved via `GLAccountHierarchyNode` before computing Gross Margin, EBIT, Net Income, or OpEx splits — these require hierarchy traversal, not a flat GL account filter alone (grounded in: [GLAccount](/entities/gl-account.md) > Core Attributes > `gl_account_hierarchy_node_id`)
- [ ] `account_type_id` used to separate income from expense accounts for P&L computations (grounded in: [GLAccount](/entities/gl-account.md) > Core Attributes > `account_type_id`)
- [ ] Only leaf-level accounts (per `GLAccountHierarchyNode.is_leaf`) included when summing transaction amounts — rollup accounts [MUST NOT] double-count (grounded in: [GLAccount](/entities/gl-account.md) > Business Rules > Transactions Only Post to Leaf Accounts)
- [ ] `status` current before computing chart-of-accounts counts (grounded in: [GLAccount](/entities/gl-account.md) > Core Attributes > `status`; [Modeling Decisions](/modeling-decisions.md) > Refinement Corrections Applied)
- [ ] Account IDs recognized under the `FPA1/NNN` naming pattern (FPA1 = Financial Planning and Analysis module 1, BPC convention) (grounded in: [GLAccount](/entities/gl-account.md) > Data Conventions > FPA1 Prefix for GL Account IDs)
- [ ] Text/description lookups filtered to `LANGUAGE='EN'` to avoid duplicate EN/DE rows (grounded in: [GLAccount](/entities/gl-account.md) > Data Conventions > Multilingual Text Tables)

### GLAccountHierarchyNode

- [ ] `is_leaf` checked before aggregating — leaf nodes receive direct postings, rollup nodes are calculated by summing children (grounded in: [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) > Core Attributes > `is_leaf`)
- [ ] Null `parent_gl_account_hierarchy_node_id` expected and valid for the root node (Net Income) (grounded in: [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) > Core Attributes > `parent_gl_account_hierarchy_node_id`)
- [ ] Hierarchy level numbering treated as root = Level 1 (Net Income), with higher numbers representing more granular nodes (grounded in: [GLAccount](/entities/gl-account.md) > Data Conventions > Hierarchy Level Numbering)
- [ ] Sign convention applied by hierarchy position, not by stored sign — revenue nodes add, cost nodes subtract (grounded in: [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) > Business Rules > P&L Hierarchy Determines Sign Convention)

### Product

- [ ] `#` (unassigned) `product_id` values on OpEx transactions [MUST NOT] be filtered out — they are legitimate, not missing data (grounded in: [Product](/entities/product.md) > Data Conventions > Hash (#) Means Unassigned Dimension)
- [ ] `price` sourced from the product master record, not inferred or recalculated, for price ranking/lookup questions (grounded in: [Product](/entities/product.md) > Core Attributes > `price`)
- [ ] `status` current before computing product counts (grounded in: [Product](/entities/product.md) > Core Attributes > `status`)
- [ ] Product category codes recognized as one of eight fixed values: CR, MT, RC, YH, FG, TM, RB, # (grounded in: [Product](/entities/product.md) > Data Conventions > Product Category Codes)
- [ ] Text/description lookups filtered to `LANGUAGE='EN'` (grounded in: [Product](/entities/product.md) > Data Conventions > Multilingual Text Tables)

### ProductCategory

- [ ] `product_category_name` (display name), not the internal code, used as the primary dimension when reporting product-line transaction share, profitability, or revenue trend (grounded in: [ProductCategory](/entities/product-category.md) > Core Attributes > `product_category_name`)
- [ ] `status` = active filter applied before computing transaction share or profitability by product line (grounded in: [ProductCategory](/entities/product-category.md) > Core Attributes > `status`)
- [ ] Z-prefix hierarchy node codes (ZCRUISE, ZMTN, ZRACING, ZYOUTH) recognized as customer-defined namespace values (grounded in: [ProductCategory](/entities/product-category.md) > Data Conventions > Z Prefix for Custom Namespace)

### ProductHierarchyNode

- [ ] Null `parent_product_hierarchy_node_id` expected and valid for the root node (grounded in: [ProductHierarchyNode](/entities/product-hierarchy-node.md) > Standard Attributes > `parent_product_hierarchy_node_id`)
- [ ] `is_leaf` used to distinguish individual product placements from product-line rollup groupings (e.g., Cruise, Mountain) (grounded in: [ProductHierarchyNode](/entities/product-hierarchy-node.md) > Standard Attributes > `is_leaf`)

### ProfitCenter

- [ ] Profit center, not product category, used as the primary dimension when answering "how is [product line] doing?" questions — profit center captures both product line and channel (grounded in: [ProfitCenter](/entities/profit-center.md) > Business Rules > Profit Center as Primary Management Reporting Dimension)
- [ ] `status` = active filter applied to identify the 37 active profit centers for management reporting and cost allocation (grounded in: [ProfitCenter](/entities/profit-center.md) > Core Attributes > `status`)
- [ ] Profit center IDs parsed per the encoding convention (CountryCode_PC+ProductLineCode+SubID+SizeCode, e.g., `US10_PCC1L`) rather than treated as opaque strings, when product line/channel needs to be derived from the ID itself (grounded in: [ProfitCenter](/entities/profit-center.md) > Data Conventions > Profit Center ID Encoding Convention)
- [ ] `#` (unassigned) `customer_id`/`product_id` on OpEx rows grouped by profit center, not filtered out, when answering which profit centers have non-customer/product-specific OpEx (grounded in: [ProfitCenter](/entities/profit-center.md) > Data Conventions > Hash (#) Means Unassigned Dimension)
- [ ] Text/description lookups filtered to `LANGUAGE='EN'` (grounded in: [ProfitCenter](/entities/profit-center.md) > Data Conventions > Multilingual Text Tables)

### ProfitCenterHierarchyNode

- [ ] Null `parent_profit_center_hierarchy_node_id` expected and valid for the root node (grounded in: [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) > Standard Attributes > `parent_profit_center_hierarchy_node_id`)
- [ ] `is_leaf` used to distinguish actual profit center placements from division/product-line rollup groupings within the US Division → Product Line → Channel structure (grounded in: [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) > Standard Attributes > `is_leaf`)

### AccountType

- [ ] All five account type values (INC, EXP, AST, LEQ, NFIN) recognized when classifying GL accounts for P&L, balance sheet, or cash flow reporting (grounded in: [AccountType](/entities/account-type.md) > Relationships > classifies [GLAccount](/entities/gl-account.md))
- [ ] NFIN (Non-financial Income) accounts treated as statistical/non-monetary (headcount, square footage, capacity) and excluded from monetary P&L sums (grounded in: [AccountType](/entities/account-type.md) > Standard Attributes > `description`)

---

## Entity Relationship Patterns

### FinancialTransaction → GLAccount

- **Join Key:** `gl_account_id` on FinancialTransaction → GL account identifier on GLAccount
- **Cardinality:** N:1 (many transactions per GL account)
- **Business Meaning:** Each posting classifies itself via a GL account that determines its placement in the P&L hierarchy (e.g., Gross Revenue, COGS, Payroll). Aggregation [MUST] use leaf-level accounts only.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships, [GLAccount](/entities/gl-account.md) > Relationships.

### FinancialTransaction → Customer

- **Join Key:** `customer_id` on FinancialTransaction → Customer identifier on Customer
- **Cardinality:** N:1 (many transactions per customer)
- **Business Meaning:** Identifies the B2B customer for revenue and COGS postings. [MUST] be set to the unassigned sentinel (`#`) for Operating Expense postings, which are organizational costs not tied to a specific customer.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships, [Customer](/entities/customer.md) > Relationships.

### FinancialTransaction → Product

- **Join Key:** `product_id` on FinancialTransaction → Product identifier on Product
- **Cardinality:** N:1 (many transactions per product)
- **Business Meaning:** Identifies the product for revenue and COGS postings. [MUST] be set to the unassigned sentinel (`#`) for Operating Expense postings, which are organizational costs rather than product-specific.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships, [Product](/entities/product.md) > Relationships.

### FinancialTransaction → ProfitCenter

- **Join Key:** `profit_center_id` on FinancialTransaction → ProfitCenter identifier on ProfitCenter
- **Cardinality:** N:1 (many transactions per profit center)
- **Business Meaning:** Present on every transaction regardless of account type, because profit center is the primary management reporting dimension — unlike Customer/Product, it is never sentinel-valued.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships, [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Profit Center as Primary Management Reporting Dimension.

### Customer → CustomerSegment

- **Join Key:** `customer_segment_id` on Customer → CustomerSegment identifier
- **Cardinality:** N:1 (many customers per segment)
- **Business Meaning:** Each customer is classified into exactly one segment tier — Speciality, Large, Medium, or Unassigned — that drives channel-based analysis and reporting (e.g., Gross Margin by customer segment).

**Grounded in:** [Customer](/entities/customer.md) > Relationships, [CustomerSegment](/entities/customer-segment.md) > Relationships.

### Customer → CustomerHierarchyNode

- **Join Key:** `customer_hierarchy_node_id` on Customer → CustomerHierarchyNode identifier
- **Cardinality:** N:1 (many customers grouped under one node)
- **Business Meaning:** Each customer is positioned in a grouping hierarchy organized by customer type and geography (56 nodes grouping 53 customers).

**Grounded in:** [Customer](/entities/customer.md) > Relationships, [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) > Relationships.

### CustomerHierarchyNode → CustomerHierarchyNode (self-referential)

- **Join Key:** `parent_customer_hierarchy_node_id` → CustomerHierarchyNode identifier (self)
- **Cardinality:** N:1 (many child nodes per parent); root node's parent is null
- **Business Meaning:** Adjacency-list hierarchy grouping customers by type and geography; traversal requires recursive parent-child resolution, not a flat lookup.

**Grounded in:** [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) > Relationships, [Modeling Decisions](/modeling-decisions.md) > Hierarchy Entities Use Self-Referential Adjacency Lists.

### Division → ProfitCenter

- **Join Key:** `division_id` on ProfitCenter → Division identifier
- **Cardinality:** 1:N (one division has many profit centers)
- **Business Meaning:** A division groups one or more profit centers; VeloGroup has four divisions — US Division (28 profit centers), Global (3), Logistics (4), and Year-end (1, for year-end adjustments).

**Grounded in:** [Division](/entities/division.md) > Relationships, [ProfitCenter](/entities/profit-center.md) > Relationships.

### GLAccount → AccountType

- **Join Key:** `account_type_id` on GLAccount → AccountType identifier
- **Cardinality:** N:1 (many GL accounts per account type)
- **Business Meaning:** Classifies each GL account into one of five accounting categories (INC, EXP, AST, LEQ, NFIN) that determines how it behaves in P&L, balance sheet, and cash flow reporting.

**Grounded in:** [GLAccount](/entities/gl-account.md) > Relationships, [AccountType](/entities/account-type.md) > Relationships.

### GLAccount → GLAccountHierarchyNode

- **Join Key:** `gl_account_hierarchy_node_id` on GLAccount → GLAccountHierarchyNode identifier
- **Cardinality:** 1:1 (each leaf GL account maps to exactly one hierarchy position)
- **Business Meaning:** Defines the account's rollup path for financial statement consolidation — this is the join [MUST] be used (not a flat account filter) to compute Gross Margin, EBIT, Net Income, and OpEx splits.

**Grounded in:** [GLAccount](/entities/gl-account.md) > Relationships, [Modeling Decisions](/modeling-decisions.md) > P&L Hierarchy is the Analytical Core.

### GLAccountHierarchyNode → GLAccountHierarchyNode (self-referential)

- **Join Key:** `parent_gl_account_hierarchy_node_id` → GLAccountHierarchyNode identifier (self)
- **Cardinality:** N:1 (many child nodes per parent); root node (Net Income) has no parent
- **Business Meaning:** Forms the P&L rollup tree that transforms leaf-level GL postings into P&L statement lines — this is the central analytical structure for Gross Margin, EBIT, Net Income, and OpEx computations.

**Grounded in:** [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) > Relationships, [Modeling Decisions](/modeling-decisions.md) > Hierarchy Entities Use Self-Referential Adjacency Lists.

### Product → ProductCategory

- **Join Key:** `product_category_id` on Product → ProductCategory identifier
- **Cardinality:** N:1 (many products per category)
- **Business Meaning:** Each product belongs to exactly one product category/product line (CR, MT, RC, YH, FG, TM, RB), the grouping used throughout financial reporting (e.g., revenue by product line).

**Grounded in:** [Product](/entities/product.md) > Relationships, [ProductCategory](/entities/product-category.md) > Relationships.

### Product → ProductHierarchyNode

- **Join Key:** `product_hierarchy_node_id` on Product → ProductHierarchyNode identifier
- **Cardinality:** N:1 (many products grouped under one node)
- **Business Meaning:** Positions each product under a drill-down hierarchy node (e.g., ZCRUISE, ZMTN, ZRACING, ZYOUTH, ZFGOODS).

**Grounded in:** [Product](/entities/product.md) > Relationships, [ProductHierarchyNode](/entities/product-hierarchy-node.md) > Relationships.

### ProductHierarchyNode → ProductHierarchyNode (self-referential)

- **Join Key:** `parent_product_hierarchy_node_id` → ProductHierarchyNode identifier (self)
- **Cardinality:** N:1 (many child nodes per parent); root node has no parent
- **Business Meaning:** Multi-level rollup tree used for product drill-down analysis (e.g., the Cruise grouping gathers C900, C950, C990, E101, E102, E103).

**Grounded in:** [ProductHierarchyNode](/entities/product-hierarchy-node.md) > Relationships, [Modeling Decisions](/modeling-decisions.md) > Hierarchy Entities Use Self-Referential Adjacency Lists.

### ProfitCenter → ProfitCenterHierarchyNode

- **Join Key:** `profit_center_hierarchy_node_id` on ProfitCenter → ProfitCenterHierarchyNode identifier
- **Cardinality:** N:1 (many profit centers grouped under one node)
- **Business Meaning:** Defines the organizational rollup path (US Division → Product Line → Channel) used for management reporting aggregation.

**Grounded in:** [ProfitCenter](/entities/profit-center.md) > Relationships, [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) > Relationships.

### ProfitCenterHierarchyNode → ProfitCenterHierarchyNode (self-referential)

- **Join Key:** `parent_profit_center_hierarchy_node_id` → ProfitCenterHierarchyNode identifier (self)
- **Cardinality:** N:1 (many child nodes per parent); root node has no parent
- **Business Meaning:** Adjacency-list hierarchy forming the US Division → Product Line → Channel rollup path used to aggregate from an individual profit center up through product line and division groupings.

**Grounded in:** [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) > Relationships, [Modeling Decisions](/modeling-decisions.md) > Hierarchy Entities Use Self-Referential Adjacency Lists.

### Cross-Cutting Pattern: FinancialTransaction Composite Grain

- **Grain:** GL account × customer × product × profit center × version × date
- **Business Meaning:** FinancialTransaction is pre-aggregated at this dimensional grain — it is not a journal entry or sales order. Revenue and COGS postings populate all grain components; Operating Expense postings populate only profit center (customer/product are sentinel `#`), because OpEx is organizational cost.

**Grounded in:** [Modeling Decisions](/modeling-decisions.md) > FinancialTransaction as the Single Transactional Entity, [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Dimensional Grain Varies by Account Type.

### Cross-Cutting Pattern: Self-Referential Hierarchy Naming Convention

- **Pattern:** All four hierarchy entities (GLAccountHierarchyNode, ProductHierarchyNode, CustomerHierarchyNode, ProfitCenterHierarchyNode) use a `parent_` prefix plus the full entity name in snake_case for their self-referential foreign key (e.g., `parent_gl_account_hierarchy_node_id`), and [MUST] allow null for root nodes.
- **Business Meaning:** This naming convention keeps the self-reference unambiguous when generating joins across any of the four hierarchy entities.

**Grounded in:** [Modeling Decisions](/modeling-decisions.md) > Hierarchy Entities Use Self-Referential Adjacency Lists.
