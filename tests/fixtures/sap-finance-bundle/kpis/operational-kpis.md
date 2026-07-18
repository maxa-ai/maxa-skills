---
type: kpi_collection
title: Operational KPIs
description: Six operational metrics covering transaction volumes, product mix, customer concentration, monthly trends, and month-end close efficiency for VeloGroup's SAP FI financial data.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [kpis, operational, transaction-volume, customer-concentration, close-duration]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Operational KPIs

## KPI-01: Transaction Volume by Account Type

**Definition:** COUNT of transactions grouped by GL account or account type, used to spot anomalies.
**Metric Type:** multi_source_aggregation
**Frequency:** Monthly | **Target:** Anomaly detection (no fixed target) | **Owner:** Karen Liu

| Account | Transaction Count | Share |
|---------|------------------|-------|
| COGS (FPA1/020) | ~126,390 | ~75% |
| Gross Revenue (FPA1/022) | ~30,724 | ~18% |
| Sales Deductions (FPA1/023) | ~8,835 | ~5% |
| Operating Expenses (all) | Remainder | ~2% |
| **Total** | **167,136** | **100%** |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Karen Liu, 40:10
> "Transaction volumes by account type — I track those to spot anomalies. If COGS transactions suddenly spike or drop, something changed in the business and I want to investigate."

**Data Source:** [FinancialTransaction](/entities/financial-transaction.md) fact table, classified by [GLAccount](/entities/gl-account.md).

## KPI-02: Product Mix (Transaction Share by Product Line)

**Definition:** Percentage of transactions attributable to each product line.
**Metric Type:** multi_source_aggregation
**Frequency:** Monthly | **Target:** — | **Owner:** Karen Liu

| Product Line | Code | Transaction Share |
|-------------|------|-------------------|
| Cruise | CR | ~30% |
| Mountain | MT | ~30% |
| Racing | RC | ~29% |
| Youth | YH | ~9.5% |
| Other (FG, TM, RB, #) | — | ~1.5% |

**Note:** These are *transaction shares*, not revenue shares. Revenue shares may differ significantly due to varying price points across product lines.

**Data Source:** [FinancialTransaction](/entities/financial-transaction.md) × [Product](/entities/product.md) (`product_category_id`).

## KPI-03: Customer Segment Transaction Distribution

**Definition:** Percentage of financial transactions by customer segment.
**Metric Type:** multi_source_aggregation
**Frequency:** Monthly | **Target:** — | **Owner:** Karen Liu

| Segment | SAP Code | Transaction Share |
|---------|----------|-------------------|
| Speciality | Z1 | ~66% |
| Large | Z2 | ~31% |
| Medium | Z3 | <1% |
| Unassigned | # | ~2.5% |

Speciality dominates transactions (66%) due to high order frequency with small quantities. Large customers place fewer but larger orders.

**Data Source:** [FinancialTransaction](/entities/financial-transaction.md) × [Customer](/entities/customer.md) (`customer_type_id`).

## KPI-04: Customer Concentration (Top 10 as % of Revenue)

**Definition:** Top 10 customers as a percentage of total revenue — measures dependency risk.
**Metric Type:** cross_source_calculation
**Frequency:** Monthly | **Target:** <15% per individual customer | **Owner:** Stefan Richter (CFO)

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Stefan Richter, 40:40
> "Customer concentration is one I watch closely. If Skymart Corp represents more than, say, fifteen percent of our revenue, I get nervous. We can't be over-dependent on any single customer."

The 15% threshold is per individual customer, not for the top 10 combined. Stefan specifically monitors Skymart Corp for concentration risk.

**Data Source:** [FinancialTransaction](/entities/financial-transaction.md) (Gross Revenue FPA1/022) × [Customer](/entities/customer.md).

## KPI-05: Monthly Transaction Volume Trend (Year-over-Year)

**Definition:** Monthly transaction counts with year-over-year comparison to identify trends and anomalies.
**Metric Type:** multi_source_aggregation
**Frequency:** Monthly | **Target:** — | **Owner:** Karen Liu

| Year | Transactions | Notes |
|------|-------------|-------|
| 2018 | ~39,750 | Partial year (April–December) |
| 2019 | ~66,740 | Full year (baseline) |
| 2020 | ~57,130 | COVID year — Q2 dip, Q3-Q4 surge |
| 2021 | ~3,513 | January only |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Stefan Richter, 14:45
> "2020 is the COVID year. We saw a significant dip in Q2 when everything shut down, but then a huge surge in Q3 and Q4. Everyone suddenly wanted a bike."

**Data Source:** [FinancialTransaction](/entities/financial-transaction.md), time dimension via [FiscalCalendar](/entities/fiscal-calendar.md).

## KPI-06: Month-End Close Duration

**Definition:** Number of business days from month-end to completed reporting package.
**Metric Type:** process_metric
**Frequency:** Monthly | **Target:** 3 business days (from current 5) | **Owner:** Karen Liu, Stefan Richter

| Metric | Current | Target |
|--------|---------|--------|
| Total close duration | 5 business days (sometimes 6) | 3 business days |
| Accounting close | 3 days | 3 days (irreducible) |
| Extraction + reporting | 2 days | Same-day (automated) |

This is a process efficiency metric, not derived from the [FinancialTransaction](/entities/financial-transaction.md) data.

## Operational KPI Summary

| ID | KPI | Metric Type | Target | Owner |
|----|-----|-------------|--------|-------|
| KPI-01 | Transaction Volume by Account Type | multi_source_aggregation | Anomaly detection | Karen Liu |
| KPI-02 | Product Mix (Transaction Share) | multi_source_aggregation | — | Karen Liu |
| KPI-03 | Customer Segment Distribution | multi_source_aggregation | — | Karen Liu |
| KPI-04 | Customer Concentration | cross_source_calculation | <15% per customer | Stefan Richter |
| KPI-05 | Monthly Volume Trend (YoY) | multi_source_aggregation | — | Karen Liu |
| KPI-06 | Month-End Close Duration | process_metric | 3 days (from 5) | Karen Liu |

**Scope Note:** VeloGroup's Phase 1 scope is limited to SAP FI financial data, so operational KPIs are primarily transaction-volume and process-efficiency metrics rather than traditional operational metrics (production throughput, delivery times, order fulfillment rates). More granular operational KPIs would require SAP CO/MM/SD integration, deferred to Phase 2.
