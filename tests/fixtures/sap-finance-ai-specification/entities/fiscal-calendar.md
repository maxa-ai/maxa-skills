---
type: entity
title: Fiscal Calendar
entity_name: FiscalCalendar
entity_slug: fiscal-calendar
description: Fiscal calendar defining the reporting year structure, period boundaries, and reporting currency for financial analytics.
confidence: high
entity_type: domain_dimension
domain: finance
version: "1.0.0"
last_updated: 2026-05-28T00:00:00Z
relationships:
  - FinancialTransaction
tags: [fiscal-year, calendar, reporting-periods, currency, month-end-close, budget-cycle]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| 1:N | [FinancialTransaction](/entities/financial-transaction.md) | Each fiscal calendar year defines the reporting period boundaries for financial transactions posted during that year |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `fiscal_year` | NUMBER | Yes | The fiscal reporting year (e.g., 2018, 2019, 2020, 2021). VeloGroup uses calendar year alignment. | Q001, Q018, Q020, Q024 |
| `fiscal_year_start_date` | DATE | Yes | First day of the fiscal year (January 1 for VeloGroup's calendar year alignment). | Q001 |
| `fiscal_year_end_date` | DATE | Yes | Last day of the fiscal year (December 31 for VeloGroup's calendar year alignment). | Q001 |
| `period_type` | STRING | Yes | Type of reporting period subdivision (e.g., 'monthly'). VeloGroup uses standard monthly periods — no 4-4-5 or offset calendar. | Q001 |
| `periods_per_year` | NUMBER | Yes | Number of reporting periods in the fiscal year. 12 for VeloGroup's monthly calendar. | Q001 |
| `reporting_currency` | STRING | Yes | Primary reporting currency for all financial analytics. USD for VeloGroup — SAP handles FX conversion at posting time. | Q004 |
| `close_duration_days` | NUMBER | Yes | Number of business days the month-end close process takes. Currently 5 days with a target of 3 days. | Q003 |
| `close_duration_target_days` | NUMBER | Yes | Target number of business days for the month-end close. CFO target is 3 days, down from current 5. | Q003 |
| `budget_cycle_weeks` | NUMBER | Yes | Duration of the annual budget building process in weeks. Currently 8 weeks (September through mid-November). | Q005 |
| `extraction_duration_hours` | NUMBER | Yes | Duration of the SAP BPC data extraction process in hours. Currently approximately 2 hours. | Q006 |
| `time_savings_days_per_month` | NUMBER | Yes | Estimated monthly time savings from automating P&L and variance analysis. Currently 2 days per month (24 analyst-days per year). | Q014 |
| `pl_build_hours_per_month` | NUMBER | Yes | Hours per month spent building the P&L reporting package. Currently at least 6 hours per month for the full set. | Q015 |
| `data_start_date` | DATE | Yes | Earliest date of available SAP data. April 2018 — when VeloGroup completed the SAP migration from the legacy system. | Q020 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `fiscal_year_start_date_timezone` | STRING | Yes | Timezone offset for the fiscal year start date, because temporal precision [MUST] be preserved for systems that consume date boundaries across time zones. |
| `fiscal_year_end_date_timezone` | STRING | Yes | Timezone offset for the fiscal year end date, because temporal precision [MUST] be preserved for systems that consume date boundaries across time zones. |
| `data_start_date_timezone` | STRING | Yes | Timezone offset for the data start date, because temporal precision [MUST] be preserved for systems that consume date boundaries across time zones. |
| `defined_date` | DATE | Yes | Business date when the fiscal calendar structure was established for this reporting year. |
| `defined_date_timezone` | STRING | Yes | Timezone offset for the defined date, because temporal precision [MUST] be preserved for systems that consume date boundaries across time zones. |

## Supported Processes

- Fiscal calendar definition — standard calendar year (January 1 through December 31) with 12 monthly periods
- Month-end close process — 5 business day cycle (target: 3 days) covering accruals, adjustments, SAP extraction, and reporting package build
- Currency and FX handling — USD as primary reporting currency; SAP handles CAD→USD conversion at posting time

## Supported Questions

- [Q001: What is VeloGroup's fiscal year-end?](/reference/business-questions.md) — December 31 (calendar year alignment)
- [Q003: How long does month-end close take?](/reference/business-questions.md) — 5 business days (target: 3)
- [Q004: What is the primary reporting currency?](/reference/business-questions.md) — USD
- [Q005: How long is the budget cycle?](/reference/business-questions.md) — 8 weeks (September through mid-November)
- [Q006: How long does SAP data extraction take?](/reference/business-questions.md) — Approximately 2 hours
- [Q014: How much time would automation of P&L and variance analysis save?](/reference/business-questions.md) — 2 days per month (24 analyst-days per year)
- [Q015: How long does Priya spend building the P&L reporting package?](/reference/business-questions.md) — At least 6 hours per month
- [Q018: What is the monthly transaction volume trend year-over-year?](/reference/business-questions.md) — FiscalCalendar provides the date dimension for time-series analysis
- [Q020: When did SAP data begin?](/reference/business-questions.md) — April 2018 (SAP migration completion)
- [Q024: Which year had the highest transaction volume?](/reference/business-questions.md) — FiscalCalendar provides the year dimension for ranking

## Business Rules Affecting This Entity

No business rules from the shared rule set directly affect FiscalCalendar. The fiscal calendar structure is defined by VeloGroup's organizational choices (calendar year alignment, monthly periods, USD reporting currency) rather than by data transformation or quality rules.

For context on how FiscalCalendar interacts with transaction-level rules, see the business rules in [FinancialTransaction](/entities/financial-transaction.md).

## Data Conventions for This Entity

No data conventions from the source system directly affect FiscalCalendar. The entity's attributes are derived from workshop-confirmed business definitions rather than from SAP table encoding conventions.

**Cross-reference:** The BIGINT YYYYMMDD date encoding convention (documented in [FinancialTransaction](/entities/financial-transaction.md)) governs how transaction posting dates are stored in SAP, and those dates [MUST] be correctly parsed to align with the fiscal calendar's period boundaries.

## Additional Context

### Fiscal Year Structure

VeloGroup uses a standard calendar year with no exotic period structures:

| Field | Value |
|---|---|
| Fiscal year start | January 1 |
| Fiscal year end | December 31 |
| Period type | Monthly (12 periods) |
| Calendar type | Standard — no 4-4-5, no offset fiscal year |

> "Calendar year. January 1 through December 31. Monthly reporting periods. We don't do anything exotic — no 4-4-5 calendar, no offset fiscal year. Plain vanilla."
> — Karen Liu, Workshop, 14:04

### Currency Context

| Field | Value |
|---|---|
| Primary / Reporting currency | USD |
| Product pricing currency | USD |
| Functional currencies | USD, CAD |
| FX conversion | At posting rate in SAP — VALUE column always in USD |

> "Simple story. Primary currency is USD. All products priced in USD. Our Canadian customers transact in CAD, but in the dataset the amounts are converted to USD equivalent at the posting rate."
> — Karen Liu, Workshop, 18:52

> "The SAP extract handles the FX conversion. Everything in the VALUE column is in USD. No multi-currency work needed on the analytics side."
> — Marcus Weber, Workshop, 19:04

### Data Scope

| Field | Value |
|---|---|
| Data start | April 2018 (SAP migration completion) |
| Data end | January 2021 |
| Total transactions | 167,136 (64,756 actual + 102,380 budget) |

> "The data starts in April 2018 because that's when we completed the SAP migration from the legacy system."
> — Marcus Weber, Kick-Off, 13:30

> "April 2018 through January 2021. So we have a partial 2018, two full calendar years — 2019 and 2020 — and just January of 2021."
> — Karen Liu, Workshop, 14:19

### Month-End Close Calendar

| Day | Activity | Owner | Duration |
|---|---|---|---|
| 1-3 | Finalize accruals, adjusting entries, cost allocations | Accounting (Karen Liu) | 3 days |
| 4 | SAP BPC extraction to CSV | Marcus Weber | ~2 hours |
| 5 (sometimes 6) | Build reporting package | Priya Sharma, Karen Liu | 1-2 days |
| **Total** | **Full close cycle** | | **5 days (target: 3)** |

> "Five days is too long. My board expects numbers within a week of month-end and I barely make it. In my previous role at a company of similar size, we closed in three days."
> — Stefan Richter, Workshop, 15:38

### Budget Calendar

| Milestone | Timing | Owner |
|---|---|---|
| Budget building starts | September | FP&A team (Karen Liu) |
| Volume projections from sales | September | Sales team |
| Multiple iterations and reviews | October–November | FP&A + Business units |
| CFO sign-off | Mid-November | Stefan Richter |
| SAP BPC load | After sign-off (~1 day) | Marcus Weber |
| Validation (must tie to penny) | Same day as load | Marcus Weber, Karen Liu |

> "It's about eight weeks of work. Multiple iterations, reviews with business unit leaders. Stefan signs off on the final version, usually mid-November. Then Marcus loads it."
> — Karen Liu, Workshop, 37:36

### Modeling Decision Context

FiscalCalendar was added as an implied entity during modeling — no draft entity existed, but the fiscal_calendar process is in-scope and multiple business questions depend on fiscal period definitions, reporting currency, and data scope boundaries. Several operational process questions (Q003, Q005, Q006, Q014, Q015) are answered via FiscalCalendar attributes rather than requiring separate entities, because these values are known constants from workshop transcripts.
