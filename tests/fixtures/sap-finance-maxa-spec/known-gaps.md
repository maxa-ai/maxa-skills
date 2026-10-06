---
type: known_gaps
title: Known Gaps
description: Documented gaps in the VeloGroup business knowledge base — areas where extraction is incomplete, data sync gaps exist, or business information was not provided by stakeholders.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [ai_specification, known-gaps, completeness]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Known Gaps

## Data Completeness Gaps

### 1. 37th Profit Center Unaccounted

**Impact:** Low
**Description:** Marcus Weber states 37 profit centers in the master data, but the documented structure accounts for only 36: US Division (28) + Global (3) + Logistics (4) + Year-end (1) = 36. The 37th profit center is unidentified.
**Mitigation:** Will be resolved during data profiling when the actual [ProfitCenter](/entities/profit-center.md) master data is loaded.

### 2. Cash Flow Accounts Limited to Three

**Impact:** Low
**Description:** Only three CF accounts exist: CF_I (Cash Flow Statement), CF_CFO (Cash Flow from Operating Activities), CF_D (Depreciation). A complete indirect method cash flow statement would typically include Cash Flow from Investing Activities and Cash Flow from Financing Activities.
**Mitigation:** UC-05 (Cash Flow Trending) is medium priority. The partial view is sufficient for Phase 1.

## Undocumented Business Information

### 3. Intercompany Transaction Handling

**Impact:** Medium
**Description:** No discussion of intercompany transactions, eliminations, or transfer pricing in either transcript. VeloGroup has multi-entity structure (US Division, Global, Logistics) that could involve intercompany flows.
**Mitigation:** VeloGroup appears to operate as a single entity for Phase 1 scope. Flagged as [follow-up question](/follow-up-questions.md).

### 4. Revenue Recognition Policy

**Impact:** Medium
**Description:** Timing of revenue recognition (shipment, delivery, or invoice) was not discussed. Karen Liu mentions "sale fulfilled" as the trigger for posting but this is imprecise.
**Mitigation:** Standard SAP FI revenue recognition applies. Flagged as [follow-up question](/follow-up-questions.md).

### 5. Cost Allocation Methodology

**Impact:** Medium
**Description:** Cost allocations are mentioned as part of the month-end close process (Day 1-3 activities), but the specific methodology for allocating shared costs across profit centers was not described.
**Mitigation:** Affects profit center-level P&L precision. Flagged as [follow-up question](/follow-up-questions.md).

### 6. Depreciation Methodology

**Impact:** Low
**Description:** Depreciation is mentioned as an adjusting entry during month-end close and CF_D account exists, but the specific method (straight-line, declining balance, etc.) was not discussed.
**Mitigation:** Will be evident from the GL posting patterns during data profiling.

### 7. FX Rate Type Ambiguity

**Impact:** Low
**Description:** Karen says "posting rate" for CAD→USD conversion, but the specific rate type (spot rate at transaction date, monthly average, or month-end rate) is ambiguous.
**Mitigation:** Single-currency USD output eliminates multi-currency complexity for Phase 1 analytics. The distinction only matters if FX gain/loss analysis is needed.

## Controls and Audit Gaps

### 8. No Controls Framework Beyond Budget Validation

**Impact:** Low (for Phase 1 FP&A analytics)
**Description:** The only explicit control gate documented is budget validation ("to the penny" reconciliation). No discussion of segregation of duties, approval workflows for journal entries, or audit trail requirements beyond what SAP enforces.
**Mitigation:** Appropriate for Phase 1 FP&A analytics engagement. Should be noted for compliance-sensitive downstream use.

## Net Income vs EBIT Hierarchy Question

### 9. P&L Hierarchy Completeness

**Impact:** Medium
**Description:** The P&L hierarchy shows Net Income (FPA1/08) as the direct parent of EBIT (FPA1/09) with no intermediate nodes. If there are truly no items between them (interest expense, income tax), then Net Income = EBIT, which would be unusual for a company with debt or tax obligations. If intermediate nodes exist but were not discussed, the hierarchy is incomplete.
**Mitigation:** Flagged as [follow-up question](/follow-up-questions.md). Will be resolved during data profiling when the complete [GLAccount](/entities/gl-account.md) hierarchy is loaded.
