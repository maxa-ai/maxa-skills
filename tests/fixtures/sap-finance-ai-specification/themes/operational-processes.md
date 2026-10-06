---
type: business_domain
title: Operational Processes
description: VeloGroup's six core operational processes - month-end close (5-day cycle targeting 3-day), financial transaction flow, annual budget process (8-12 weeks, Sep-Nov), master data governance, monthly data extraction, and Budget vs Actual variance analysis workflow.
confidence: high
timestamp: "2026-10-05T20:11:39Z"
tags: [operational-processes, month-end-close, budget-process]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Operational Processes

## Process 1: Month-End Close (Record-to-Report)

| Field | Value |
|---|---|
| **SLA** | 5 business days current; 3-day target |
| **Entities Involved** | [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [ProfitCenter](/entities/profit-center.md), [Customer](/entities/customer.md), [Product](/entities/product.md) |
| **System Handoffs** | SAP FI -> CSV Extract -> Excel |

### Key Steps

| Step | Activity | Duration | Owner | System |
|---|---|---|---|---|
| 1 | Finalize accruals for earned/incurred but unposted revenue and expense | Days 1-3 | Karen Liu (FP&A) | SAP FI |
| 2 | Post adjusting entries (depreciation, reclassifications) | Days 1-3 | Karen Liu (FP&A) | SAP FI |
| 3 | Run cost allocations across profit centers | Days 1-3 | Karen Liu (FP&A) | SAP FI |
| 4 | Verify trial balance is balanced | Day 3 | Karen Liu (FP&A) | SAP FI |
| 5 | Run BPC data extraction (CSV export, 1 file per table) | Day 4 (~2 hours) | Marcus Weber (IT) | SAP BPC |
| 6 | Validate row counts against prior month | Day 4 | Marcus Weber (IT) | Manual |
| 7 | Build reporting package (pivot tables, variance calcs, charts) | Day 5 (-6) | Priya Sharma + Karen Liu | Excel |
| 8 | CFO review and board reporting | Day 5+ | Stefan Richter | Excel |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[91]
> {"speaker": "Karen Liu", "timestamp": "15:16", "quote": "Five business days, yes. Here's how it breaks down. Days one through three are the actual close activities — finalizing accruals, posting adjusting entries, running cost allocations in SAP. Day four, Marcus runs the data extraction. Day five — sometimes day six if it's a bad month — Priya and I build the reporting package."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[92]
> {"speaker": "Stefan Richter", "timestamp": "15:38", "quote": "Five days is too long. My board expects numbers within a week of month-end and I barely make it. In my previous role at a company of similar size, we closed in three days."}

### Pain Points

- Reporting package takes 1-2 days of analyst time every month
- Pivot tables rebuilt from scratch monthly (data changes shape)
- Excel crashes on the 167,000-row FinancialTransactions CSV — Priya lost 4 hours of work in one incident
- Ad hoc variance analysis takes ~1 hour per question in Excel

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[209]
> {"speaker": "Priya Sharma", "timestamp": "35:51", "quote": "The worst part is rebuilding the pivot tables from scratch each month. The structure is always the same, but I can't just refresh because the source data changed shape. So I delete the old pivots, reimport the new CSV, and rebuild. Every single month."}

---

## Process 2: Financial Transaction Flow

| Field | Value |
|---|---|
| **Entities Involved** | [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Customer](/entities/customer.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md) |
| **System Handoffs** | Business operations -> SAP FI (journal entries) |

### Key Steps

| Step | Activity | Owner | System |
|---|---|---|---|
| 1 | Sales orders received from customers | Sales team | SAP |
| 2 | Sale fulfilled — SAP generates journal entries (debit COGS, credit inventory, debit AR, credit revenue) | SAP (automated) | SAP FI |
| 3 | Expense invoices processed (rent, utilities, supplies) | Accounts Payable | SAP FI |
| 4 | Payroll runs biweekly — journal entries posted | Payroll | SAP FI |
| 5 | Travel expenses submitted and approved — journal entries posted | Employees / Managers | SAP FI |
| 6 | All postings accumulate at account x customer x product x profit center x date grain | SAP (automated) | SAP FI |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[201]
> {"speaker": "Karen Liu", "timestamp": "33:52", "quote": "Okay. It starts with business transactions throughout the month. Sales orders come in from customers — the sales team processes them in SAP. When a sale is fulfilled, SAP generates journal entries — a debit to COGS, a credit to inventory, a debit to accounts receivable, a credit to revenue. Those postings accumulate throughout the month."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[203]
> {"speaker": "Marcus Weber", "timestamp": "34:34", "quote": "And SAP maintains the dimensional integrity at every step. You can't post a transaction without a valid GL account, a valid profit center. The system enforces it."}

### Dimensional Integrity Note

SAP [MUST] enforce that every financial transaction has valid references to GL Account and Profit Center. Customer and Product [MAY] be the unassigned sentinel value ('#') for OpEx transactions.

---

## Process 3: Annual Budget Process

| Field | Value |
|---|---|
| **SLA** | 8-12 weeks (September to mid/late-November) |
| **Entities Involved** | [FinancialTransaction](/entities/financial-transaction.md) (budget version), [Customer](/entities/customer.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md), [GLAccount](/entities/gl-account.md) |
| **System Handoffs** | Excel templates -> SAP BPC import |

### Key Steps

| Step | Activity | Duration | Owner |
|---|---|---|---|
| 1 | Sales team provides volume projections by customer and product | September | Sales |
| 2 | Apply pricing to get revenue projections | ~2 weeks | Karen Liu / Priya |
| 3 | Estimate COGS based on current costs and expected changes | ~2 weeks | Karen Liu / Priya |
| 4 | Layer in operating expenses (headcount, leases, travel, utilities) | ~2 weeks | Karen Liu / Priya |
| 5 | Multiple iterations and reviews with business unit leaders | ~2-4 weeks | FP&A + Business Units |
| 6 | CFO sign-off on final budget | Mid-November | Stefan Richter |
| 7 | Fill out BPC import templates (account x customer x product x PC x period x value) | ~1 day | Karen Liu |
| 8 | Marcus loads into SAP BPC | ~1 day | Marcus Weber |
| 9 | Validate loaded totals tie to Karen's approved numbers to the penny | Same day | Marcus Weber + Karen Liu |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[216]
> {"speaker": "Karen Liu", "timestamp": "37:10", "quote": "Annual exercise. My team starts building the budget in September. We work bottom-up — the sales team provides volume projections by customer and product. We apply pricing to get revenue. We estimate COGS based on current costs and expected changes. We layer in operating expenses — headcount plans for payroll, lease agreements for building, historical patterns for travel and utilities."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[218]
> {"speaker": "Priya Sharma", "timestamp": "37:41", "quote": "I'd actually put it closer to twelve weeks, Karen. By the time we account for the rework after the first business unit review round, we're consistently starting in September and not closing it out until late November. Eight weeks is the best case, not the typical case."}

### Budget Volume

Budget produces 102,380 transactions vs 64,756 actual transactions. Budget has more rows because it is built at the individual product-customer-profit center level for every month.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[101]
> {"speaker": "Karen Liu", "timestamp": "16:54", "quote": "102,380 budget transactions versus 64,756 actual. The split is about 61% budget, 39% actual. Budget has more rows because we forecast at a very granular level. My team builds the budget at the individual product-customer-profit center level for every month. That creates a lot of line items."}

---

## Process 4: Master Data Governance

| Field | Value |
|---|---|
| **Entities Involved** | [Customer](/entities/customer.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md), Hierarchy Nodes |
| **System Handoffs** | Business request -> Approval -> SAP master data |

### Key Steps

| Step | Activity | Owner |
|---|---|---|
| 1 | New customer requested by sales team | Sales |
| 2 | Karen Liu reviews and approves | Karen Liu (FP&A) |
| 3 | Marcus creates customer in SAP — master record, customer type, hierarchy links | Marcus Weber (IT) |
| 4 | New product approved for production | Product team |
| 5 | Marcus sets up product master data — category, pricing, hierarchy placement | Marcus Weber (IT) |
| 6 | Hierarchy changes (rare, 1-2x/year) — Karen and Marcus collaborate | Karen Liu + Marcus Weber |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[213]
> {"speaker": "Marcus Weber", "timestamp": "36:28", "quote": "New customers are requested by the sales team. Karen reviews and approves. Then I create the customer in SAP — set up the master record, assign the customer type, link them to the appropriate hierarchy nodes. Same for products — once a new product is approved for production, I set it up in the master data with category, pricing, hierarchy placement."}

---

## Process 5: Monthly Data Extraction & Delivery

| Field | Value |
|---|---|
| **SLA** | ~2 hours for extraction; Day 4 of close cycle |
| **System Handoffs** | SAP BPC -> CSV files -> Excel (FP&A) |

### Key Steps

| Step | Activity | Owner |
|---|---|---|
| 1 | Close process completes (day 3) | Accounting |
| 2 | Marcus runs BPC reports that export the full data set to CSV (1 file per table) | Marcus Weber |
| 3 | Extraction takes ~2 hours | Marcus Weber |
| 4 | Row count validation vs prior month (expected growth check) | Marcus Weber |
| 5 | Hand CSV files to Karen's team | Marcus Weber -> FP&A |
| 6 | FP&A imports CSVs into Excel for pivot tables and reporting | Priya Sharma |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[207]
> {"speaker": "Marcus Weber", "timestamp": "35:18", "quote": "I run a set of BPC reports that export the full data set to CSV. One file per table. The extraction process takes about two hours. I check the row counts against the prior month — if the FinancialTransactions table grew by roughly the expected number of rows, I know the extraction worked. Then I hand the files to Karen's team."}

**Note:** This process is out of scope for the question-mapped analytics model — see [Scope Map](/scope-map.md) for the reasoning.

---

## Process 6: Budget vs Actual Variance Analysis (Reporting Workflow)

| Field | Value |
|---|---|
| **Entities Involved** | [FinancialTransaction](/entities/financial-transaction.md) (both versions), [GLAccount](/entities/gl-account.md), [Customer](/entities/customer.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md) |

### Current-State Workflow

1. Karen rebuilds comparison spreadsheet each month from scratch (cannot append)
2. Manual formula re-linking for dollar variance and percentage variance
3. When a variance question arises (e.g., "Why is Mountain over budget by 8%?"), Karen drills into SAP at GL account level — ~1 hour per question
4. Cross-dimensional variance analysis (by customer type, by product) is one dimension at a time in Excel

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[39]
> {"speaker": "Karen Liu", "timestamp": "09:28", "quote": "Painful. The word is painful. We have both actual and budget data in SAP, but pulling them side by side and doing meaningful variance analysis is entirely manual. Every month I'm rebuilding the same comparison in Excel. And I mean literally rebuilding, because the way the data comes out of SAP, it's not in a format where I can just append a new month. I'm copying formulas, re-linking cells, praying nothing breaks. And then when there's a variance, inevitably someone asks \"why is Mountain bikes over budget by 8%?\" and then I'm back in SAP trying to drill down to the GL account level to figure out what happened."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[109]
> {"speaker": "Karen Liu", "timestamp": "18:22", "quote": "In theory, yes. In practice, cross-dimensional variance analysis in Excel is painful. I can do it for one dimension at a time. If Stefan asks \"why is Gross Margin off budget in the Cruise line?\" I have to go back to the raw data, filter for Cruise profit centers, compare budget to actual for each account, and try to find the story. That takes an hour."}
