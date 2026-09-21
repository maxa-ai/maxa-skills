---
type: use_cases
title: Use Cases
description: Seven prioritized use cases for the VeloGroup FP&A analytics platform, from monthly P&L reporting through customer profitability ranking, with stakeholder attribution and current-state pain points.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [use-cases, p-and-l, variance-analysis, profitability, drill-down, self-service]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Use Cases

## Use Case Summary

| ID | Use Case | Priority | Status | Key Stakeholder | Current Pain |
|----|----------|----------|--------|-----------------|-------------|
| UC-01 | Monthly P&L by Profit Center | High | Active | Stefan, Karen, Priya | 6+ hours/month manual build |
| UC-02 | Budget vs Actual Variance with Drill-Down | High | Active | Stefan, Karen | 10-15 hours/month; 1 hour per ad-hoc question |
| UC-03 | Revenue by Product Line & Customer Segment | High | Active | Stefan, Karen | 1 hour manual cross-tabulation |
| UC-04 | Gross Margin Analysis by Product | Medium | Active | Stefan, Karen | Cannot isolate product profitability |
| UC-05 | Cash Flow Trending (Indirect) | Medium | Active | Karen | — |
| UC-06 | OpEx Analysis by Category | Medium | Active | Stefan, Karen | — |
| UC-07 | Customer Profitability Ranking | Low | Deferred | Stefan, Karen | Requires cost allocation (Phase 2) |

## UC-01: Monthly P&L by Profit Center

**Priority:** High | **Status:** Active (Phase 1)

Generate a standard income statement for any profit center or group of profit centers, for any month or date range. Priya builds one P&L per product line group (Cruise, Mountain, Racing, Youth) plus consolidated company-wide P&L — at least 6 hours per month, all manual.

**Entities Involved:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [ProfitCenter](/entities/profit-center.md)

## UC-02: Budget vs Actual Variance Analysis with Drill-Down

**Priority:** High | **Status:** Active (Phase 1)

Compare actual results to budget at every level of the P&L and across all dimensions. Show both dollar variance and percentage variance. Enable drill-down from Net Income through Gross Margin to individual leaf accounts, and across product line, customer type, and profit center.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Karen Liu, 18:22
> "In theory, yes. In practice, cross-dimensional variance analysis in Excel is painful. I can do it for one dimension at a time. If Stefan asks 'why is Gross Margin off budget in the Cruise line?' I have to go back to the raw data, filter for Cruise profit centers, compare budget to actual for each account, and try to find the story. That takes an hour."

**Entities Involved:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [ProfitCenter](/entities/profit-center.md), [Customer](/entities/customer.md), [Product](/entities/product.md)

## UC-03: Revenue Breakdown by Product Line and Customer Segment

**Priority:** High | **Status:** Active (Phase 1)

Visualize how revenue distributes across Cruise, Mountain, Racing, Youth, and across Large, Speciality, Medium customer segments. Cross-reference product categorization with customer type.

**Entities Involved:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [Customer](/entities/customer.md)

## UC-04: Gross Margin Analysis by Product

**Priority:** Medium | **Status:** Active (Phase 1)

Product-level profitability — which products have the highest and lowest margins. The Youth bike line profitability debate has been unresolved for 2 years.

**Entities Involved:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)

## UC-05: Cash Flow Trending (Indirect Method)

**Priority:** Medium | **Status:** Active (Phase 1)

Trend analysis of cash flow using the indirect method. Leverages CF_I, CF_CFO, CF_D accounts documented in the [GLAccount](/entities/gl-account.md) entity.

## UC-06: Operating Expense Analysis by Category

**Priority:** Medium | **Status:** Active (Phase 1)

Building vs Employee expense breakdown. Trends in Payroll, Travel, Utilities. Stefan reviews this quarterly.

**Entities Involved:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [ProfitCenter](/entities/profit-center.md)

## UC-07: Customer Profitability Ranking

**Priority:** Low | **Status:** Deferred (Phase 2)

Rank customers by contribution to gross margin. Requires cost allocation of shared costs — a "whole separate exercise" per Karen Liu. Partially answerable at gross margin level in Phase 1.

**Entities Involved:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Customer](/entities/customer.md)

## Cross-Cutting Business Questions

| Question | Relates To | Phase 1 Answerable? |
|----------|-----------|---------------------|
| Channel Profitability — Speciality vs Large | UC-07 / UC-04 | Partially (gross margin level) |
| Youth Bike Line Profitability | UC-04 | Yes (gross margin level) |
| Customer Concentration Risk (<15% per customer) | UC-03 | Yes |
| COVID Impact Analysis (2020 monthly trend) | UC-01 | Yes |
| E-Bike Revenue Growth (~40% YoY) | UC-03 | Yes |

See [Business Questions](/reference/business-questions.md) for the full set of 22 validated business questions.

## ROI Case

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Karen Liu, 45:10
> "Honestly, if I could get UC1 and UC2 working first, that alone would save me two days a month. That's the ROI case right there — twenty-four analyst days per year returned to higher-value work."

## Drill-Down Requirements

All use cases require dimensional drill-down capability across P&L hierarchy, product line, customer segment, individual profit center, individual customer, and individual product.
