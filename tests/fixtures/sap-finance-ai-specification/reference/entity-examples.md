---
type: entity_examples
title: Entity Examples
description: Concrete entity examples scoped to the 6 ERE-confirmed entities — Customer, FinancialTransaction, GLAccount, Product, ProfitCenter, and FiscalCalendar — with sample IDs, values, and discovery hints.
confidence: high
source_type_tagged: true
timestamp: 2026-07-15T16:00:00Z
tags: [entity-examples, sample-data, discovery-hints, validation]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Entity Examples

Examples scoped to ERE-confirmed entities only. Classification entities (GLAccountType, CustomerType, ProductCategory) and hierarchy entities (GLAccountsHierarchy, CustomersHierarchy, ProductHierarchy, ProfitCenterHierarchy) were absorbed into their parent entities during modeling — their examples are included under the relevant parent entity sections below.

## Customer Examples

| Customer ID | Name | Type | Country |
|-------------|------|------|---------|
| LACU_S02 | TechCycle | Z1 (Speciality) | US |
| LACU_S11 | The Cycle Factor | Z1 (Speciality) | US |
| LACU_L01 | Skymart Corp | Z2 (Large) | US |
| LACU_L02 | Bigmart | Z2 (Large) | US |
| LACU_M01 | Suburban Cycle | Z3 (Medium) | US |

**Source type:** workshop_transcript — Workshop, Karen Liu, 31:24

**Customer Type Classification (absorbed as `customer_type_id` attribute):**

| Code | Name | Description |
|------|------|-------------|
| Z1 | Speciality | Independent bike shops, premium dealers (~66% transaction share) |
| Z2 | Large | Big box retailers, sporting goods chains (~31% transaction share) |
| Z3 | Medium | Regional chains (<1% transaction share) |
| # | Unassigned | Non-customer-specific transactions (~2.5%) |

## Financial Transaction Examples

| Type | Account | Customer | Product | Profit Center | Value | Version |
|------|---------|----------|---------|--------------|-------|---------|
| Revenue | FPA1/022 | LACU_S02 | M550 | US10_PCM1L | $4,999 | Actual |
| COGS | FPA1/020 | LACU_S02 | M550 | US10_PCM1L | $2,500 | Actual |
| OpEx (Payroll) | FPA1/033 | # | # | US10_PCC1L | $8,500 | Actual |

**Grain:** account × customer × product × profit center × version × date. Revenue and COGS carry full dimensional detail; OpEx carries profit center only with # for customer and product.

## GL Account Examples

| Account ID | Name | Type | Level | Is Leaf | Parent |
|------------|------|------|-------|---------|--------|
| FPA1/08 | Net Income | — | 1 | No | (root) |
| FPA1/09 | EBIT | — | 2 | No | FPA1/08 |
| FPA1/017 | Gross Margin | — | 4 | No | FPA1/016 |
| FPA1/022 | Gross Revenue | INC | 6 | Yes | FPA1/021 |
| FPA1/020 | COGS | EXP | 5 | Yes | FPA1/017 |
| FPA1/023 | Sales Deductions | INC | 6 | Yes | FPA1/021 |
| FPA1/033 | Payroll | EXP | 6 | Yes | FPA1/026 |

**Source type:** workshop_transcript — Workshop, Karen Liu, 07:47-12:01

**Account Type Classification (absorbed as `account_type_id` attribute):**

| Code | Name | Description |
|------|------|-------------|
| INC | Income | Revenue accounts (primary P&L focus) |
| EXP | Expense | COGS and operating costs |
| AST | Asset | Balance sheet assets |
| LEQ | Liabilities & Equity | Balance sheet liabilities/equity |
| NFIN | Non-Financial | Statistical accounts (headcount, sq footage) |

## Product Examples

| Product ID | Name | Category | Price | Notes |
|------------|------|----------|-------|-------|
| M550 | Mountain M550 | MT | $4,999 | Crown jewel — full carbon, full suspension |
| M500 | Mountain M500 | MT | $1,999 | |
| M525 | Mountain M525 | MT | $2,499 | |
| E101 | Cruise E101 | CR | $1,144 | Surprise hit e-bike |
| C900 | Cruise C900 | CR | $799 | |
| R100 | Racing R100 | RC | $1,250 | |
| Y120 | Youth Y120 | YH | $179 | Entry-level |
| E15 | FG E15 | FG | $3,999 | Premium e-bike |
| CM-FL-V00 | Forklift | FG | $7,900 | Internal asset (not sellable) |

**Source type:** workshop_transcript — Workshop, various speakers, 05:08-06:47

**Product Category Classification (absorbed as `product_category_id` attribute):**

| Code | Name | Transaction Share |
|------|------|-------------------|
| CR | Cruise | ~30% |
| MT | Mountain | ~30% |
| RC | Racing | ~29% |
| YH | Youth | ~9.5% |
| FG | Finished Goods | ~1.5% combined |
| TM | Trade Materials | Minor |
| RB | Raw Materials | Minor |
| # | Unassigned | — |

## Profit Center Examples

| PC ID | Name | Group | Product Line | Channel |
|-------|------|-------|-------------|---------|
| US10_PCC1L | Cruise Cycles - Large, Sub-1 | US Division | Cruise | Large |
| US10_PCC1S | Cruise Cycles - Small, Sub-1 | US Division | Cruise | Speciality |
| US10_PCM1L | Mountain Bikes - Large, Sub-1 | US Division | Mountain | Large |
| US10_PCR1S | Racing Bikes - Small, Sub-1 | US Division | Racing | Speciality |
| US10_PCY1L | Youth Bikes - Large, Sub-1 | US Division | Youth | Large |
| ZG_PCC1 | Global Cruise | Global | Cruise | — |
| ZG_PCM1 | Global Mountain | Global | Mountain | — |
| Z_LOG_PC7 | Logistics PC7 | Logistics | — | — |
| YB_PC01 | Year-end Adjustments | Year-end | — | — |

**ID Encoding:** `{CountryCode}{CompanyCode}_PC{LineCode}{SubID}{SizeCode}`. PCC=Cruise, PCM=Mountain, PCR=Racing, PCY=Youth. L=Large, S=Small/Speciality.

**Source type:** workshop_transcript — Workshop, Marcus Weber, 27:31

**Profit Center Structure:** 37 total — US Division (28), Global (3), Logistics (4), Year-end (1). Youth has only 4 PCs (missing Sub-2) vs 6 for other lines due to consolidation.

## Fiscal Calendar Examples

| Field | Value |
|-------|-------|
| Fiscal year structure | Calendar year (Jan 1 – Dec 31), 12 monthly periods |
| Data start | April 2018 (SAP migration completion) |
| Data end | January 2021 |
| Reporting currency | USD |
| Close duration | 5 business days (target: 3) |
| Budget cycle | 8 weeks (September – mid-November) |
| SAP extraction | ~2 hours |

**Source type:** workshop_transcript — Workshop, Karen Liu, 14:04-14:19
