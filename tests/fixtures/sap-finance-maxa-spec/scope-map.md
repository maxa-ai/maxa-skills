---
type: scope_map
title: Scope Map
description: Maps 13 business processes to 25 business questions. Twelve of 13 processes are in scope; Cash Flow Reporting is out of scope as no business question references CF accounts.
confidence: high
timestamp: 2026-07-15T16:00:00Z
in_scope_count: 12
out_of_scope_count: 1
questions_mapped: 25
tags: [scope-map, process-mapping, question-coverage]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Scope Map

## In-Scope Processes

### Financial Transaction Flow (Revenue & COGS)
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q010, Q012, Q013, Q016, Q018, Q019, Q021, Q022, Q023, Q024, Q025

### Financial Transaction Flow (OpEx)
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q010, Q012, Q013, Q025

### Month-End Close
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q003, Q006, Q014, Q015

### Data Extraction & Reporting
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q006, Q014, Q015

### Annual Budget Process
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q005, Q010, Q013

### Master Data Governance
- **Source**: [Operational Processes](/themes/operational-processes.md)
- **Supporting questions**: Q007, Q008, Q009, Q011, Q017, Q022

### Chart of Accounts & P&L Hierarchy
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q002, Q012, Q023, Q025

### Month-End Close Process
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q003, Q006, Q014, Q015

### P&L Consolidation & Reporting
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q014, Q015

### Budget vs Actual Process
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q005, Q013

### Fiscal Calendar
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q001, Q004, Q018, Q020, Q024

### Currency & FX Handling
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Supporting questions**: Q004

## Out-of-Scope Processes

### Cash Flow Reporting
- **Source**: [Financial Processes](/themes/financial-processes.md)
- **Reason**: None of the 25 business questions reference CF accounts. Medium priority (UC-05). Available if Phase 1 scope expands.

## Question-to-Process Map

| Question | Processes | Reasoning |
|----------|-----------|-----------|
| Q001 | Fiscal Calendar | Fiscal year-end = Dec 31 |
| Q002 | Chart of Accounts | GL account count = 21 |
| Q003 | Month-End Close | Close duration = 5 days (target 3) |
| Q004 | Fiscal Calendar, Currency/FX | Reporting currency = USD |
| Q005 | Budget Process | Budget cycle = 8 weeks |
| Q006 | Month-End Close, Data Extraction | SAP extraction = ~2 hours |
| Q007 | Master Data Governance | Customer count = 53 |
| Q008 | Master Data Governance | Product count = 35 |
| Q009 | Master Data Governance | Profit center count = 37 |
| Q010 | Transaction Flows, Budget | Total transactions = 167,136 |
| Q011 | Master Data Governance | US customers = 44 |
| Q012 | Transaction Flows, Chart of Accounts | COGS share = ~75% |
| Q013 | Transaction Flows, Budget | Budget/Actual split = 61%/39% |
| Q014 | Close, Extraction, Consolidation | Time savings = 2 days/month |
| Q015 | Close, Extraction, Consolidation | P&L build time = ≥6 hours/month |
| Q016 | Revenue Transaction Flow, MDG | Speciality share = ~66% |
| Q017 | Master Data Governance | Highest price = M550 at $4,999 |
| Q018 | Transaction Flows, Fiscal Calendar | YoY volume change |
| Q019 | Revenue Transaction Flow, MDG | E-bike growth = ~40% |
| Q020 | Fiscal Calendar, Transaction Flow | Data start = April 2018 |
| Q021 | Transaction Flows, MDG | Speciality vs Large = 66% vs 31% |
| Q022 | Transaction Flow, MDG | Product line shares |
| Q023 | Transaction Flow, Chart of Accounts | Concentration threshold = 15% |
| Q024 | Transaction Flows, Fiscal Calendar | Highest volume year = 2019 |
| Q025 | Transaction Flows, Chart of Accounts | Dimensional grain rules |

All 25 questions are mapped to at least one in-scope process. See [Business Questions](/reference/business-questions.md) for full question details.
