---
type: fiscal_calendar
title: Fiscal Calendar Reference
description: Fiscal year structure, reporting periods, currency context, data scope, month-end close calendar, and budget calendar for VeloGroup International.
confidence: high
source_type_tagged: true
timestamp: 2026-07-15T16:00:00Z
tags: [fiscal-calendar, reporting-periods, currency, budget-calendar, close-process]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Fiscal Calendar Reference

## Fiscal Year Structure

| Field | Value |
|-------|-------|
| Fiscal year end | December 31 |
| Period type | Monthly |
| Periods per year | 12 |
| Calendar type | Standard monthly — no 4-4-5, no offset fiscal year |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Karen Liu, 14:04
> "Calendar year. January 1 through December 31. Monthly reporting periods. We don't do anything exotic — no 4-4-5 calendar, no offset fiscal year. Plain vanilla."

**Source type:** workshop_transcript

## Currency Context

| Field | Value |
|-------|-------|
| Primary/Reporting currency | USD |
| Product pricing currency | USD |
| Functional currencies | USD, CAD |
| FX conversion | At posting rate in SAP — VALUE column always in USD |
| Multi-currency analytics needed? | No — SAP handles conversion before extract |

**Source type:** workshop_transcript — Workshop, Karen Liu, 18:52; Marcus Weber, 19:04

## Data Scope

| Year | Transactions | Coverage |
|------|-------------|----------|
| 2018 | ~39,750 | Partial (April–December) — SAP migration completed April 2018 |
| 2019 | ~66,740 | Full calendar year (baseline) |
| 2020 | ~57,130 | Full calendar year — COVID impact |
| 2021 | ~3,513 | January only |
| **Total** | **167,136** | **April 2018 – January 2021** |

**Source type:** workshop_transcript — Workshop, Priya Sharma, 14:31; Marcus Weber, 13:30

## Month-End Close Calendar

| Day | Activity | Owner | Duration |
|-----|----------|-------|----------|
| 1-3 | Finalize accruals, adjusting entries, cost allocations | Accounting (Karen Liu) | 3 days |
| 4 | SAP BPC extraction to CSV | Marcus Weber | ~2 hours |
| 5 (sometimes 6) | Build reporting package | Priya Sharma, Karen Liu | 1-2 days |
| **Total** | **Full close cycle** | | **5 days (target: 3)** |

**Source type:** workshop_transcript — Workshop, Karen Liu, 15:16; Stefan Richter, 15:38

## Budget Calendar

| Milestone | Timing | Owner |
|-----------|--------|-------|
| Budget building starts | September | FP&A team (Karen Liu) |
| Volume projections from sales | September | Sales team |
| Multiple iterations and reviews | October–November | FP&A + Business units |
| CFO sign-off | Mid-November | Stefan Richter |
| SAP BPC load | After sign-off (~1 day) | Marcus Weber |
| Validation (must tie to penny) | Same day as load | Marcus Weber, Karen Liu |

**Source type:** workshop_transcript — Workshop, Karen Liu, 37:36; Marcus Weber, 37:48

## Period Mapping

Standard calendar year — periods map 1:1 to calendar months. No offset or custom period mapping needed. P9 (September) marks budget building start; P11 (November) is typical budget sign-off month; P12 (December) is year-end close.

For the FiscalCalendar entity with all attributes, see [FiscalCalendar](/entities/fiscal-calendar.md).
