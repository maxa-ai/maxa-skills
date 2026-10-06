---
type: kpi_collection
title: Operational KPIs
description: Five operational/analytical metrics covering transaction volumes, product mix, customer concentration, profit center contribution, and monthly revenue trends for VeloGroup's FP&A platform.
confidence: high
timestamp: "2026-10-05T20:19:27Z"
tags: [kpi, operational, financial-transaction, customer, product, profit-center]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Operational KPIs

**Boundary Note:** These KPIs are operational/analytical metrics used to monitor business activity and composition. Financial P&L KPIs (Gross Margin %, COGS Ratio, Budget Variance, EBIT, etc.) are documented in [Financial KPIs](/kpis/financial-kpis.md). The distinction: operational KPIs here measure volumes, mix, and concentration; financial KPIs measure monetary P&L line items and ratios.

---

## KPI-01: Transaction Volume by Account Type

| Field | Value |
|---|---|
| **Definition** | COUNT of transactions grouped by GL account type (INC, EXP, AST, LEQ, NFIN) and individual GL account |
| **Metric Type** | multi_source_aggregation |
| **Domain** | operational |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED — used for anomaly detection, no explicit target |
| **Owner** | Karen Liu (FP&A) |
| **Data Source** | [FinancialTransaction](/entities/financial-transaction.md) (filtered to Actual version) |
| **Entities Aggregated** | [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) |

### Purpose

Karen tracks transaction volumes to spot anomalies. Sudden spikes or drops in COGS or revenue transaction counts signal business changes that warrant investigation.

### Known Benchmark Values

| Account | Transaction Count | % of Total |
|---|---|---|
| COGS (FPA1/020) | ~126,390 | ~75% |
| Gross Revenue (FPA1/022) | ~30,724 | ~18% |
| Sales Deductions (FPA1/023) | ~8,835 | ~5% |
| Operating Expense (various) | ~1,187 (calculated) | ~1% |
| Total (Actual + Budget) | 167,136 | 100% |
| Actual only | 64,756 | 39% |
| Budget only | 102,380 | 61% |

**Note:** The above counts are combined Actual + Budget. The Actual-only breakdown by account was not explicitly provided. The Operating Expense count (~1,187) is a calculated remainder (167,136 − 126,390 − 30,724 − 8,835), not a value stated directly by a stakeholder.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[229]
> {"speaker": "Karen Liu", "timestamp": "40:10", "quote": "Transaction volumes by account type — I track those to spot anomalies. If COGS transactions suddenly spike or drop, something changed in the business and I want to investigate. Product mix — what percentage of revenue comes from each product line. Customer concentration — top ten customers as a percentage of total revenue. Profit center contribution — each profit center's share of total revenue. And monthly trends with year-over-year comparison."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[58]
> {"speaker": "Priya Sharma", "timestamp": "10:05", "quote": "Yeah. Seventy-five percent of everything in the system. It's because COGS is tracked at the full product-customer-profit center grain. Every sale generates a revenue posting and a corresponding cost posting, and the cost side tends to be more granular."}

---

## KPI-02: Product Mix (% of Revenue by Product Line)

| Field | Value |
|---|---|
| **Definition** | SUM(Gross Revenue) per product line / SUM(Gross Revenue) total × 100 |
| **Metric Type** | cross_entity_calculation |
| **Domain** | operational |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **Owner** | Karen Liu (FP&A) / Stefan Richter (CFO) |
| **Data Source** | [FinancialTransaction](/entities/financial-transaction.md) joined to [Product](/entities/product.md) and [ProductCategory](/entities/product-category.md) |
| **Entities Aggregated** | [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md), [ProductCategory](/entities/product-category.md) |

### Known Product Lines

- Cruise (CR) — road/touring bikes
- Mountain (MT) — off-road bikes
- Racing (RC) — performance bikes
- Youth (YH) — children's bikes
- Finished Goods (FG) — internal asset, minimal transactions

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[224]
> {"speaker": "Stefan Richter", "timestamp": "39:01", "quote": "Number three — Revenue by product line. Which lines are growing, which are flat, which are declining. Cruise, Mountain, Racing, Youth — I need to see the trend."}

---

## KPI-03: Customer Concentration (Top 10 as % of Revenue)

| Field | Value |
|---|---|
| **Definition** | SUM(Gross Revenue for top 10 customers) / SUM(Gross Revenue total) × 100 |
| **Metric Type** | cross_entity_calculation |
| **Domain** | operational |
| **Frequency** | Monthly |
| **Target** | Customer revenue [SHOULD NOT] exceed 15% of total revenue for any single customer — the CFO's stated concentration threshold |
| **Owner** | Stefan Richter (CFO) |
| **Data Source** | [FinancialTransaction](/entities/financial-transaction.md) joined to [Customer](/entities/customer.md) |
| **Entities Aggregated** | [FinancialTransaction](/entities/financial-transaction.md), [Customer](/entities/customer.md) |

### Context

| Segment | Transaction Share | Revenue Share (approx.) |
|---|---|---|
| Speciality (Z1) | ~66% of transactions | NOT_MENTIONED |
| Large (Z2) | ~31% of transactions | NOT_MENTIONED |
| Medium (Z3) | < 1% of transactions | NOT_MENTIONED |
| Unassigned (#) | ~2.5% of transactions | N/A (OpEx) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[230]
> {"speaker": "Stefan Richter", "timestamp": "40:40", "quote": "Customer concentration is one I watch closely. If Skymart Corp represents more than, say, fifteen percent of our revenue, I get nervous. We can't be over-dependent on any single customer."}

**Note:** Transaction share does not equal revenue share. Speciality shops have higher transaction count but may have lower per-transaction value than Large customers, who place fewer, larger orders. The exact revenue split by segment was not stated with precision — Karen Liu indicated she would need to pull the exact number.

---

## KPI-04: Profit Center Contribution (% of Total Revenue)

| Field | Value |
|---|---|
| **Definition** | SUM(Revenue for profit center) / SUM(Revenue total) × 100 |
| **Metric Type** | cross_entity_calculation |
| **Domain** | operational |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **Owner** | Karen Liu (FP&A) |
| **Data Source** | [FinancialTransaction](/entities/financial-transaction.md) grouped by [ProfitCenter](/entities/profit-center.md) |
| **Entities Aggregated** | [FinancialTransaction](/entities/financial-transaction.md), [ProfitCenter](/entities/profit-center.md) |

### Profit Center Structure

Profit centers encode product line AND channel: `US10_PCC1L` = US, Company Code 10, Cruise, Sub-ID 1, Large channel. 37 total profit centers across US Division, Global (ZG), and Logistics (Z_LOG).

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[151]
> {"speaker": "Karen Liu", "timestamp": "25:10", "quote": "The profit center is our primary management reporting dimension. I can't stress this enough. When Stefan asks \"how is Cruise doing?\" we don't look at the product category — we look at the profit centers under Cruise. Because the profit center captures not just the product line but also the channel — Large versus Speciality."}

**Domain Classification Note:** Although KPI-04 measures revenue, it is classified as operational because it analyzes the structural composition and relative contribution of profit centers — an organizational lens — rather than computing a P&L line item. This metric uses revenue as a denominator for an organizational composition analysis, not as a P&L output, which is why it is grouped with operational rather than financial KPIs.

---

## KPI-05: Monthly Revenue Trend with YoY Comparison

| Field | Value |
|---|---|
| **Definition** | SUM(Gross Revenue) per month, compared to the same month in the prior year |
| **Metric Type** | multi_source_aggregation |
| **Domain** | operational |
| **Frequency** | Monthly |
| **Target** | NOT_MENTIONED |
| **Owner** | Stefan Richter (CFO) / Karen Liu (FP&A) |
| **Data Source** | [FinancialTransaction](/entities/financial-transaction.md) (revenue accounts, Actual version) |
| **Entities Aggregated** | [FinancialTransaction](/entities/financial-transaction.md) |

### Context

Stefan specifically highlighted the importance of monthly trending for understanding seasonal patterns — particularly the COVID-era 2020 data where Q2 dipped and Q3–Q4 surged.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[88]
> {"speaker": "Stefan Richter", "timestamp": "14:45", "quote": "2020 is the COVID year. We saw a significant dip in Q2 when everything shut down, but then a huge surge in Q3 and Q4. Everyone suddenly wanted a bike. The annual total doesn't tell the full story — you'd need to see the monthly trend to understand what really happened."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[89]
> {"speaker": "Danny Le", "timestamp": "15:02", "quote": "We'll definitely build monthly trending into the analytics. Year-over-year comparison is one of the standard views."}

**Domain Classification Note:** Although KPI-05 tracks revenue amounts, it is classified as operational because it measures temporal patterns and seasonality rather than reporting a P&L aggregate. The absolute revenue amounts are captured in [Financial KPIs](/kpis/financial-kpis.md) FKPI-01 (Gross Revenue) and FKPI-11 (Revenue by Product Line); this KPI focuses on the month-over-month trend and year-over-year comparison pattern.
