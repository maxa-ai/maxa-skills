---
type: operational_processes
title: Operational Processes
description: Six operational processes covering financial transaction flows, month-end close, data extraction, annual budget process, and master data governance for VeloGroup's SAP FI environment.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [operational-processes, month-end-close, budget, master-data, data-extraction]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Operational Processes

## Process Summary

| # | Process | Type | Key SLA/Timing | Primary Owner |
|---|---------|------|-----------------|---------------|
| 1 | Financial Transaction Flow (Revenue & COGS) | record_to_report | Continuous throughout month | SAP (automated) |
| 2 | Financial Transaction Flow (Operating Expenses) | record_to_report | Biweekly payroll; ongoing invoices | SAP (automated) |
| 3 | Month-End Close | record_to_report | 5 business days (target: 3 days) | Karen Liu, Marcus Weber, Priya Sharma |
| 4 | Data Extraction & Reporting | record_to_report | Monthly batch; ~2 hours extraction | Marcus Weber → Priya Sharma |
| 5 | Annual Budget Process | record_to_report | ~8 weeks (Sept–Nov); 1 day SAP load | Karen Liu, Marcus Weber |
| 6 | Master Data Governance | master_data_management | Ad hoc; hierarchy changes ~1-2x/year | Marcus Weber, Karen Liu |

## Process 1: Financial Transaction Flow (Revenue & COGS)

Sales orders → SAP journal entries (debit COGS, credit inventory, debit AR, credit revenue) → postings accumulate in [FinancialTransaction](/entities/financial-transaction.md) at full dimensional grain (account × customer × product × profit center × version × date).

Revenue and COGS transactions carry full dimensional detail — [Customer](/entities/customer.md), [Product](/entities/product.md), and [ProfitCenter](/entities/profit-center.md) are all populated. SAP maintains dimensional integrity at every step — you cannot post a transaction without a valid [GLAccount](/entities/gl-account.md) and valid profit center.

## Process 2: Financial Transaction Flow (Operating Expenses)

Invoices (rent, utilities, supplies), biweekly payroll runs, and travel expenses post to [FinancialTransaction](/entities/financial-transaction.md) at profit center grain only — CUSTOMERID and PRODUCTID are set to # (Unassigned) because these costs are organizational, not customer- or product-specific.

## Process 3: Month-End Close

| Day | Activity | Owner | Duration |
|-----|----------|-------|----------|
| 1-3 | Finalize accruals, adjusting entries, cost allocations | Accounting (Karen Liu) | 3 days |
| 4 | SAP BPC extraction — export full dataset to CSV (one file per table) | Marcus Weber | ~2 hours |
| 5 (sometimes 6) | Build reporting package — pivot tables, variance, charts | Priya Sharma, Karen Liu | 1-2 days |
| **Total** | **Full close cycle** | | **5 days (target: 3)** |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Stefan Richter, 15:38
> "Five days is too long. My board expects numbers within a week of month-end and I barely make it. In my previous role at a company of similar size, we closed in three days."

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Karen Liu, 16:00
> "If we can automate the reporting layer, the extraction and report-building step — days four and five — could be same-day. The close itself takes three days of accounting work regardless. So three-day close is absolutely achievable if we eliminate the manual reporting bottleneck."

## Process 4: Data Extraction & Reporting

Marcus runs SAP BPC extraction producing CSV files (one per table), validates row counts against prior month, and hands files to FP&A team. Priya imports into Excel and manually rebuilds pivot tables each month because source data shape changes prevent simple refresh.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Priya Sharma, 35:51
> "The worst part is rebuilding the pivot tables from scratch each month. The structure is always the same, but I can't just refresh because the source data changed shape. So I delete the old pivots, reimport the new CSV, and rebuild. Every single month."

## Process 5: Annual Budget Process

| Step | Activity | Owner | Timing |
|------|----------|-------|--------|
| 1 | Sales team provides volume projections by customer and product | Sales team | September |
| 2-4 | Apply pricing, estimate COGS, layer in OpEx | FP&A (Karen Liu) | Sept-Oct |
| 5 | Multiple iterations and reviews with business unit leaders | FP&A + Business units | Oct-Nov |
| 6 | CFO sign-off | Stefan Richter | Mid-November |
| 7-8 | Karen fills BPC templates; Marcus loads (~1 day) | Karen, Marcus | After sign-off |
| 9 | Validation — loaded totals [MUST] match approved totals to the penny | Marcus, Karen | Same day |

Budget data accounts for 61% of all transactions (102,380 budget vs 64,756 actual) because VeloGroup forecasts at a very granular level.

## Process 6: Master Data Governance

- **New Customer:** Sales team requests → Karen reviews and approves → Marcus creates in SAP
- **New Product:** Product approved for production → Marcus sets up in SAP
- **Hierarchy Changes:** Karen and Marcus collaborate; rare (~1-2x per year). Hierarchies were stable during the 2018-2021 data period.

For entity details, see [Customer](/entities/customer.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md).
