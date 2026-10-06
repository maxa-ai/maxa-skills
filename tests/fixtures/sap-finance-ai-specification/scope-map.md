---
type: scope_map
title: Scope Map
description: Maps VeloGroup's 10 business processes (6 operational, 6 financial, with 2 shared across both themes) to 27 business questions. Nine processes are in scope; one process (monthly data extraction) is out of scope because no business question references the extraction mechanism itself.
confidence: high
in_scope_count: 9
out_of_scope_count: 1
questions_mapped: 27
timestamp: "2026-10-05T20:33:03Z"
tags: [scope-map, processes, questions]
---

# Scope Map

## In-Scope Processes

### month_end_close
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q023

### financial_transaction_flow
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q001, Q002, Q003, Q006, Q007, Q009, Q010, Q011, Q012, Q013, Q016, Q017, Q018, Q019, Q020, Q021, Q024, Q025, Q026, Q027

### annual_budget_process
- **Source**: [Operational Processes](/themes/operational-processes.md), [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q002, Q010, Q011

### master_data_governance
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q003, Q004, Q005, Q006, Q007, Q008, Q012, Q014, Q015, Q016, Q017, Q020, Q022, Q024, Q027

### budget_vs_actual_variance_analysis
- **Source**: [Operational Processes](/themes/operational-processes.md), [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q002, Q011

### pl_consolidation_reporting
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q001, Q002, Q007, Q008, Q009, Q013, Q018, Q019, Q021, Q025, Q026, Q027

### fx_handling
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q012

### fiscal_calendar
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q017, Q018

### cost_allocation
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q024

## Out-of-Scope Processes

### monthly_data_extraction
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Reason**: No business question references the CSV extraction mechanism, row count validation, or IT delivery of files to the FP&A team. All 27 questions ask about data values, metrics, and entities produced upstream in SAP or computed in reporting — not about the batch extraction step that transfers data between systems.

## Question-to-Process Map

| Question | Processes | Reasoning |
|---|---|---|
| Q001 | financial_transaction_flow, pl_consolidation_reporting | Gross Margin % requires actual revenue and COGS transactions (produced by transaction flow) and the P&L hierarchy that defines Net Revenue and Gross Margin nodes (consolidation reporting) |
| Q002 | financial_transaction_flow, annual_budget_process, budget_vs_actual_variance_analysis, pl_consolidation_reporting | BvA Net Income variance requires actual transactions, budget plan data, the version-tagged BvA framework, and the full P&L hierarchy to roll up to Net Income |
| Q003 | financial_transaction_flow, master_data_governance | Cruise transaction share requires counting financial transactions filtered by product category — the product category classification is governed by master data |
| Q004 | master_data_governance | Total customer count (53) is a property of customer master records maintained by master data governance |
| Q005 | master_data_governance | Active profit center count (37) is a property of profit center master records maintained by master data governance |
| Q006 | financial_transaction_flow, master_data_governance | Speciality (Z1) transaction share requires transaction counts filtered by customer segment type — the Z1/Z2/Z3 classification is maintained in master data |
| Q007 | financial_transaction_flow, pl_consolidation_reporting, master_data_governance | Youth profitability requires isolating revenue and COGS transactions for Youth profit centers (master data), computing Gross Margin via the P&L hierarchy, and rolling up through the P&L consolidation structure |
| Q008 | master_data_governance, pl_consolidation_reporting | GL account count (21) is maintained by master data governance; the specific 21-account chart of accounts structure is defined by P&L consolidation reporting |
| Q009 | financial_transaction_flow, pl_consolidation_reporting | COGS transaction share (~75%) requires counting transactions filtered by GL account FPA1/020, which is defined and placed in the P&L hierarchy by consolidation reporting |
| Q010 | financial_transaction_flow, annual_budget_process | Total transaction count (167,136) spans actual transactions (financial transaction flow) and budget transactions (annual budget process) |
| Q011 | financial_transaction_flow, annual_budget_process, budget_vs_actual_variance_analysis | The 102,380 / 64,756 budget vs actual split requires both transaction sets and the version tagging (Actual vs Budget) defined by the BvA process |
| Q012 | financial_transaction_flow, master_data_governance, fx_handling | US vs Canada revenue split requires revenue transactions, customer geography from master data, and the USD pre-conversion that fx_handling performs so CAD transactions are comparable |
| Q013 | financial_transaction_flow, pl_consolidation_reporting | COGS ratio (COGS / Net Revenue) is computed from actual transactions using GL accounts placed in the hierarchy by P&L consolidation reporting |
| Q014 | master_data_governance | Product count (35) is a property of the product master records maintained by master data governance |
| Q015 | master_data_governance | Highest list price is an attribute of product master records; product pricing is set during the master data setup step |
| Q016 | financial_transaction_flow, master_data_governance | Customer concentration (>15% threshold) requires aggregating revenue transactions by individual customer — customer identity and classification are maintained by master data governance |
| Q017 | financial_transaction_flow, master_data_governance, fiscal_calendar | Revenue trend by product line (2018-2021) requires transactions tagged by product category (master data) and organized into the calendar-year monthly periods defined by fiscal calendar |
| Q018 | financial_transaction_flow, pl_consolidation_reporting, fiscal_calendar | Monthly Gross Margin trend with YoY comparison requires the GL hierarchy for Gross Margin computation (consolidation), actual transactions, and the monthly period structure defined by fiscal calendar |
| Q019 | financial_transaction_flow, pl_consolidation_reporting | Gross Revenue transaction count (~30,724) requires filtering transactions to GL account FPA1/022, which is defined within the P&L hierarchy |
| Q020 | financial_transaction_flow, master_data_governance | Profit center revenue contribution requires aggregating revenue transactions grouped by profit center, whose identities and hierarchy placement are maintained in master data |
| Q021 | financial_transaction_flow, pl_consolidation_reporting | OpEx split by Building vs Employee requires summing transactions under FPA1/024 and FPA1/026 hierarchy nodes defined by P&L consolidation reporting |
| Q022 | master_data_governance | M550 list price ($4,999) is an attribute of the product master record maintained by master data governance |
| Q023 | month_end_close | The 5-business-day SLA is a metric produced by and measured within the month-end close process — the question asks directly about a lifecycle metric of that process |
| Q024 | financial_transaction_flow, master_data_governance, cost_allocation | Identifying profit centers with unassigned OpEx requires querying transactions where customer and product are the unassigned sentinel value — a posting pattern produced because cost allocation distributes shared costs at profit center level only, without customer/product dimension |
| Q025 | financial_transaction_flow, pl_consolidation_reporting | Net Income requires rolling up all actual transactions through the full P&L hierarchy from leaf accounts to FPA1/08 (Net Income node) defined by P&L consolidation |
| Q026 | financial_transaction_flow, pl_consolidation_reporting | EBIT/Operating Income (FPA1/016) requires computing Net Revenue minus COGS minus OpEx using actual transactions and the P&L hierarchy |
| Q027 | financial_transaction_flow, master_data_governance, pl_consolidation_reporting | Gross Margin by customer segment requires joining transactions to customer segment (master data), filtering to Gross Margin GL accounts (P&L hierarchy), and aggregating by Z1/Z2/Z3 segment |

See [Business Questions](/reference/business-questions.md) for the full question text and answers, and [Modeling Decisions](/modeling-decisions.md) for the entity model that supports these processes.
