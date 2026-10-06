---
type: business_domain
title: Financial Processes
description: VeloGroup's financial processes - P&L consolidation across 37 profit centers, budget vs actual variance analysis, annual budget cycle (Sep-Nov), FX handling (all values pre-converted to USD), fiscal calendar (calendar year Jan-Dec), and cost allocation across profit centers.
confidence: high
timestamp: "2026-10-05T20:19:27Z"
tags: [financial-processes, pl-hierarchy, fx, fiscal-calendar, cost-allocation]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Financial Processes

**Cross-Reference Note:** The operational execution steps of the month-end close (5-day timeline, team assignments, system handoffs) are documented in [Operational Processes](/themes/operational-processes.md), Process 1. This theme documents the financial structure and logic of these processes — consolidation scope, budget design, FX rules, and fiscal calendar.

---

## Process 1: P&L Consolidation Reporting

| Field | Value |
|---|---|
| **Scope** | All 37 profit centers across US Division, Global (ZG), and Logistics (Z_LOG) |
| **Hierarchy** | Net Income -> EBIT -> Operating Income -> Gross Margin + Operating Expense |
| **Report Set** | One P&L per product line (Cruise, Mountain, Racing, Youth) + consolidated company-wide P&L |
| **Current Method** | Manual Excel consolidation from SAP CSV extract |
| **Current Duration** | ~6 hours per month (Priya) for the full set |
| **Target** | Self-service P&L by profit center or group, for any month or date range |

### Consolidation Structure

The P&L is built from 21 GL accounts organized in a parent-child hierarchy. Transactions [MUST] post only to leaf accounts; parent nodes [MUST] be calculated sums, never direct posting targets. See [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) for the full hierarchy entity.

| Level | Node | Account ID | Calculation |
|---|---|---|---|
| 1 | Net Income | FPA1/08 | Rollup of EBIT |
| 2 | EBIT | FPA1/09 | Rollup of Operating Income |
| 3 | Operating Income | FPA1/016 | Gross Margin - Operating Expense |
| 4 | Gross Margin | FPA1/017 | Net Revenue - COGS |
| 5 | Net Revenue | FPA1/021 | Gross Revenue - Sales Deductions |
| 6 (leaf) | Gross Revenue | FPA1/022 | ~30,724 transactions |
| 6 (leaf) | Sales Deductions | FPA1/023 | ~8,835 transactions |
| 5 (leaf) | COGS | FPA1/020 | ~126,390 transactions (75% of total) |
| 4 | Operating Expense | FPA1/018 | Building + Employee + Other Operating |
| 5 | Building Expense | FPA1/024 | Periodic + Utilities |
| 6 (leaf) | Periodic | FPA1/028 | Rent, insurance, property-related costs |
| 6 (leaf) | Utilities | FPA1/029 | Utility costs |
| 5 | Employee Expense | FPA1/026 | Office + Payroll + Travel + Employee Other |
| 6 (leaf) | Office | FPA1/032 | Office expenses |
| 6 (leaf) | Payroll | FPA1/033 | Payroll expenses |
| 6 (leaf) | Travel | FPA1/034 | Travel expenses |
| 6 (leaf) | Employee Other | FPA1/035 | Other employee expenses |
| 5 | Other Operating Expense | FPA1/027 | Leaf accounts NOT_MENTIONED |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[51]
> {"speaker": "Karen Liu", "timestamp": "08:58", "quote": "No, I have it memorized. Twenty-one accounts, I could recite them in my sleep at this point. Under Net Income sits EBIT — FPA1/09. Under EBIT is Operating Income — FPA1/016."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[54]
> {"speaker": "Karen Liu", "timestamp": "09:26", "quote": "Gross Margin has two children — Net Revenue at FPA1/021 and COGS at FPA1/020. Net Revenue is the difference between Gross Revenue and Sales Deductions. Gross Revenue is FPA1/022 — this is the top-line sales number. About 30,724 transactions. Sales Deductions is FPA1/023 — discounts, returns, rebates. About 8,835 transactions."}

### Profit Center as Primary Reporting Dimension

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[151]
> {"speaker": "Karen Liu", "timestamp": "25:10", "quote": "The profit center is our primary management reporting dimension. I can't stress this enough. When Stefan asks \"how is Cruise doing?\" we don't look at the product category — we look at the profit centers under Cruise. Because the profit center captures not just the product line but also the channel — Large versus Speciality."}

### Dimensional Grain by Account Type

| Account Type | Customer Dimension | Product Dimension | Profit Center |
|---|---|---|---|
| Revenue (FPA1/022, FPA1/023) | Full grain | Full grain | Full grain |
| COGS (FPA1/020) | Full grain | Full grain | Full grain |
| Operating Expense (FPA1/028-035) | Unassigned ('#') | Unassigned ('#') | Full grain |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[73]
> {"speaker": "Karen Liu", "timestamp": "12:14", "quote": "Now, there's a really important distinction I want to make sure we capture. Revenue — Gross Revenue and Sales Deductions — is tracked at the full grain. Product, customer, profit center. COGS is also at the full grain. But operating expenses — Payroll, Building, Utilities — those are mostly at the profit center level only."}

---

## Process 2: Budget vs Actual Variance Analysis

| Field | Value |
|---|---|
| **Frequency** | Monthly |
| **Versions** | Two: Actual and Budget |
| **Structure** | Same dimensional structure for both versions — account, customer, product, profit center, date, value |
| **Transaction Volumes** | 102,380 budget vs 64,756 actual (61%/39% split) |
| **Variance Types** | Dollar variance and percentage variance, side by side |
| **Drill-down Scope** | From Net Income down to leaf accounts; across all dimensions (product line, customer type, profit center) |
| **Current Pain** | Cross-dimensional variance analysis takes ~1 hour per question in Excel |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[97]
> {"speaker": "Karen Liu", "timestamp": "16:25", "quote": "Two versions in the system — Actual and Budget. Every single transaction in the FinancialTransactions table is tagged with one or the other. Same dimensional structure for both — account, customer, product, profit center, date, value."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[105]
> {"speaker": "Stefan Richter", "timestamp": "17:44", "quote": "Budget vs Actual variance analysis is probably my most requested report. Every month I want to see where we're off plan, by how much, and more importantly, why."}

---

## Process 3: Annual Budget Process

| Field | Value |
|---|---|
| **Start** | September |
| **Duration** | 8-12 weeks (best case 8 weeks per Karen; typical 12 weeks per Priya) |
| **Completion** | Mid-to-late November |
| **Methodology** | Bottom-up: sales volume projections -> pricing -> revenue -> COGS estimates -> OpEx line items |
| **Budget Grain** | Individual product x customer x profit center x month |
| **Loading** | Karen fills BPC import templates; Marcus runs import jobs (~1 day) |
| **Validation Gate** | Loaded totals [MUST] tie to Karen's approved numbers to the penny |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[219]
> {"speaker": "Marcus Weber", "timestamp": "37:48", "quote": "I have BPC import templates that Karen fills out. The templates mirror the fact table structure — account, customer, product, profit center, period, value. I run the import jobs, then we validate. The loaded budget totals have to match Karen's approved totals to the penny before I sign off."}

---

## Process 4: FX Handling

| Field | Value |
|---|---|
| **Primary Currency** | USD |
| **FX Approach** | Pre-converted at posting rate in SAP — all values in the extract are in USD |
| **Canadian Customers** | Transact in CAD; amounts converted to USD equivalent at posting rate before export |
| **Analytics Impact** | No multi-currency work needed on the analytics side |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[111]
> {"speaker": "Karen Liu", "timestamp": "18:52", "quote": "Simple story. Primary currency is USD. All products priced in USD. Our Canadian customers transact in CAD, but in the dataset the amounts are converted to USD equivalent at the posting rate."}

**Known Gap:** The specific posting rate methodology (spot rate, average rate, month-end rate) was not clarified. No separate FX rate table exists in the data export.

---

## Process 5: Fiscal Calendar

| Field | Value |
|---|---|
| **Fiscal Year** | Calendar year: January 1 through December 31 |
| **Reporting Periods** | Monthly |
| **Calendar Type** | Standard calendar year — no 4-4-5 calendar, no offset fiscal year |
| **Data Range** | Fiscal 2018 through 2021 (in-scope for Phase 1) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[84]
> {"speaker": "Karen Liu", "timestamp": "14:04", "quote": "Calendar year. January 1 through December 31. Monthly reporting periods. We don't do anything exotic — no 4-4-5 calendar, no offset fiscal year. Plain vanilla."}

See [Fiscal Calendar reference](/reference/fiscal-calendar.md) for the full calendar and currency context.

---

## Process 6: Cost Allocation

| Field | Value |
|---|---|
| **Timing** | Days 1-3 of month-end close |
| **Scope** | Shared costs allocated across profit centers |
| **Frequency** | Monthly |
| **Owner** | Karen Liu (FP&A) |
| **Method** | NOT_MENTIONED (specific allocation methodology not discussed) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[205]
> {"speaker": "Karen Liu", "timestamp": "34:47", "quote": "Right. Month-end close starts on the first business day after the month ends. Days one through three are accounting activities — finalizing accruals for any revenue or expense that was earned or incurred but not yet posted. Adjusting entries for things like depreciation. Cost allocations — we allocate some shared costs across profit centers."}

**Known Gap:** The specific cost allocation methodology (e.g., headcount-based, square-footage-based) was not discussed. Statistical accounts for headcount, square footage, and capacity metrics exist in SAP for allocation purposes. This is tracked as [Known Gap G001](/known-gaps.md).

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[46]
> {"speaker": "Karen Liu", "timestamp": "08:13", "quote": "Statistical accounts. Headcount, square footage, capacity metrics. Things we track for allocation and reporting purposes that aren't monetary amounts."}

---

## Not Discussed

| Topic | Status |
|---|---|
| Intercompany Transactions | NOT_MENTIONED — no intercompany elimination process was discussed |
| Chart of Accounts Maintenance | NOT_MENTIONED — CoA changes mentioned as rare (1-2 times/year) but no formal process described |
| Revenue Recognition Timing | NOT_MENTIONED — specific recognition point (at shipment, at delivery, at invoice) not discussed |
| Audit Process | NOT_MENTIONED |
