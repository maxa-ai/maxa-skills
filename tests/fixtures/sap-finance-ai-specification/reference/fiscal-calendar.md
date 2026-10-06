---
type: fiscal_calendar
title: Fiscal Calendar and Financial Context
description: VeloGroup's fiscal calendar - calendar year (Jan 1 - Dec 31), monthly reporting periods, USD primary currency with CAD converted at posting rate, and data range covering fiscal 2018-2021.
confidence: high
timestamp: "2026-10-05T20:33:03Z"
tags: [fiscal-calendar, currency, reference]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Fiscal Calendar and Financial Context

## Fiscal Year

| Field | Value | Confidence |
|---|---|---|
| Fiscal year end | December 31 | High |
| Fiscal year type | Calendar year (Jan 1 - Dec 31) | High |
| Period type | Monthly (P1-P12) | High |
| Calendar variant | Standard calendar year — no 4-4-5, no offset | High |
| Reporting periods per year | 12 | High |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[84]
> {"speaker": "Karen Liu", "timestamp": "14:04", "quote": "Calendar year. January 1 through December 31. Monthly reporting periods. We don't do anything exotic — no 4-4-5 calendar, no offset fiscal year. Plain vanilla."}

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[55]
> {"speaker": "Marcus Weber", "timestamp": "13:30", "quote": "That's correct. Fiscal year runs on a calendar year basis, so December 31 year-end. The data starts in April 2018 because that's when we completed the SAP migration from the legacy system. Prior to that... the data is in the old system and it's, um..."}

## Period Mapping

| Period | Calendar Month | Notes |
|---|---|---|
| P1 | January | First month of fiscal/calendar year |
| P2 | February | |
| P3 | March | |
| P4 | April | Data begins Apr 2018 (SAP migration) |
| P5 | May | |
| P6 | June | |
| P7 | July | |
| P8 | August | |
| P9 | September | Budget process begins |
| P10 | October | |
| P11 | November | Budget process completes (mid-to-late Nov) |
| P12 | December | Year-end |

**Note:** Since VeloGroup's fiscal year aligns with the calendar year, P1 = January and P12 = December. No period offset or remapping is needed.

## Currency Context

| Field | Value | Confidence |
|---|---|---|
| Primary/reporting currency | USD | High |
| Functional currencies | USD, CAD | High |
| FX approach | Pre-converted at posting rate in SAP | High |
| Multi-currency work required | No — all values in the extract are already in USD | High |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[111]
> {"speaker": "Karen Liu", "timestamp": "18:52", "quote": "Simple story. Primary currency is USD. All products priced in USD. Our Canadian customers transact in CAD, but in the dataset the amounts are converted to USD equivalent at the posting rate."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[112]
> {"speaker": "Marcus Weber", "timestamp": "19:04", "quote": "The SAP extract handles the FX conversion. Everything in the VALUE column is in USD. No multi-currency work needed on the analytics side."}

**FX Note:** The specific posting rate methodology (spot rate, average rate, month-end rate) was not clarified. "Posting rate" likely means the rate at the time each transaction is posted, but this was not explicitly stated. No separate FX rate table exists in the data export.

## Data Scope

| Field | Value | Source |
|---|---|---|
| Data range | April 2018 - January 2021 | Karen Liu, FPA Workshop 14:19 |
| Full fiscal years | 2019, 2020 (complete) | Inferred from data range |
| Partial years | 2018 (Apr-Dec), 2021 (Jan only) | Karen Liu, FPA Workshop 14:19 |
| Data source | SAP FI (star schema: 1 fact table + 18 dimension tables) | Marcus Weber |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[86]
> {"speaker": "Karen Liu", "timestamp": "14:19", "quote": "April 2018 through January 2021. So we have a partial 2018, two full calendar years — 2019 and 2020 — and just January of 2021."}

### Transaction Volume by Year

| Year | Transaction Count | Notes |
|---|---|---|
| 2018 | ~39,750 | Partial year (Apr-Dec) |
| 2019 | ~66,740 | Full year |
| 2020 | ~57,130 | Full year — COVID dip Q2, surge Q3-Q4 |
| 2021 | ~3,513 | January only |
| **Total** | **167,136** | Actual (64,756) + Budget (102,380) |

**Note:** Individual yearly counts are approximate and do not sum exactly to the total of 167,136 (sum of yearly approximations: 167,133; difference: 3 transactions). The total of 167,136 is the exact value stated by Marcus Weber and takes precedence. See [Numerical Examples](/reference/numerical-examples.md) for source-type tagging of these values.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[87]
> {"speaker": "Priya Sharma", "timestamp": "14:31", "quote": "The year-by-year breakdown is roughly 39,750 transactions in 2018, 66,740 in 2019, 57,130 in 2020, and about 3,513 in January 2021."}

## Month-End Close Timing

| Field | Value | Source |
|---|---|---|
| Current close cycle | 5 business days | Karen Liu, 15:16 |
| Target close cycle | 3 business days | Stefan Richter / Karen Liu |
| Extraction timing | Day 4 of close (~2 hours) | Marcus Weber, 35:18 |
| Reporting package | Day 5 (sometimes Day 6) | Karen Liu, 15:16 |

## Budget Cycle

| Field | Value | Source |
|---|---|---|
| Budget start | September | Karen Liu, 37:10 |
| Budget duration | 8-12 weeks (best case 8, typical 12) | Karen Liu 37:36 / Priya Sharma 37:41 |
| Budget completion | Mid-to-late November | Karen Liu, 37:36 |
| Budget loading | ~1 day (BPC import templates) | Marcus Weber, 17:31 |
| Budget grain | Account x Customer x Product x Profit Center x Month | Karen Liu, 16:54 |

See [FinancialTransaction](/entities/financial-transaction.md) for the `version` attribute that discriminates Actual from Budget postings, and [Financial Processes](/themes/financial-processes.md) Process 5 for the fiscal calendar process documentation.
