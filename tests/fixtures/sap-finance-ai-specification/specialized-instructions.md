---
type: specialized_instructions
title: Specialized Instructions
description: Project-specific computation recipes, pre-flight checklists, and entity relationship patterns for VeloGroup's FP&A analytics platform — grounded in specification content with explicit citations.
confidence: high
timestamp: 2026-07-15T17:00:00Z
tags: [specialized_instructions]
---

# Specialized Instructions

## Computation Recipes

### Gross Revenue

1. **Source entity:** `FinancialTransaction`, `value` attribute
2. **Filter:** `gl_account_id = 'FPA1/022'` — this is the Gross Revenue leaf account. [MUST NOT] include rollup accounts; only leaf-level accounts receive postings.
3. **Version filter:** Filter on `version = 'Actual'` for realized revenue, or `version = 'Budget'` for planned revenue. Omitting this filter combines both versions, which [MUST NOT] be done for standard revenue reporting.
4. **Sign:** All values are stored as positive. No sign flip needed for Gross Revenue — it is a revenue account that adds in the hierarchy.
5. **Aggregation:** `SUM(value)` across all transactions matching the filter, scoped to the desired fiscal year (January 1 through December 31, calendar year alignment).
6. **Decimal parsing:** The `value` column is stored as VARCHAR with European comma decimal formatting (e.g., '12734,04' = $12,734.04). [MUST] convert comma to period before numeric aggregation.
7. **Transaction volume:** Expect ~30,724 Gross Revenue transactions across the full dataset.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-01,
[FinancialTransaction](/entities/financial-transaction.md) > Core Attributes,
[FinancialTransaction](/entities/financial-transaction.md) > Data Conventions,
[GLAccount](/entities/gl-account.md) > Business Rules > Transactions Post Only to Leaf Accounts

### Net Revenue

1. **Formula:** `SUM(FPA1/022) - SUM(FPA1/023)` — Gross Revenue minus Sales Deductions.
2. **Hierarchy context:** Net Revenue is rollup node FPA1/021, computed by summing its children per the hierarchy-driven arithmetic rule.
3. **Sign:** Both FPA1/022 and FPA1/023 store positive values. The subtraction is hierarchy-driven — Sales Deductions (FPA1/023) reduce Gross Revenue. Apply the subtraction explicitly.
4. **Version filter:** [MUST] filter on `version` to separate Actual from Budget.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-02,
[FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Hierarchy-Driven P&L Arithmetic,
[GLAccount](/entities/gl-account.md) > Business Rules > Hierarchy-Driven P&L Arithmetic

### COGS

1. **Formula:** `SUM(value) WHERE gl_account_id = 'FPA1/020'`
2. **Volume:** ~126,390 transactions (~75% of total). COGS dominates transaction volume because it is tracked at the full product × customer × profit center grain.
3. **Sign:** Stored as positive. In the P&L hierarchy, COGS subtracts from Net Revenue to produce Gross Margin — the subtraction is applied by the hierarchy arithmetic, not embedded in the value.
4. **Version filter:** [MUST] filter on `version` to separate Actual from Budget.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-03,
[FinancialTransaction](/entities/financial-transaction.md) > Core Attributes,
[Expert Observations](/expert-observations.md) > Observation 4

### Gross Margin

1. **Formula:** `Net Revenue - COGS` = `(SUM(FPA1/022) - SUM(FPA1/023)) - SUM(FPA1/020)`
2. **Hierarchy context:** Gross Margin is rollup node FPA1/017. Revenue accounts add, cost accounts subtract — the hierarchy implicitly defines the arithmetic.
3. **Drill-down:** Available across all dimensions: product line (via profit center hierarchy), customer segment (`customer_type_id`), individual profit center, individual customer, individual product.
4. **Version filter:** [MUST] filter on `version`.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-04,
[FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Rule 1: Hierarchy-Driven P&L Arithmetic

### Gross Margin Percentage

1. **Formula:** `(Net Revenue - COGS) / Net Revenue × 100`
2. **Priority:** CFO's #1 metric — "Tells me how efficiently we're converting sales into profit."
3. **Prerequisite:** Net Revenue [MUST] be non-zero. If Net Revenue = 0, the percentage is undefined.
4. **Drill-down:** Supports product line, customer type, and profit center segmentation.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-05,
[Business Questions](/reference/business-questions.md) > Q001

### COGS Ratio

1. **Formula:** `COGS / Net Revenue × 100`
2. **Relationship:** Inverse of Gross Margin % — `COGS Ratio + Gross Margin % = 100%`.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-06,
[Business Questions](/reference/business-questions.md) > Q010

### Operating Expense Total

1. **Formula:** `SUM(value) WHERE gl_account_id IN ('FPA1/028', 'FPA1/029', 'FPA1/032', 'FPA1/033', 'FPA1/034', 'FPA1/035', 'FPA1/027')`
2. **Categories and leaf accounts:**
   - Building Expense (FPA1/024 rollup): Periodic (FPA1/028), Utilities (FPA1/029)
   - Employee Expense (FPA1/026 rollup): Office (FPA1/032), Payroll (FPA1/033), Travel (FPA1/034), Employee Other (FPA1/035)
   - Other OpEx: FPA1/027 (leaf)
3. **Grain constraint:** Operating expenses are at profit center grain only — `customer_id = '#'` and `product_id = '#'`. [MUST NOT] attempt customer-level or product-level OpEx analysis.
4. **Version filter:** [MUST] filter on `version`.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-07,
[FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Rule 4: Operating Expenses at Profit Center Grain Only

### EBIT (Operating Income)

1. **Formula:** `Gross Margin - Operating Expense Total`
2. **Hierarchy context:** EBIT is rollup node FPA1/09.
3. **Known gap:** The P&L hierarchy shows Net Income (FPA1/08) as the direct parent of EBIT (FPA1/09) with no intermediate nodes documented. Whether Net Income = EBIT or undocumented items (interest, taxes) exist between them is unresolved.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-08,
[Known Gaps](/known-gaps.md) > Gap 9: P&L Hierarchy Completeness

### Net Income

1. **Formula:** Hierarchy rollup at FPA1/08 (root node) — the bottom-line profit.
2. **Known gap:** Same hierarchy completeness question as EBIT. Treat Net Income = EBIT until the hierarchy gap is resolved during data profiling.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-09,
[Known Gaps](/known-gaps.md) > Gap 9

### Budget vs Actual Variance (Dollar)

1. **Formula:** `SUM(value WHERE version = 'Actual') - SUM(value WHERE version = 'Budget')` per GL account.
2. **Priority:** CFO's #2 metric — "How I hold the business accountable."
3. **Grain:** Compute per account (`gl_account_id`), then drill into dimensions (product line, customer segment, profit center) as needed.
4. **Validation gate:** Budget totals [MUST] match Karen's approved totals to the penny before budget data is considered valid for variance analysis.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-10,
[FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Rule 7: Budget Validation Must Tie to Approved Totals

### Budget vs Actual Variance (Percentage)

1. **Formula:** `(Actual - Budget) / Budget × 100` per GL account.
2. **Context:** A $50,000 variance in Gross Revenue means something different than a $50,000 variance in Travel expense — the percentage normalizes for scale.
3. **Edge case:** If Budget = 0 for a line item, the percentage is undefined. Flag these rather than dividing by zero.

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-11,
[Business Questions](/reference/business-questions.md) > Q003

### Revenue by Product Line

1. **Formula:** `SUM(value WHERE gl_account_id = 'FPA1/022') GROUP BY product_line`
2. **Grouping method:** Use the [ProfitCenter](/entities/profit-center.md) hierarchy for product line grouping (PCC=Cruise, PCM=Mountain, PCR=Racing, PCY=Youth). Karen recommends the hierarchy over parsing profit center ID strings.
3. **Priority:** CFO's #3 metric — "Which lines are growing, which are flat, which are declining."

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-12,
[ProfitCenter](/entities/profit-center.md) > Profit Center Structure,
[ProfitCenter](/entities/profit-center.md) > Business Rules > Profit Center as Primary Management Reporting Dimension

### Profit Center Contribution (% of Total Revenue)

1. **Formula:** `SUM(FPA1/022 per profit_center_id) / SUM(FPA1/022 total) × 100`
2. **Scope:** Covers all 37 profit centers (28 US Division + 3 Global + 4 Logistics + 1 Year-end + 1 unaccounted).

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-13,
[ProfitCenter](/entities/profit-center.md) > Profit Center Structure

### Contribution Margin by Product Line

1. **Formula:** `(SUM(Revenue) - SUM(COGS))` per product line via [ProfitCenter](/entities/profit-center.md) hierarchy.
2. **Limitation:** This is gross margin by product line (before shared costs). Full product profitability with allocated operating expenses is deferred to Phase 2 (UC-07).

**Grounded in:** [Financial KPIs](/kpis/financial-kpis.md) > FKPI-14,
[Business Questions](/reference/business-questions.md) > Q014

### Customer Concentration Check

1. **Formula:** `SUM(FPA1/022 per customer_id) / SUM(FPA1/022 total) × 100`
2. **Threshold:** <15% per individual customer. The CFO specifically monitors Skymart Corp for concentration risk (source type: `stakeholder_statement` — threshold is a management judgment, not a regulatory requirement).
3. **Implementation:** [SHOULD] be implemented as a dashboard KPI with threshold highlighting, not buried in a static report.

**Grounded in:** [Operational KPIs](/kpis/operational-kpis.md) > KPI-04,
[Business Questions](/reference/business-questions.md) > Q005,
[Expert Observations](/expert-observations.md) > Observation 6

### E-Bike Revenue Growth Rate

1. **Formula:** Year-over-year percentage change in revenue for e-bike products.
2. **Approximate value:** ~40% (source type: `stakeholder_statement` — unverified approximation from the CFO, use for order-of-magnitude validation only).
3. **Data requirement:** Requires identifying e-bike products within the [Product](/entities/product.md) catalog and filtering revenue transactions accordingly.

**Grounded in:** [Business Questions](/reference/business-questions.md) > Q020,
[Operational KPIs](/kpis/operational-kpis.md) > KPI-05

## Pre-Flight Checklist

### FinancialTransaction

- [ ] **European comma decimal conversion applied:** `value` column stored as VARCHAR with comma decimal separator (e.g., '12734,04'). [MUST] convert to numeric with period decimal before any aggregation.
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Data Conventions > European Comma Decimal Formatting)
- [ ] **BIGINT date cast applied:** `posting_date` stored as BIGINT in YYYYMMDD format (e.g., 20210101). [MUST] cast to DATE type for temporal analysis.
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Data Conventions > Dates as BIGINT in YYYYMMDD Format)
- [ ] **VARCHAR-to-numeric conversion for amounts:** Financial amounts stored as VARCHAR type. Transformation [MUST] include VARCHAR→numeric conversion with comma-to-period swap.
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Data Conventions > Amounts Stored as VARCHAR)
- [ ] **Hash (#) sentinel retained:** The # value for `customer_id` and `product_id` [MUST NOT] be filtered out. It is a first-class dimension member. Removing it eliminates the entire Operating Expense section.
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Rule 5: Hash (#) as Legitimate Dimension Member)
- [ ] **Leaf-account-only filter applied:** Financial transactions only post to leaf-level GL accounts. Rollup accounts (e.g., FPA1/017 Gross Margin, FPA1/018 Operating Expense) [MUST NOT] appear in transaction-level queries.
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Rule 2: Transactions Post Only to Leaf Accounts)
- [ ] **Hierarchy-driven sign convention applied:** Revenue and COGS values are both stored as positive. The P&L hierarchy determines the arithmetic (revenue adds, costs subtract). [MUST NOT] assume signs are embedded in the values.
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Rule 1: Hierarchy-Driven P&L Arithmetic,
      [Expert Observations](/expert-observations.md) > Observation 1)
- [ ] **Version field present and filtered:** Every query [MUST] specify whether it uses `version = 'Actual'`, `version = 'Budget'`, or both. Unfiltered queries are dominated by budget data (61% of rows).
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Core Attributes > version,
      [Expert Observations](/expert-observations.md) > Observation 3)
- [ ] **Composite grain completeness verified:** The dimensional grain is account × customer × product × profit center × version × date. All six dimensions [MUST] be present for a complete fact record.
      (grounded in: [Modeling Decisions](/modeling-decisions.md) > Key Decisions > 1. Single Transactional Entity)
- [ ] **Dimensional grain awareness:** Revenue and COGS carry full dimensional grain (customer + product + profit center). Operating expenses carry profit center only (customer=# and product=#). [MUST NOT] attempt customer-level or product-level OpEx analysis.
      (grounded in: [FinancialTransaction](/entities/financial-transaction.md) > Business Rules > Rule 3 and Rule 4,
      [Expert Observations](/expert-observations.md) > Observation 2)

### Customer

- [ ] **Multilingual text filter applied:** Text tables store descriptions in multiple languages (EN, DE). [MUST] filter on LANGUAGE='EN' for English descriptions.
      (grounded in: [Customer](/entities/customer.md) > Data Conventions > Multilingual Text Tables with Language Filter)
- [ ] **Hash (#) sentinel retained in customer_type_id:** The # value represents Unassigned — a legitimate member with master data entries. [MUST NOT] be filtered out.
      (grounded in: [Customer](/entities/customer.md) > Data Conventions > Hash Symbol for Unassigned Dimension Members)
- [ ] **Customer segment codes validated:** Z1=Speciality, Z2=Large, Z3=Medium, #=Unassigned. These are the only valid values for `customer_type_id`.
      (grounded in: [Customer](/entities/customer.md) > Core Attributes > customer_type_id)
- [ ] **Customer count baseline verified:** 53 total — 44 US, 9 Canada.
      (grounded in: [Business Questions](/reference/business-questions.md) > Q008)

### Product

- [ ] **Multilingual text filter applied:** [MUST] filter on LANGUAGE='EN' for English product descriptions.
      (grounded in: [Product](/entities/product.md) > Data Conventions > Multilingual Text Tables with Language Filter)
- [ ] **Hash (#) sentinel retained in product_category_id:** [MUST NOT] filter out the # value — it represents legitimate unassigned dimension members.
      (grounded in: [Product](/entities/product.md) > Data Conventions > Hash Symbol for Unassigned Dimension Members)
- [ ] **Product category codes validated:** CR=Cruise, MT=Mountain, RC=Racing, YH=Youth, FG=Finished Goods, TM, RB, #. These 8 values are the complete enum.
      (grounded in: [Product](/entities/product.md) > Core Attributes > product_category_id)
- [ ] **Product count baseline verified:** 35 products in the catalog.
      (grounded in: [Business Questions](/reference/business-questions.md) > Q021)

### ProfitCenter

- [ ] **Multilingual text filter applied:** [MUST] filter on LANGUAGE='EN' for English profit center descriptions.
      (grounded in: [ProfitCenter](/entities/profit-center.md) > Data Conventions > Multilingual Text Tables with Language Filter)
- [ ] **Hash (#) sentinel retained:** [MUST NOT] filter out hash dimension members.
      (grounded in: [ProfitCenter](/entities/profit-center.md) > Business Rules > Hash (#) as Legitimate Dimension Member)
- [ ] **Profit center count validated:** 37 total (28 US Division + 3 Global + 4 Logistics + 1 Year-end + 1 unaccounted).
      (grounded in: [ProfitCenter](/entities/profit-center.md) > Profit Center Structure,
      [Known Gaps](/known-gaps.md) > Gap 1: 37th Profit Center Unaccounted)
- [ ] **Profit center ID encoding understood:** Format `CountryCode_PC+ProductLineCode+SubID+SizeCode` (e.g., US10_PCC1L = US, company 10, Cruise, sub-1, Large). [SHOULD] use the hierarchy for grouping rather than parsing ID strings.
      (grounded in: [ProfitCenter](/entities/profit-center.md) > Data Conventions > Profit Center ID Encoding,
      [ProfitCenter](/entities/profit-center.md) > Business Rules > Profit Center as Primary Management Reporting Dimension)

### GLAccount

- [ ] **Leaf vs rollup distinction enforced:** Only leaf accounts (identified by `is_leaf` attribute) receive transaction postings. Rollup accounts are structural nodes. [MUST NOT] sum rollup accounts alongside their children — doing so double-counts.
      (grounded in: [GLAccount](/entities/gl-account.md) > Core Attributes > is_leaf,
      [GLAccount](/entities/gl-account.md) > Business Rules > Transactions Post Only to Leaf Accounts)
- [ ] **Hierarchy direction understood:** Revenue accounts add, cost accounts subtract. Parent node values [MUST] be computed by summing/subtracting children per the hierarchy arithmetic.
      (grounded in: [GLAccount](/entities/gl-account.md) > Business Rules > Hierarchy-Driven P&L Arithmetic)
- [ ] **FPA1/NNN naming convention preserved:** GL accounts use FPA1/NNN format. [MUST] preserve original format — do not strip or reformat.
      (grounded in: [GLAccount](/entities/gl-account.md) > Data Conventions > FPA1 Account Naming Convention)
- [ ] **Multilingual text filter applied:** [MUST] filter on LANGUAGE='EN' for English GL account descriptions.
      (grounded in: [GLAccount](/entities/gl-account.md) > Data Conventions > Multilingual Text Tables with Language Filter)
- [ ] **GL account count validated:** 21 accounts total in the P&L hierarchy (hierarchy levels 1–6).
      (grounded in: [Modeling Decisions](/modeling-decisions.md) > Key Decisions > 2. GLAccount Absorbs Hierarchy)

### FiscalCalendar

- [ ] **Calendar year alignment confirmed:** Fiscal year = calendar year (January 1 through December 31). No 4-4-5 or offset calendar.
      (grounded in: [FiscalCalendar](/entities/fiscal-calendar.md) > Additional Context > Fiscal Year Structure)
- [ ] **YYYYMMDD date cast applied for transaction alignment:** Transaction posting dates in YYYYMMDD BIGINT format [MUST] be correctly parsed to align with fiscal calendar period boundaries.
      (grounded in: [FiscalCalendar](/entities/fiscal-calendar.md) > Data Conventions)
- [ ] **Data scope boundaries verified:** April 2018 (SAP migration) through January 2021. 2018 is partial year; 2019 and 2020 are full years; 2021 is January only.
      (grounded in: [FiscalCalendar](/entities/fiscal-calendar.md) > Additional Context > Data Scope,
      [Fiscal Calendar Reference](/reference/fiscal-calendar.md) > Data Scope)
- [ ] **Reporting currency confirmed:** USD. All amounts in the VALUE column are already converted to USD by SAP at posting time.
      (grounded in: [FiscalCalendar](/entities/fiscal-calendar.md) > Additional Context > Currency Context)

## Entity Relationship Patterns

### FinancialTransaction → GLAccount

- **Join Key:** `gl_account_id` on FinancialTransaction → `account_id` on GLAccount
- **Cardinality:** N:1 (many transactions per GL account)
- **Business Meaning:** Each financial transaction is classified by exactly one GL account that determines its P&L placement (e.g., Gross Revenue FPA1/022, COGS FPA1/020, Payroll FPA1/033). Aggregation [MUST] use leaf-level accounts only — rollup accounts are structural and [MUST NOT] carry direct postings.
- **Constraint:** Only 21 GL accounts exist. All transactions map to one of these leaf accounts. The `is_leaf` attribute on GLAccount distinguishes postable accounts from rollup nodes.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships,
[GLAccount](/entities/gl-account.md) > Business Rules > Transactions Post Only to Leaf Accounts,
[GLAccount](/entities/gl-account.md) > Core Attributes > is_leaf

### FinancialTransaction → Customer

- **Join Key:** `customer_id` on FinancialTransaction → `customer_id` on Customer
- **Cardinality:** N:1 (many transactions per customer)
- **Business Meaning:** Each revenue and COGS transaction references a specific customer for customer-level profitability analysis. Operating expense transactions use `customer_id = '#'` (Unassigned) — a legitimate dimension member that [MUST NOT] be filtered out.
- **Constraint:** The # value has a master data entry in the Customer entity with its own text and hierarchy position. Filtering it out eliminates the entire Operating Expense section from the P&L.
- **Reliability note:** Customer count of 53 (44 US, 9 Canada) is grounded in workshop transcript (source type: `stakeholder_statement`). Use for order-of-magnitude validation.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships,
[Customer](/entities/customer.md) > Business Rules > Hash (#) as Legitimate Dimension Member,
[Business Questions](/reference/business-questions.md) > Q008

### FinancialTransaction → Product

- **Join Key:** `product_id` on FinancialTransaction → `product_id` on Product
- **Cardinality:** N:1 (many transactions per product)
- **Business Meaning:** Each revenue and COGS transaction references a specific product, enabling product-level revenue and profitability analysis. Operating expense transactions use `product_id = '#'` (Unassigned).
- **Constraint:** The # value is a first-class dimension member with master data entries. [MUST NOT] be filtered out. Product categories (CR, MT, RC, YH, FG, TM, RB, #) are modeled as an attribute on Product, not as a separate entity.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships,
[Product](/entities/product.md) > Business Rules > Hash (#) as Legitimate Dimension Member,
[Modeling Decisions](/modeling-decisions.md) > Key Decisions > 3. Type/Category Entities Demoted to Attributes

### FinancialTransaction → ProfitCenter

- **Join Key:** `profit_center_id` on FinancialTransaction → `profit_center_id` on ProfitCenter
- **Cardinality:** N:1 (many transactions per profit center)
- **Business Meaning:** Every financial transaction is assigned to a profit center — the primary management reporting dimension used by the CFO to evaluate business performance. Revenue and COGS carry profit center alongside customer and product dimensions; operating expenses carry profit center as the only populated organizational dimension.
- **Constraint:** Profit center is always populated (never #) because even operating expenses are organizationally assigned. There are 37 profit centers across four groups: US Division (28), Global (3), Logistics (4), Year-end (1), plus one unaccounted.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships,
[ProfitCenter](/entities/profit-center.md) > Business Rules > Profit Center as Primary Management Reporting Dimension,
[ProfitCenter](/entities/profit-center.md) > Profit Center Structure,
[Known Gaps](/known-gaps.md) > Gap 1: 37th Profit Center Unaccounted

### FinancialTransaction → FiscalCalendar

- **Join Key:** `fiscal_calendar_id` on FinancialTransaction → fiscal calendar period identifier on FiscalCalendar
- **Cardinality:** N:1 (many transactions per fiscal period)
- **Business Meaning:** Each transaction links to a fiscal calendar period for reporting period assignment. VeloGroup uses calendar year (January 1–December 31) with 12 monthly periods. The fiscal calendar provides the time dimension for all trend analysis, year-over-year comparisons, and period-based reporting.
- **Constraint:** Transaction `posting_date` (YYYYMMDD BIGINT) [MUST] be correctly parsed and aligned to fiscal calendar period boundaries. Data spans April 2018 through January 2021; 2018 is a partial year starting at SAP migration.

**Grounded in:** [FinancialTransaction](/entities/financial-transaction.md) > Relationships,
[FiscalCalendar](/entities/fiscal-calendar.md) > Additional Context > Fiscal Year Structure,
[FiscalCalendar](/entities/fiscal-calendar.md) > Additional Context > Data Scope
