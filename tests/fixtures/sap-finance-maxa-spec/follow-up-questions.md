---
type: follow_up_questions
title: Follow-Up Questions
description: Aggregated follow-up questions from all source themes representing critical missing information that could affect data model accuracy or analytics capability.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [ai_specification, follow-up-questions, gaps]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Follow-Up Questions

## High Impact

### 1. What is the cost allocation methodology used for shared costs across profit centers?

**Impact:** Affects profit center-level P&L accuracy and product line profitability analysis (UC-04, UC-07).
**Current State:** Cost allocations mentioned as part of the month-end close process but methodology is undocumented.
**Related:** [ProfitCenter](/entities/profit-center.md), [FinancialTransaction](/entities/financial-transaction.md)

### 2. Are there intercompany transactions between VeloGroup entities requiring elimination in consolidation?

**Impact:** Required for accurate consolidated P&L — intercompany eliminations affect Gross Margin and Net Income.
**Current State:** Not mentioned in either transcript. VeloGroup appears to be single-entity for Phase 1 scope.
**Related:** [Financial Processes](/themes/financial-processes.md)

### 3. What is the revenue recognition policy — is revenue recognized at shipment, delivery, or invoice?

**Impact:** Determines when revenue appears in the P&L and affects period-end accruals.
**Current State:** Not mentioned. Karen Liu says "sale fulfilled" triggers posting, suggesting shipment-based recognition.
**Related:** [FinancialTransaction](/entities/financial-transaction.md)

## Medium Impact

### 4. What is the exact US/Canada revenue split?

**Impact:** Geographic revenue modeling precision.
**Current State:** Karen states "roughly 85-15, but I'd need to pull the exact number" — approximate value only.
**Related:** [Customer](/entities/customer.md), [Business Domain](/themes/business-domain.md)

### 5. What is the exact e-bike revenue growth rate?

**Impact:** Product line trend analysis and strategic investment decisions.
**Current State:** Stefan says "around 40%", Karen hedges. Medium confidence.
**Related:** [Product](/entities/product.md)

### 6. What FX rate type is used for CAD→USD conversion?

**Impact:** Affects accuracy of converted amounts and period-end FX gain/loss calculations.
**Current State:** Karen says "posting rate" but the specific type (spot, monthly average, month-end) is ambiguous.
**Related:** [FiscalCalendar](/entities/fiscal-calendar.md), [Fiscal Calendar Reference](/reference/fiscal-calendar.md)

### 7. Is the Net Income → EBIT relationship direct, or are there intermediate items?

**Impact:** P&L hierarchy completeness. If Net Income = EBIT, unusual for a company with debt or taxes.
**Current State:** Hierarchy shows direct parent-child with no intermediate nodes documented.
**Related:** [GLAccount](/entities/gl-account.md), [Financial KPIs](/kpis/financial-kpis.md)

### 8. What depreciation methodology does VeloGroup use?

**Impact:** Significant non-cash expense affecting both P&L and Cash Flow (CF_D).
**Current State:** Only described as "adjusting entries for things like depreciation" — no methodology specified.
**Related:** [Financial Processes](/themes/financial-processes.md)

## Low Impact

### 9. What specific cash flow metrics does Karen track using the indirect method?

**Impact:** Data model requirements for UC-05 (Cash Flow Trending).
**Current State:** Three CF accounts exist (CF_I, CF_CFO, CF_D) but no specific KPIs defined.
**Related:** [GLAccount](/entities/gl-account.md)

### 10. What cost allocation methodology would be used for customer profitability (UC-07)?

**Impact:** Phase 2 customer profitability ranking.
**Current State:** Karen describes it as "a whole separate exercise" — no methodology specified.
**Related:** [Customer](/entities/customer.md), [Use Cases](/themes/use-cases.md)

### 11. Which year had the highest transaction volume?

**Impact:** Data scope understanding — 2019 appears to be the baseline year (~66,740 transactions).
**Current State:** Known from data (2019) but not explicitly confirmed as baseline.
**Related:** [FiscalCalendar](/entities/fiscal-calendar.md)

### 12. If European operations expand, will EUR-denominated transactions require additional FX handling?

**Impact:** Phase 2+ may require EUR functional currency support.
**Current State:** Stefan mentions "European presence starting to form" but scope is USD/CAD only.
**Related:** [Fiscal Calendar Reference](/reference/fiscal-calendar.md)
