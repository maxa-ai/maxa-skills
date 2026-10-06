---
type: kpi_collection
title: Financial KPIs
description: Fifteen financial metrics covering the P&L from Gross Revenue through Net Income, budget variance, revenue segmentation, and profitability analysis for VeloGroup's FP&A analytics platform.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [kpis, financial, gross-margin, budget-variance, revenue, profitability, p-and-l]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Financial KPIs

## Stefan's Top 3 Priority Metrics

| Rank | Metric | Why |
|------|--------|-----|
| #1 | Gross Margin % (FKPI-05) | "Tells me how efficiently we're converting sales into profit" |
| #2 | Budget vs Actual Variance (FKPI-10/11) | "How I hold the business accountable" |
| #3 | Revenue by Product Line (FKPI-12) | "Which lines are growing, which are flat, which are declining" |

## FKPI-01: Gross Revenue

**Definition:** Total top-line sales — sum of all postings to FPA1/022 (Gross Revenue leaf account).
**Formula:** `SUM(VALUE) WHERE ACCOUNTID = 'FPA1/022'`
**Metric Type:** multi_source_aggregation | **Frequency:** Monthly | **Owner:** Karen Liu
**Transaction Volume:** ~30,724 transactions

**Data Source:** [FinancialTransaction](/entities/financial-transaction.md) classified by [GLAccount](/entities/gl-account.md).

## FKPI-02: Net Revenue

**Definition:** Gross Revenue minus Sales Deductions (discounts, returns, rebates).
**Formula:** `SUM(FPA1/022) - SUM(FPA1/023)`
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Karen Liu

Net Revenue is hierarchy rollup node FPA1/021 — computed by summing its children per the hierarchy-driven arithmetic rule.

## FKPI-03: COGS

**Definition:** Total cost of goods sold — sum of all postings to FPA1/020.
**Formula:** `SUM(VALUE) WHERE ACCOUNTID = 'FPA1/020'`
**Metric Type:** multi_source_aggregation | **Frequency:** Monthly | **Owner:** Karen Liu
**Transaction Volume:** ~126,390 transactions (~75% of total)

## FKPI-04: Gross Margin

**Definition:** Net Revenue minus COGS — measures profit after direct costs.
**Formula:** `(SUM(FPA1/022) - SUM(FPA1/023)) - SUM(FPA1/020)`
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Stefan Richter (CFO)

Gross Margin is hierarchy rollup node FPA1/017.

## FKPI-05: Gross Margin Percentage

**Definition:** Gross Margin as a percentage of Net Revenue.
**Formula:** `(Net Revenue - COGS) / Net Revenue × 100`
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Stefan Richter — #1 priority metric

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Stefan Richter, 38:27
> "Number one — Gross Margin percentage. Net Revenue minus COGS, divided by Net Revenue. That tells me how efficiently we're converting sales into profit before operating costs. If Gross Margin is slipping, I have a cost problem or a pricing problem, and I need to know immediately."

Available with drill-down across all dimensions (product line, customer type, profit center).

## FKPI-06: COGS Ratio

**Definition:** COGS as a percentage of Net Revenue — inverse of Gross Margin %.
**Formula:** `COGS / Net Revenue × 100`
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Karen Liu

## FKPI-07: Operating Expense Total

**Definition:** Total operating expenses — sum of Building, Employee, and Other OpEx.
**Formula:** `SUM(VALUE) WHERE ACCOUNTID IN (FPA1/028, FPA1/029, FPA1/032, FPA1/033, FPA1/034, FPA1/035, FPA1/027)`
**Metric Type:** multi_source_aggregation | **Frequency:** Monthly | **Owner:** Karen Liu

| Category | Hierarchy Node | Leaf Accounts |
|----------|---------------|---------------|
| Building Expense | FPA1/024 | Periodic (FPA1/028), Utilities (FPA1/029) |
| Employee Expense | FPA1/026 | Office (FPA1/032), Payroll (FPA1/033), Travel (FPA1/034), Employee Other (FPA1/035) |
| Other OpEx | FPA1/027 | FPA1/027 (leaf) |

Operating expenses are at profit center grain only (CUSTOMERID=# and PRODUCTID=#).

## FKPI-08: EBIT

**Definition:** Operating Income — Gross Margin minus Operating Expenses.
**Formula:** `Gross Margin - Operating Expense Total` (hierarchy rollup at FPA1/09)
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Karen Liu

**Note:** The P&L hierarchy shows Net Income (FPA1/08) as the direct parent of EBIT (FPA1/09) with no intermediate nodes documented. Whether Net Income = EBIT or there are undocumented items (interest, taxes) between them is flagged in [Known Gaps](/known-gaps.md).

## FKPI-09: Net Income

**Definition:** Bottom-line profit — root of the P&L hierarchy.
**Formula:** Hierarchy rollup at FPA1/08 (root node)
**Metric Type:** multi_source_aggregation | **Frequency:** Monthly | **Owner:** Karen Liu, Stefan Richter

## FKPI-10: Budget vs Actual Variance (Dollar)

**Definition:** Actual value minus Budget value for each P&L line item.
**Formula:** `SUM(VALUE WHERE VERSION='Actual') - SUM(VALUE WHERE VERSION='Budget')` per account
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Stefan Richter — #2 priority metric

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Stefan Richter, 39:01
> "Number two — Budget vs Actual variance. Both dollar variance and percentage variance. I want to see it at the P&L line level and I want to be able to drill into the dimensions to understand why we're off plan."

## FKPI-11: Budget vs Actual Variance (Percentage)

**Definition:** Variance as a percentage of budget for each P&L line item.
**Formula:** `(Actual - Budget) / Budget × 100` per account
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Stefan Richter

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Karen Liu, 43:03
> "I want both dollar variance and percentage variance side by side. A $50,000 variance in Gross Revenue means something different than a $50,000 variance in Travel expense."

## FKPI-12: Revenue by Product Line

**Definition:** Gross Revenue broken down by product line (Cruise, Mountain, Racing, Youth).
**Formula:** `SUM(FPA1/022) GROUP BY ProductLine` (via [ProfitCenter](/entities/profit-center.md) hierarchy or product category)
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Stefan Richter — #3 priority metric

[ProfitCenter](/entities/profit-center.md) is the primary management reporting dimension — Karen recommends using the profit center hierarchy for product line grouping.

## FKPI-13: Profit Center Contribution (% of Total Revenue)

**Definition:** Each profit center's share of total revenue.
**Formula:** `SUM(FPA1/022 per PC) / SUM(FPA1/022 total) × 100`
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Karen Liu

## FKPI-14: Contribution Margin by Product Line

**Definition:** Revenue minus COGS per product line — measures product line profitability before shared costs.
**Formula:** `(SUM(Revenue) - SUM(COGS))` per product line via [ProfitCenter](/entities/profit-center.md) hierarchy
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Karen Liu

## FKPI-15: Gross Margin by Product

**Definition:** Product-level profitability — revenue minus COGS for individual products.
**Formula:** `(SUM(Revenue WHERE PRODUCTID = X) - SUM(COGS WHERE PRODUCTID = X))` per product
**Metric Type:** cross_source_calculation | **Frequency:** Monthly | **Owner:** Stefan Richter, Karen Liu

Enabled by the fact that both revenue and COGS are tracked at the full product grain. True product profitability with allocated operating expenses is deferred to Phase 2 (UC-07).

## Financial KPI Summary

| ID | KPI | Metric Type | Priority | Formula Basis |
|----|-----|-------------|----------|---------------|
| FKPI-01 | Gross Revenue | multi_source_aggregation | High | SUM(FPA1/022) |
| FKPI-02 | Net Revenue | cross_source_calculation | High | FPA1/022 - FPA1/023 |
| FKPI-03 | COGS | multi_source_aggregation | High | SUM(FPA1/020) |
| FKPI-04 | Gross Margin | cross_source_calculation | High (#1) | Net Revenue - COGS |
| FKPI-05 | Gross Margin % | cross_source_calculation | High (#1) | GM / Net Revenue × 100 |
| FKPI-06 | COGS Ratio | cross_source_calculation | High | COGS / Net Revenue × 100 |
| FKPI-07 | OpEx Total | multi_source_aggregation | Medium | SUM(OpEx leaf accounts) |
| FKPI-08 | EBIT | cross_source_calculation | High | GM - OpEx |
| FKPI-09 | Net Income | multi_source_aggregation | High | Hierarchy root (FPA1/08) |
| FKPI-10 | BvA Variance ($) | cross_source_calculation | High (#2) | Actual - Budget |
| FKPI-11 | BvA Variance (%) | cross_source_calculation | High (#2) | (A - B) / B × 100 |
| FKPI-12 | Revenue by Product Line | cross_source_calculation | High (#3) | Revenue GROUP BY product line |
| FKPI-13 | PC Contribution | cross_source_calculation | Medium | PC Revenue / Total Revenue |
| FKPI-14 | Contribution Margin | cross_source_calculation | Medium | (Revenue - COGS) per line |
| FKPI-15 | Gross Margin by Product | cross_source_calculation | Medium | (Revenue - COGS) per product |

## Drill-Down Requirements

All financial KPIs require dimensional drill-down across: P&L hierarchy, product line, customer segment, individual profit center, individual customer, and individual product.

## Channel Profitability Analysis (Strategic Question)

Speciality shops have higher per-unit margins. Large retailers receive significant volume discounts through Sales Deductions (FPA1/023). The strategic question — which channel is more profitable overall — is partially answerable via FKPI-04/05 sliced by customer segment. Full analysis with allocated shared costs is Phase 2.
