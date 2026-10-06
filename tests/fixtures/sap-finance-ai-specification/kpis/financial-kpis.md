---
type: kpi_collection
title: Financial KPIs
description: Eleven financial P&L metrics derived from VeloGroup's 21-account GL hierarchy — Gross Revenue, Net Revenue, COGS, Gross Margin, Gross Margin %, Budget vs Actual Variance, Operating Expense Total, EBIT, Net Income, COGS Ratio, and Revenue by Product Line.
confidence: high
timestamp: "2026-10-05T20:19:27Z"
tags: [kpi, financial, gl-account, pl-hierarchy, budget-actual]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Financial KPIs

**Boundary Note:** These KPIs are financial P&L metrics — monetary line items, ratios, and calculated variance measures derived from the GL account hierarchy. Operational KPIs (transaction volumes, product mix, customer concentration, profit center contribution) are in [Operational KPIs](/kpis/operational-kpis.md).

**Sign Convention Note:** Revenue and COGS are both stored as positive values. The P&L hierarchy determines arithmetic: revenue accounts add, cost accounts subtract. Gross Margin = Net Revenue - COGS. See [FinancialTransaction](/entities/financial-transaction.md) business rules for the full sign-convention rule.

---

## FKPI-01: Gross Revenue

| Field | Value |
|---|---|
| **Definition** | SUM(VALUE) for GL account FPA1/022 (Gross Revenue) |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Leaf account under Net Revenue (FPA1/021) |
| **GL Account** | FPA1/022 |
| **Transaction Volume** | ~30,724 transactions |
| **Dimensional Grain** | Customer × Product × Profit Center |
| **Data Source** | [FinancialTransaction](/entities/financial-transaction.md) (Actual version, gl_account_id = FPA1/022) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[226]
> {"speaker": "Karen Liu", "timestamp": "39:17", "quote": "I currently track about fifteen in my Excel dashboard. Let me go through them. Financial KPIs first. Gross Revenue — top-line number from FPA1/022. Net Revenue — Gross Revenue minus Sales Deductions. COGS from FPA1/020. Gross Margin — Net Revenue minus COGS. Gross Margin percent."}

---

## FKPI-02: Net Revenue

| Field | Value |
|---|---|
| **Definition** | SUM(Gross Revenue, FPA1/022) - SUM(Sales Deductions, FPA1/023) |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Calculated node FPA1/021 (parent of FPA1/022 and FPA1/023) |
| **Dimensional Grain** | Customer × Product × Profit Center |

**Calculation Note:** Net Revenue [MUST] be computed as a hierarchy rollup — it is not a leaf account and no transactions post directly to FPA1/021. See [GLAccount](/entities/gl-account.md) for the leaf-vs-rollup rule.

---

## FKPI-03: COGS

| Field | Value |
|---|---|
| **Definition** | SUM(VALUE) for GL account FPA1/020 |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Leaf account under Gross Margin (FPA1/017) |
| **GL Account** | FPA1/020 |
| **Transaction Volume** | ~126,390 transactions (75% of total) |
| **Dimensional Grain** | Customer × Product × Profit Center |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[56]
> {"speaker": "Karen Liu", "timestamp": "09:57", "quote": "COGS is the big one. FPA1/020. About 126,390 transactions."}

---

## FKPI-04: Gross Margin

| Field | Value |
|---|---|
| **Definition** | Net Revenue - COGS = (FPA1/022 - FPA1/023) - FPA1/020 |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Calculated node FPA1/017 |
| **Significance** | Primary diagnostic metric — distinguishes a revenue problem from a cost problem |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[107]
> {"speaker": "Karen Liu", "timestamp": "17:59", "quote": "From Net Income all the way down to individual leaf accounts. But the most actionable variances tend to be at the Gross Margin level — is it a revenue problem or a cost problem? — and within Operating Expense — are we overspending on payroll, travel?"}

---

## FKPI-05: Gross Margin %

| Field | Value |
|---|---|
| **Definition** | (Net Revenue - COGS) / Net Revenue × 100 |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **Significance** | CFO's #1 priority KPI — indicates efficiency of converting sales into profit before operating costs |
| **Diagnostic Use** | A slipping Gross Margin % [SHOULD] be treated as a signal of a cost problem or a pricing problem requiring immediate investigation |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[222]
> {"speaker": "Stefan Richter", "timestamp": "38:27", "quote": "Number one — Gross Margin percentage. Net Revenue minus COGS, divided by Net Revenue. That tells me how efficiently we're converting sales into profit before operating costs. If Gross Margin is slipping, I have a cost problem or a pricing problem, and I need to know immediately."}

---

## FKPI-06: Budget vs Actual Variance ($ and %)

| Field | Value |
|---|---|
| **Definition** | Dollar variance: Actual - Budget. Percentage variance: (Actual - Budget) / Budget × 100 |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **Scope** | Applied to all P&L line items from Net Income to leaf accounts |
| **Drill-down** | Cross-dimensional: by product line, customer type, profit center |
| **Significance** | CFO's #2 priority KPI — the primary accountability mechanism for business performance against plan |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[223]
> {"speaker": "Stefan Richter", "timestamp": "38:47", "quote": "Number two — Budget vs Actual variance. Both dollar variance and percentage variance. I want to see it at the P&L line level and I want to be able to drill into the dimensions to understand why we're off plan."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[244]
> {"speaker": "Karen Liu", "timestamp": "43:03", "quote": "High. And I want both dollar variance and percentage variance side by side. A $50,000 variance in Gross Revenue means something different than a $50,000 variance in Travel expense."}

**Note:** Variance [MUST] be computed for all P&L line items — both leaf and calculated nodes. The same dimensional structure applies to both versions (Actual, Budget), enabling dimensional drill-down. See [FinancialTransaction](/entities/financial-transaction.md) for the `version` attribute that discriminates Actual from Budget postings.

---

## FKPI-07: Operating Expense Total (Building + Employee + Other Operating)

| Field | Value |
|---|---|
| **Definition** | SUM of all Operating Expense accounts: Building Expense (FPA1/028, FPA1/029) + Employee Expense (FPA1/032–035) + Other Operating Expense (FPA1/027, leaf accounts NOT_MENTIONED) |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly (reviewed quarterly by the CFO) |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Calculated node FPA1/018 with sub-branches Building (FPA1/024), Employee (FPA1/026), and Other Operating (FPA1/027) |
| **Dimensional Grain** | Profit center only (customer = #, product = #) |

### OpEx Sub-categories

| Category | Node | Leaf Accounts |
|---|---|---|
| Building Expense | FPA1/024 | FPA1/028 (Periodic), FPA1/029 (Utilities) |
| Employee Expense | FPA1/026 | FPA1/032 (Office), FPA1/033 (Payroll), FPA1/034 (Travel), FPA1/035 (Employee Other) |
| Other Operating Expense | FPA1/027 | Leaf accounts NOT_MENTIONED |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[227]
> {"speaker": "Karen Liu", "timestamp": "39:40", "quote": "Operating Expense total, broken down into Building and Employee. EBIT — Operating Income after all expenses. Net Income. Budget vs Actual variance in both dollars and percentage for all of those line items. Revenue by product line. And COGS ratio — COGS divided by Net Revenue — which is basically the inverse of Gross Margin but some analysts prefer to see cost as a percentage of revenue."}

---

## FKPI-08: EBIT (Operating Income)

| Field | Value |
|---|---|
| **Definition** | Operating Income = Gross Margin - Operating Expense. Hierarchy node FPA1/016, rolling up to EBIT at FPA1/09 |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Calculated node FPA1/09 (Level 2, parent of Operating Income FPA1/016) |

**Note:** Stakeholders use "EBIT" and "Operating Income" interchangeably. In the hierarchy, FPA1/09 is labeled EBIT and FPA1/016 is Operating Income. In VeloGroup's 21-account structure with no interest or tax accounts visible as leaf nodes, EBIT is functionally equivalent to Operating Income. EBITDA was not mentioned as a tracked KPI.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[51]
> {"speaker": "Karen Liu", "timestamp": "08:58", "quote": "No, I have it memorized. Twenty-one accounts, I could recite them in my sleep at this point. Under Net Income sits EBIT — FPA1/09. Under EBIT is Operating Income — FPA1/016."}

---

## FKPI-09: Net Income

| Field | Value |
|---|---|
| **Definition** | Top of P&L hierarchy — rollup of all income and expense accounts. Hierarchy root FPA1/08 |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Root node FPA1/08 (Level 1) |

---

## FKPI-10: COGS Ratio

| Field | Value |
|---|---|
| **Definition** | COGS / Net Revenue × 100 |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **Relationship** | Inverse of Gross Margin % — some analysts prefer viewing cost as a percentage of revenue |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[227]
> {"speaker": "Karen Liu", "timestamp": "39:40", "quote": "Operating Expense total, broken down into Building and Employee. EBIT — Operating Income after all expenses. Net Income. Budget vs Actual variance in both dollars and percentage for all of those line items. Revenue by product line. And COGS ratio — COGS divided by Net Revenue — which is basically the inverse of Gross Margin but some analysts prefer to see cost as a percentage of revenue."}

---

## FKPI-11: Revenue by Product Line

| Field | Value |
|---|---|
| **Definition** | SUM(Gross Revenue, FPA1/022) grouped by product line (via Profit Center hierarchy or Product Category) |
| **Metric Type** | multi_source_aggregation |
| **Domain** | financial |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **P&L Position** | Disaggregation of leaf account FPA1/022 (Gross Revenue) by product line dimension |
| **Product Lines** | Cruise, Mountain, Racing, Youth |
| **Significance** | CFO's #3 priority KPI — tracks which lines are growing, flat, or declining |
| **Data Source** | [FinancialTransaction](/entities/financial-transaction.md) (Actual version, gl_account_id = FPA1/022), grouped by product line via [ProfitCenter](/entities/profit-center.md) or [ProductCategory](/entities/product-category.md) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[224]
> {"speaker": "Stefan Richter", "timestamp": "39:01", "quote": "Number three — Revenue by product line. Which lines are growing, which are flat, which are declining. Cruise, Mountain, Racing, Youth — I need to see the trend."}

**Note:** This differs from [Operational KPIs](/kpis/operational-kpis.md) KPI-02 (Product Mix), which measures percentage composition. Revenue by Product Line tracks absolute revenue amounts per product line, enabling growth-vs-decline trend analysis — the specific ask from the CFO.

---

## Metric Type Classification Summary

| FKPI | Metric | Metric Type | Rationale |
|---|---|---|---|
| FKPI-01 | Gross Revenue | multi_source_aggregation | Sum across multiple GL postings |
| FKPI-02 | Net Revenue | multi_source_aggregation | Difference of two multi-source sums (Revenue - Deductions) |
| FKPI-03 | COGS | multi_source_aggregation | Sum across multiple GL postings |
| FKPI-04 | Gross Margin | multi_source_aggregation | Difference of two multi-source sums (Net Revenue - COGS) |
| FKPI-05 | Gross Margin % | multi_source_aggregation | Ratio of two multi-source sums |
| FKPI-06 | BvA Variance | multi_source_aggregation | Difference between Actual and Budget aggregations |
| FKPI-07 | OpEx Total | multi_source_aggregation | Sum across multiple OpEx account postings |
| FKPI-08 | EBIT | multi_source_aggregation | Rollup of Gross Margin - OpEx |
| FKPI-09 | Net Income | multi_source_aggregation | Top-level P&L rollup |
| FKPI-10 | COGS Ratio | multi_source_aggregation | Ratio of two multi-source sums |
| FKPI-11 | Revenue by Product Line | multi_source_aggregation | Sum across GL postings, grouped by product line |

**Classification Rationale:** All financial KPIs are classified as `multi_source_aggregation` because they require aggregating across multiple financial transaction records (GL postings) within a period — none can be computed from a single transaction record. While Gross Margin % and COGS Ratio are ratios, both numerator and denominator require multi-source aggregation first, so the overall metric type is `multi_source_aggregation` rather than a single-record derivation. This differs from [Operational KPIs](/kpis/operational-kpis.md) KPI-02 through KPI-04, which are classified `cross_entity_calculation` because they require joining across entity tables (Product, Customer, Profit Center) — these Financial KPI ratios are computed entirely within FinancialTransaction using GL account-level filters.

---

## Not Tracked (Phase 2+ Candidates)

| Metric | Status | Source |
|---|---|---|
| Customer Profitability | Phase 2 candidate — requires shared cost allocation | Karen Liu, 44:52 |
| Cash Flow (Indirect Method) | Medium priority, data supports it (CF_I, CF_CFO, CF_D accounts) | Karen Liu, 44:16 |
| Predictive/Forecast Metrics | Phase 3 territory | Karen Liu (Kick-Off, 15:40) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[256]
> {"speaker": "Karen Liu", "timestamp": "44:52", "quote": "Low priority. Phase 2 candidate. The data supports it — we track revenue and COGS at the customer level — but computing true customer profitability requires some allocation of shared costs, which is a whole separate exercise."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[251]
> {"speaker": "Karen Liu", "timestamp": "44:16", "quote": "Medium priority. We have the CF accounts — CF_I, CF_CFO, CF_D — so the data supports it. But it's not the most frequently requested analysis."}
