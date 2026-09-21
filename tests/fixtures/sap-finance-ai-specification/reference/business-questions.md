---
type: business_question
title: Business Questions
description: Twenty-two validated business questions with known answers for model alignment, covering financial calculations, entity lookups, aggregations, time-series analysis, and rankings across VeloGroup's FP&A domain.
confidence: high
source_type_tagged: true
timestamp: 2026-07-15T16:00:00Z
tags: [business-questions, model-alignment, validation, q-and-a]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Business Questions

Every question passes the litmus test: answering it requires the business data model (entities and KPIs) to be correctly built.

## Tool Category Distribution

| Category | Count | Description |
|----------|-------|-------------|
| calculation | 7 | Derived metrics, ratios, percentages |
| aggregation | 5 | COUNT, SUM operations |
| time_series | 3 | Time-based analysis |
| relationship_traversal | 3 | Cross-entity joins |
| entity_lookup | 2 | Direct lookup of entity attributes |
| comparison | 1 | Value/period comparison |
| ranking | 1 | TOP N, sorting |

## Questions

### Q001: Gross Margin Percentage
**Answer:** Requires calculation — `(Net Revenue - COGS) / Net Revenue × 100`
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Stefan Richter, 38:27

### Q002: Budget vs Actual Dollar Variance for Gross Revenue
**Answer:** Requires calculation — `Actual - Budget for FPA1/022`
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Stefan Richter, 39:01

### Q003: Budget vs Actual Percentage Variance
**Answer:** Requires calculation — `(Actual - Budget) / Budget × 100` per account
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Karen Liu, 43:03

### Q004: Revenue by Product Line
**Answer:** Requires aggregation — `SUM(FPA1/022) GROUP BY product line` via [ProfitCenter](/entities/profit-center.md) hierarchy
**Category:** aggregation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [ProfitCenter](/entities/profit-center.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Stefan Richter, 39:13

### Q005: Customer Concentration (Revenue Share per Customer)
**Answer:** <15% per customer is the threshold (Stefan monitors Skymart Corp)
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [Customer](/entities/customer.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Stefan Richter, 40:40

### Q006: Youth Bike Line Profitability
**Answer:** Unresolved for 2 years; answerable at gross margin level in Phase 1
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md) | **Difficulty:** complex
**Source type:** kickoff_transcript — Kick-Off, Stefan Richter, 08:28

### Q007: Channel Profitability — Speciality vs Large
**Answer:** Speciality has higher margins per unit; Large gets volume discounts via Sales Deductions (FPA1/023)
**Category:** comparison | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Customer](/entities/customer.md) | **Difficulty:** complex
**Source type:** kickoff_transcript — Kick-Off, Karen Liu, 23:58

### Q008: Customer Count by Country
**Answer:** 53 total — 44 US, 9 Canada
**Category:** aggregation | **Entities:** [Customer](/entities/customer.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Karen Liu, 31:15

### Q009: Profit Center Count
**Answer:** 37 — US Division (28), Global (3), Logistics (4), Year-end (1), Other (1)
**Category:** entity_lookup | **Entities:** [ProfitCenter](/entities/profit-center.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Karen Liu, 25:10

### Q010: COGS Ratio
**Answer:** Requires calculation — `COGS / Net Revenue × 100`
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Karen Liu, 39:40

### Q011: Total Gross Revenue
**Answer:** Requires aggregation — `SUM(FPA1/022)` (~30,724 transactions)
**Category:** aggregation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Karen Liu, 09:26

### Q012: Net Revenue
**Answer:** Requires calculation — `SUM(FPA1/022) - SUM(FPA1/023)`
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Karen Liu, 39:40

### Q013: Total COGS
**Answer:** Requires aggregation — `SUM(FPA1/020)` (~126,390 transactions, ~75% of total)
**Category:** aggregation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Karen Liu, 09:57

### Q014: Contribution Margin by Product Line
**Answer:** Requires relationship traversal — `(Revenue - COGS)` per product line via [ProfitCenter](/entities/profit-center.md) hierarchy
**Category:** relationship_traversal | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [ProfitCenter](/entities/profit-center.md) | **Difficulty:** moderate
**Source type:** kickoff_transcript — Kick-Off, Karen Liu, 36:20

### Q015: Profit Center Contribution (% of Total Revenue)
**Answer:** Requires calculation — `SUM(FPA1/022 per PC) / SUM(FPA1/022 total) × 100`
**Category:** calculation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [ProfitCenter](/entities/profit-center.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Karen Liu, 40:10

### Q016: Customer Segment Transaction Distribution
**Answer:** Speciality (Z1) ~66%, Large (Z2) ~31%, Medium (Z3) <1%, Unassigned (#) ~2.5%
**Category:** aggregation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [Customer](/entities/customer.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Priya Sharma, 03:41

### Q017: Product Mix (Transaction Share by Product Line)
**Answer:** Cruise ~30%, Mountain ~30%, Racing ~29%, Youth ~9.5%, Other ~1.5%
**Category:** aggregation | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Karen Liu, 07:01

### Q018: Monthly Transaction Volume Trend (YoY)
**Answer:** 2018: ~39,750 (partial), 2019: ~66,740, 2020: ~57,130 (COVID), 2021: ~3,513 (Jan only)
**Category:** time_series | **Entities:** [FinancialTransaction](/entities/financial-transaction.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Priya Sharma, 14:31

### Q019: COVID Impact on Monthly Revenue (2020)
**Answer:** Q2 dip, then huge Q3-Q4 surge — annual total doesn't tell the full story
**Category:** time_series | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md) | **Difficulty:** moderate
**Source type:** workshop_transcript — Workshop, Stefan Richter, 14:45

### Q020: E-Bike Revenue Growth Rate
**Answer:** ~40% (approximate — medium confidence)
**Category:** time_series | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md) | **Difficulty:** complex
**Source type:** kickoff_transcript — Kick-Off, Stefan Richter, 25:05

### Q021: Product Catalog Count
**Answer:** 35
**Category:** entity_lookup | **Entities:** [Product](/entities/product.md) | **Difficulty:** simple
**Source type:** workshop_transcript — Workshop, Karen Liu, 31:47

### Q022: Customer Profitability Ranking
**Answer:** Requires ranking — `Revenue - COGS per customer`; full profitability with cost allocation is Phase 2
**Category:** ranking | **Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Customer](/entities/customer.md) | **Difficulty:** complex
**Source type:** workshop_transcript — Workshop, Karen Liu, 44:52
