---
type: business_question
title: Business Questions with Known Answers
description: 27 validated business questions derived from VeloGroup FP&A use cases for model alignment and gap analysis, covering profitability, variance, revenue mix, and operational metrics across 8 tool categories.
confidence: high
source_type_tagged: true
timestamp: "2026-10-05T20:33:03Z"
tags: [business-questions, validation, reference]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Business Questions with Known Answers

## Purpose

These questions validate that the data model can answer real business queries. Each question exercises the data model's ability to answer a specific, validated business need.

## Tool Categories

| Category | Count | Description |
|---|---|---|
| `entity_lookup` | 6 | Direct lookup of entity attributes or known constants |
| `aggregation` | 2 | COUNT, SUM, AVG operations |
| `calculation` | 9 | Derived metrics, ratios |
| `relationship_traversal` | 3 | Cross-entity joins |
| `time_series` | 2 | Time-based analysis |
| `comparison` | 2 | Value/period comparison |
| `ranking` | 1 | TOP N, sorting |
| `filtering` | 2 | Complex conditions |

## Questions

### Q001: What is the Gross Margin percentage for VeloGroup (Net Revenue minus COGS divided by Net Revenue)?

**Answer:** NOT_MENTIONED — requires calculation from [FinancialTransaction](/entities/financial-transaction.md) data. See [Financial KPIs](/kpis/financial-kpis.md) FKPI-05.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[222]
> {"speaker": "Stefan Richter", "timestamp": "38:27", "quote": "Number one — Gross Margin percentage. Net Revenue minus COGS, divided by Net Revenue. That tells me how efficiently we're converting sales into profit before operating costs. If Gross Margin is slipping, I have a cost problem or a pricing problem, and I need to know immediately."}

### Q002: What is the dollar variance between budget and actual for Net Income?

**Answer:** NOT_MENTIONED — requires computation from Actual vs Budget transactions. See [Financial KPIs](/kpis/financial-kpis.md) FKPI-06.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[223]
> {"speaker": "Stefan Richter", "timestamp": "38:47", "quote": "Number two — Budget vs Actual variance. Both dollar variance and percentage variance. I want to see it at the P&L line level and I want to be able to drill into the dimensions to understand why we're off plan."}

### Q003: What percentage of total financial transactions belong to the Cruise product line?

**Answer:** ~30% of transactions (transaction share, not revenue share)
**Source Type:** `stakeholder_statement`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[40]
> {"speaker": "Karen Liu", "timestamp": "07:01", "quote": "Cruise accounts for about 30% of transactions, Mountain 30%, Racing 29%, Youth about 9.5%, and the remaining 1.5% is the other categories — Finished Goods, Trade Materials, and so on."}

### Q004: How many customers does VeloGroup have in total?

**Answer:** 53
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[14]
> {"speaker": "Karen Liu", "timestamp": "02:28", "quote": "Fifty-three customers total. Nine are in Canada, forty-four in the US. By revenue it's roughly 85-15, but I'd need to pull the exact number."}

### Q005: How many active profit centers does VeloGroup have?

**Answer:** 37
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[22]
> {"speaker": "Marcus Weber", "timestamp": "05:19", "quote": "Thirty-seven active profit centers. Twenty-eight under the US Division, three under what we call the Global group, that's ZG in SAP, and then four under Logistics, which is Z_LOG."}

### Q006: What percentage of financial transactions are Speciality (Z1) customer transactions?

**Answer:** ~66%
**Source Type:** `stakeholder_statement`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[20]
> {"speaker": "Priya Sharma", "timestamp": "03:41", "quote": "The Speciality channel is our bread and butter in terms of volume. About 66% of all transactions."}

### Q007: Is the Youth bike line profitable on its own, or is it a loss leader?

**Answer:** NOT_MENTIONED — key unanswered question; the data model [SHOULD] be able to resolve it once cost allocation (see [Known Gap G001](/known-gaps.md)) is clarified.
**Source Type:** `stakeholder_statement`

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[36]
> {"speaker": "Stefan Richter", "timestamp": "08:28", "quote": "The profitability by product line is critical. I want to stress that. We've been having an internal debate for, I don't know, two years now about whether the Youth bike line is actually profitable on its own or if it's essentially a loss leader that drives foot traffic and brand loyalty for our other lines. And the honest answer is, right now, we genuinely cannot answer that question with confidence. We can't isolate the costs properly."}

### Q008: How many GL accounts are in the chart of accounts?

**Answer:** 21
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[45]
> {"speaker": "Marcus Weber", "timestamp": "11:10", "quote": "Correct, five account types. Income, abbreviated INC. Expense, EXP. Assets, AST. Liabilities and Equity, LEQ. And then there's a Non-financial Income category, NFIN, which is a bit of a miscellaneous bucket for certain non-operating items."}

### Q009: What percentage of all transactions are COGS (FPA1/020)?

**Answer:** ~75%
**Source Type:** `stakeholder_statement`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[58]
> {"speaker": "Priya Sharma", "timestamp": "10:05", "quote": "Yeah. Seventy-five percent of everything in the system. It's because COGS is tracked at the full product-customer-profit center grain. Every sale generates a revenue posting and a corresponding cost posting, and the cost side tends to be more granular."}

### Q010: What is the total number of financial transactions (Actual + Budget)?

**Answer:** 167,136
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[127]
> {"speaker": "Marcus Weber", "timestamp": "21:00", "quote": "167,136. That's Actual plus Budget combined — 64,756 plus 102,380."}

### Q011: How many budget transactions vs actual transactions are there?

**Answer:** Budget: 102,380; Actual: 64,756 (61%/39% split)
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[101]
> {"speaker": "Karen Liu", "timestamp": "16:54", "quote": "102,380 budget transactions versus 64,756 actual. The split is about 61% budget, 39% actual. Budget has more rows because we forecast at a very granular level. My team builds the budget at the individual product-customer-profit center level for every month. That creates a lot of line items."}

### Q012: What percentage of total revenue is from US customers vs Canadian customers?

**Answer:** ~85% US, ~15% Canada (approximate)
**Source Type:** `stakeholder_statement`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[14]
> {"speaker": "Karen Liu", "timestamp": "02:28", "quote": "Fifty-three customers total. Nine are in Canada, forty-four in the US. By revenue it's roughly 85-15, but I'd need to pull the exact number."}

### Q013: What is the COGS ratio (COGS divided by Net Revenue)?

**Answer:** NOT_MENTIONED — requires calculation from data. See [Financial KPIs](/kpis/financial-kpis.md) FKPI-10.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[227]
> {"speaker": "Karen Liu", "timestamp": "39:40", "quote": "Operating Expense total, broken down into Building and Employee. EBIT — Operating Income after all expenses. Net Income. Budget vs Actual variance in both dollars and percentage for all of those line items. Revenue by product line. And COGS ratio — COGS divided by Net Revenue — which is basically the inverse of Gross Margin but some analysts prefer to see cost as a percentage of revenue."}

### Q014: How many products does VeloGroup have?

**Answer:** 35
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[139]
> {"speaker": "Marcus Weber", "timestamp": "23:20", "quote": "CustomerTypeTexts for the type descriptions, yes. And CustomersHierarchy with 56 rows for customer groupings — grouping customers by type and geography."}

### Q015: Which product has the highest list price?

**Answer:** CM-FL-V00 at $7,900 (internal asset, not customer-facing) or M550 at $4,999 (Mountain bike, highest-priced customer-facing product)
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[31]
> {"speaker": "Karen Liu", "timestamp": "05:44", "quote": "Mountain bikes — M500 at $1,999, M525 at $2,499, and the M550 at $4,999."}

### Q016: Does any single customer represent more than 15% of total revenue?

**Answer:** NOT_MENTIONED — the CFO monitors this threshold but current data was not stated.
**Source Type:** `stakeholder_statement`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[230]
> {"speaker": "Stefan Richter", "timestamp": "40:40", "quote": "Customer concentration is one I watch closely. If Skymart Corp represents more than, say, fifteen percent of our revenue, I get nervous. We can't be over-dependent on any single customer."}

### Q017: What is the revenue trend by product line (Cruise, Mountain, Racing, Youth) across 2018-2021?

**Answer:** NOT_MENTIONED — requires time-series computation from data; 2020 had a Q2 dip (COVID) then a Q3-Q4 surge.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[224]
> {"speaker": "Stefan Richter", "timestamp": "39:01", "quote": "Number three — Revenue by product line. Which lines are growing, which are flat, which are declining. Cruise, Mountain, Racing, Youth — I need to see the trend."}

### Q018: What is the monthly trend of Gross Margin with year-over-year comparison?

**Answer:** NOT_MENTIONED — requires time-series computation from data.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[229]
> {"speaker": "Karen Liu", "timestamp": "40:10", "quote": "Transaction volumes by account type — I track those to spot anomalies. If COGS transactions suddenly spike or drop, something changed in the business and I want to investigate. Product mix — what percentage of revenue comes from each product line. Customer concentration — top ten customers as a percentage of total revenue. Profit center contribution — each profit center's share of total revenue. And monthly trends with year-over-year comparison."}

### Q019: How many Gross Revenue transactions (FPA1/022) are there?

**Answer:** ~30,724
**Source Type:** `stakeholder_statement`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[54]
> {"speaker": "Karen Liu", "timestamp": "09:26", "quote": "Gross Margin has two children — Net Revenue at FPA1/021 and COGS at FPA1/020. Net Revenue is the difference between Gross Revenue and Sales Deductions. Gross Revenue is FPA1/022 — this is the top-line sales number. About 30,724 transactions. Sales Deductions is FPA1/023 — discounts, returns, rebates. About 8,835 transactions."}

### Q020: What is each profit center's share of total revenue (profit center contribution)?

**Answer:** NOT_MENTIONED — requires computation across 37 profit centers. See [Operational KPIs](/kpis/operational-kpis.md) KPI-04.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[229]
> {"speaker": "Karen Liu", "timestamp": "40:10", "quote": "Transaction volumes by account type — I track those to spot anomalies. If COGS transactions suddenly spike or drop, something changed in the business and I want to investigate. Product mix — what percentage of revenue comes from each product line. Customer concentration — top ten customers as a percentage of total revenue. Profit center contribution — each profit center's share of total revenue. And monthly trends with year-over-year comparison."}

### Q021: What is the Operating Expense total, split by Building vs Employee categories?

**Answer:** NOT_MENTIONED — requires aggregation from FPA1/024 (Building Expense) and FPA1/026 (Employee Expense) sub-branches. See [Financial KPIs](/kpis/financial-kpis.md) FKPI-07.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[227]
> {"speaker": "Karen Liu", "timestamp": "39:40", "quote": "Operating Expense total, broken down into Building and Employee. EBIT — Operating Income after all expenses. Net Income. Budget vs Actual variance in both dollars and percentage for all of those line items. Revenue by product line. And COGS ratio — COGS divided by Net Revenue — which is basically the inverse of Gross Margin but some analysts prefer to see cost as a percentage of revenue."}

### Q022: What is the price of the M550 Mountain bike?

**Answer:** $4,999
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[31]
> {"speaker": "Karen Liu", "timestamp": "05:44", "quote": "Mountain bikes — M500 at $1,999, M525 at $2,499, and the M550 at $4,999."}

### Q023: What is the current month-end close cycle time?

**Answer:** 5 business days
**Source Type:** `extracted_data`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[91]
> {"speaker": "Karen Liu", "timestamp": "15:16", "quote": "Five business days, yes. Here's how it breaks down. Days one through three are the actual close activities — finalizing accruals, posting adjusting entries, running cost allocations in SAP. Day four, Marcus runs the data extraction. Day five — sometimes day six if it's a bad month — Priya and I build the reporting package."}

### Q024: Which profit centers have OpEx transactions that are not customer- or product-specific (unassigned)?

**Answer:** NOT_MENTIONED — requires filtering [FinancialTransaction](/entities/financial-transaction.md) where customer_id = '#' AND product_id = '#', grouped by profit_center.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[73]
> {"speaker": "Karen Liu", "timestamp": "12:14", "quote": "Now, there's a really important distinction I want to make sure we capture. Revenue — Gross Revenue and Sales Deductions — is tracked at the full grain. Product, customer, profit center. COGS is also at the full grain. But operating expenses — Payroll, Building, Utilities — those are mostly at the profit center level only."}

### Q025: What is VeloGroup's Net Income (bottom line P&L)?

**Answer:** NOT_MENTIONED — requires full P&L computation from [FinancialTransaction](/entities/financial-transaction.md) data. See [Financial KPIs](/kpis/financial-kpis.md) FKPI-09.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[227]
> {"speaker": "Karen Liu", "timestamp": "39:40", "quote": "Operating Expense total, broken down into Building and Employee. EBIT — Operating Income after all expenses. Net Income. Budget vs Actual variance in both dollars and percentage for all of those line items. Revenue by product line. And COGS ratio — COGS divided by Net Revenue — which is basically the inverse of Gross Margin but some analysts prefer to see cost as a percentage of revenue."}

### Q026: What is VeloGroup's Operating Income (EBIT)?

**Answer:** NOT_MENTIONED — requires P&L computation: Net Revenue minus COGS minus Operating Expenses. See [Financial KPIs](/kpis/financial-kpis.md) FKPI-08.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[227]
> {"speaker": "Karen Liu", "timestamp": "39:40", "quote": "Operating Expense total, broken down into Building and Employee. EBIT — Operating Income after all expenses. Net Income. Budget vs Actual variance in both dollars and percentage for all of those line items. Revenue by product line. And COGS ratio — COGS divided by Net Revenue — which is basically the inverse of Gross Margin but some analysts prefer to see cost as a percentage of revenue."}

### Q027: What is the Gross Margin by customer segment (Speciality vs Large vs Medium)?

**Answer:** NOT_MENTIONED — requires cross-entity computation: [FinancialTransaction](/entities/financial-transaction.md) joined to [CustomerSegment](/entities/customer-segment.md), filtered by GL hierarchy.
**Source Type:** `formula`

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[229]
> {"speaker": "Karen Liu", "timestamp": "40:10", "quote": "Transaction volumes by account type — I track those to spot anomalies. If COGS transactions suddenly spike or drop, something changed in the business and I want to investigate. Product mix — what percentage of revenue comes from each product line. Customer concentration — top ten customers as a percentage of total revenue. Profit center contribution — each profit center's share of total revenue. And monthly trends with year-over-year comparison."}

## Questions by Domain

### Financial (19 questions)

| ID | Question | Answer | Tool Category |
|---|---|---|---|
| Q001 | Gross Margin % | NOT_MENTIONED | calculation |
| Q002 | BvA Variance — Net Income | NOT_MENTIONED | calculation |
| Q003 | Cruise transaction share | ~30% (transactions) | calculation |
| Q004 | Customer count | 53 | entity_lookup |
| Q005 | Profit center count | 37 | entity_lookup |
| Q008 | GL account count | 21 | entity_lookup |
| Q009 | COGS transaction share | ~75% | calculation |
| Q010 | Total transactions | 167,136 | aggregation |
| Q011 | Budget vs Actual split | 102,380 / 64,756 | comparison |
| Q012 | US vs Canada revenue | ~85% / ~15% | comparison |
| Q013 | COGS ratio | NOT_MENTIONED | calculation |
| Q016 | Customer concentration >15% | NOT_MENTIONED | filtering |
| Q019 | Gross Revenue transactions | ~30,724 | aggregation |
| Q020 | PC contribution % | NOT_MENTIONED | relationship_traversal |
| Q021 | OpEx Building vs Employee | NOT_MENTIONED | relationship_traversal |
| Q024 | OpEx profit centers (unassigned) | NOT_MENTIONED | filtering |
| Q025 | Net Income (bottom line) | NOT_MENTIONED | calculation |
| Q026 | Operating Income (EBIT) | NOT_MENTIONED | calculation |
| Q027 | Gross Margin by customer segment | NOT_MENTIONED | relationship_traversal |

### Operational (3 questions)

| ID | Question | Answer | Tool Category |
|---|---|---|---|
| Q006 | Speciality transaction share | ~66% | calculation |
| Q014 | Product count | 35 | entity_lookup |
| Q022 | M550 price | $4,999 | entity_lookup |

### Analytical (2 questions)

| ID | Question | Answer | Tool Category |
|---|---|---|---|
| Q017 | Revenue trend by product line | NOT_MENTIONED | time_series |
| Q018 | Gross Margin monthly trend YoY | NOT_MENTIONED | time_series |

### Cross-Domain (3 questions)

| ID | Question | Answer | Tool Category |
|---|---|---|---|
| Q007 | Youth line profitability | NOT_MENTIONED | calculation |
| Q015 | Highest price product | CM-FL-V00 $7,900 / M550 $4,999 | ranking |
| Q023 | Month-end close cycle time | 5 business days | entity_lookup |
