---
type: numerical_example
title: Numerical Examples
description: Concrete numerical values from VeloGroup FP&A evidence sources for validation and testing, covering entity counts, transaction volumes, percentages, monetary values, and time durations.
confidence: high
source_type_tagged: true
timestamp: "2026-10-05T20:33:03Z"
tags: [numerical-examples, validation, reference]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Numerical Examples

## Purpose

Concrete numbers from VeloGroup business conversations for validation and pipeline testing. All values traced to specific evidence sources with confidence levels.

## Counts

| ID | Metric | Value | Context | Source Type | Source |
|---|---|---|---|---|---|
| N001 | Total customers | 53 | 44 US + 9 Canada | `extracted_data` | FPA Workshop, 02:28 |
| N002 | Active profit centers | 37 | 28 US + 3 Global + 4 Logistics + 2 other | `extracted_data` | Kick-Off, 05:19 |
| N003 | GL accounts | 21 | Compact parent-child hierarchy | `extracted_data` | Kick-Off, 11:33 |
| N004 | Products | 35 | 8 categories, 4 product lines | `extracted_data` | FPA Workshop, 23:33 |
| N005 | Total financial transactions | 167,136 | Actual + Budget combined | `extracted_data` | FPA Workshop, 21:00 |
| N006 | Actual transactions | 64,756 | 39% of total | `extracted_data` | FPA Workshop, 16:54 |
| N007 | Budget transactions | 102,380 | 61% of total | `extracted_data` | FPA Workshop, 16:54 |
| N008 | COGS transactions | ~125,352 | FPA1/020, derived: 75% x 167,136 (approximate — Karen Liu separately stated ~126,390; both values documented, difference is approximation) | `stakeholder_statement` | FPA Workshop, 10:05 |
| N009 | Gross Revenue transactions | ~30,724 | FPA1/022 | `stakeholder_statement` | FPA Workshop, 09:26 |
| N010 | Sales Deductions transactions | ~8,835 | FPA1/023 | `stakeholder_statement` | FPA Workshop, 09:26 |
| N011 | Account types | 5 | INC, EXP, AST, LEQ, NFIN | `extracted_data` | Kick-Off, 11:10 |
| N012 | Product categories | 8 | CR, MT, RC, YH, FG, TM, RB, # (Unassigned) | `extracted_data` | FPA Workshop, 23:52 |
| N013 | Customer segments | 4 | Z1 Speciality, Z2 Large, Z3 Medium, # Unassigned | `extracted_data` | FPA Workshop, 22:30 |
| N014 | Transactions in 2018 | ~39,750 | Partial year (Apr-Dec) | `stakeholder_statement` | FPA Workshop, 14:31 |
| N015 | Transactions in 2019 | ~66,740 | Full calendar year | `stakeholder_statement` | FPA Workshop, 14:31 |
| N016 | Transactions in 2020 | ~57,130 | Full calendar year, COVID dip Q2 then surge Q3-Q4 | `stakeholder_statement` | FPA Workshop, 14:31 |
| N016a | Transactions in 2021 (Jan only) | ~3,513 | January only — partial year | `stakeholder_statement` | FPA Workshop, 14:31 |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[14]
> {"speaker": "Karen Liu", "timestamp": "02:28", "quote": "Fifty-three customers total. Nine are in Canada, forty-four in the US. By revenue it's roughly 85-15, but I'd need to pull the exact number."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[127]
> {"speaker": "Marcus Weber", "timestamp": "21:00", "quote": "167,136. That's Actual plus Budget combined — 64,756 plus 102,380."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[87]
> {"speaker": "Priya Sharma", "timestamp": "14:31", "quote": "The year-by-year breakdown is roughly 39,750 transactions in 2018, 66,740 in 2019, 57,130 in 2020, and about 3,513 in January 2021."}

## Percentages

| ID | Metric | Value | Context | Source Type | Source |
|---|---|---|---|---|---|
| N017 | COGS transaction share | 75% | FPA1/020 dominates the dataset | `stakeholder_statement` | FPA Workshop, 10:05 |
| N018 | Speciality (Z1) transaction share | 66% | Bread and butter volume | `stakeholder_statement` | FPA Workshop, 03:41 |
| N019 | Large (Z2) transaction share | 31% | Significant but not dominant | `stakeholder_statement` | FPA Workshop, 03:13 |
| N020 | Medium (Z3) transaction share | <1% | Smallest segment | `stakeholder_statement` | FPA Workshop, 04:20 |
| N021 | US revenue share | 85% | vs ~15% Canada (approximate) | `stakeholder_statement` | FPA Workshop, 02:28 |
| N022 | Cruise transaction share | 30% | By product line | `stakeholder_statement` | FPA Workshop, 07:01 |
| N023 | Mountain transaction share | 30% | By product line | `stakeholder_statement` | FPA Workshop, 07:01 |
| N024 | Racing transaction share | 29% | By product line | `stakeholder_statement` | FPA Workshop, 07:01 |
| N024a | Youth transaction share | 9.5% | Entry-level kids' bikes | `stakeholder_statement` | FPA Workshop, 07:01 |
| N024b | Other categories transaction share | 1.5% | FG, TM, and other small categories | `stakeholder_statement` | FPA Workshop, 07:01 |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[40]
> {"speaker": "Karen Liu", "timestamp": "07:01", "quote": "Cruise accounts for about 30% of transactions, Mountain 30%, Racing 29%, Youth about 9.5%, and the remaining 1.5% is the other categories — Finished Goods, Trade Materials, and so on."}

## Monetary Values

| ID | Metric | Value | Currency | Context | Source Type | Source |
|---|---|---|---|---|---|---|
| N025 | M550 Mountain bike | 4999 | USD | Crown jewel — full carbon, full suspension | `extracted_data` | FPA Workshop, 05:44 |
| N026 | CM-FL-V00 forklift | 7900 | USD | Internal asset, not customer-facing | `extracted_data` | FPA Workshop, 06:26 |
| N027 | Y120 Youth bike | 179 | USD | Lowest price point | `extracted_data` | FPA Workshop, 06:07 |
| N028 | C900 Cruise bike | 799 | USD | Comfort/leisure standard | `extracted_data` | FPA Workshop, 05:08 |
| N029 | E15 e-bike | 3999 | USD | High-end Finished Goods category | `extracted_data` | FPA Workshop, 06:26 |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[31]
> {"speaker": "Karen Liu", "timestamp": "05:44", "quote": "Mountain bikes — M500 at $1,999, M525 at $2,499, and the M550 at $4,999."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[36]
> {"speaker": "Karen Liu", "timestamp": "06:26", "quote": "Yes. We have a Finished Goods category with some higher-end e-bikes — E15 at $3,999, E16 and E17 both at $2,499, E108 at $649, and E202 at $799. There's also a forklift in there — CM-FL-V00 at $7,900."}

## Time Values

| ID | Metric | Value | Unit | Context | Source Type | Source |
|---|---|---|---|---|---|---|
| N030 | Month-end close cycle (current) | 5 | business days | 5 business days — target is 3 days | `extracted_data` | FPA Workshop, 15:16 |
| N031 | Month-end close cycle (target) | 3 | business days | 3-day close achievable if manual reporting bottleneck eliminated | `stakeholder_statement` | FPA Workshop, 16:00 |
| N032 | Data extraction time | 2 | hours | SAP BPC extraction to CSV (Day 4 of close) | `extracted_data` | FPA Workshop, 35:18 |
| N033 | P&L consolidation time (monthly) | 6 | hours | Priya's monthly P&L build — one per product line plus consolidated | `stakeholder_statement` | FPA Workshop, 42:28 |
| N034 | Budget process duration (best case) | 8 | weeks | Karen's estimate — Sep to mid-Nov | `stakeholder_statement` | FPA Workshop, 37:36 |
| N035 | Budget process duration (typical) | 12 | weeks | Priya's estimate — Sep to late Nov, accounting for rework; corrects Karen's best-case estimate | `stakeholder_statement` | FPA Workshop, 37:41 |
| N036 | Analyst time savings (annual target) | 24 | days | 2 days/month x 12 months — ROI case for UC1+UC2 | `stakeholder_statement` | FPA Workshop, 45:10 |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[91]
> {"speaker": "Karen Liu", "timestamp": "15:16", "quote": "Five business days, yes. Here's how it breaks down. Days one through three are the actual close activities — finalizing accruals, posting adjusting entries, running cost allocations in SAP. Day four, Marcus runs the data extraction. Day five — sometimes day six if it's a bad month — Priya and I build the reporting package."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[258]
> {"speaker": "Karen Liu", "timestamp": "45:10", "quote": "Honestly, if I could get UC1 and UC2 working first, that alone would save me two days a month. That's the ROI case right there — twenty-four analyst days per year returned to higher-value work."}
