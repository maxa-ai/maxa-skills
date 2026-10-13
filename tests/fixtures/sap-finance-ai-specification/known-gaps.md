---
type: known_gaps
title: Known Gaps
description: Two chapter-level gaps identified across VeloGroup's FP&A analytics discovery - cost allocation methodology and balance sheet/cash flow account structures.
confidence: high
tags: [maxa_spec_metadata, known_gaps]
timestamp: "2026-10-05T20:33:03Z"
---

# Known Gaps

## G001: Undocumented Cost Allocation Methodology Across Profit Centers

**Area:** Financial, Cost Accounting

The methodology by which shared costs are allocated across VeloGroup's 37 profit centers is entirely absent from the record — no allocation drivers, allocation flows, or rules were discussed. Karen Liu confirmed cost allocations happen during month-end close and that statistical accounts (headcount, square footage, capacity) exist for allocation purposes, but how they are used was never explored.

The [Financial Processes](/themes/financial-processes.md) theme documents cost allocation as a named process with timing (days 1-3 of close), scope (shared costs across profit centers), and owner (Karen Liu), but the method itself is NOT_MENTIONED. [Project Scope](/themes/project-scope.md) establishes cross-dimensional profitability analysis as a high-priority objective (OBJ-05) and a sliceable profitability dashboard as an explicit deliverable (DEL-05). The CFO's two-year-old question — whether the Youth bike line is profitable on its own — is structurally unanswerable without understanding how shared costs from Global (ZG) and Logistics (Z_LOG) profit centers reach product-line profit centers in the US Division.

**Blocks:** OBJ-05, UC-04, DEL-05

**Impact:** Cross-dimensional profitability analysis (OBJ-05) and the profitability dashboard sliceable by product line, profit center, and customer segment (DEL-05) depend on correctly attributed costs. Gross Margin Analysis by Product (UC-04) requires understanding how shared costs reach product-line profit centers. Without the allocation methodology, profit center P&Ls may misstate contribution, and the Youth-line profitability question remains unanswerable.

**Priority:** High

**Suggested Follow-Up:** Clarify with the VP of FP&A, who owns the allocation process and the statistical accounts that feed it: (1) What allocation methodology distributes shared costs across profit centers — headcount-based, revenue-based, square-footage-based, or a combination? (2) Which costs from Global (ZG) and Logistics (Z_LOG) profit centers are allocated to US Division profit centers, and what drivers determine the split? (3) How are the statistical accounts (headcount, square footage, capacity metrics) used as allocation inputs? (4) Does the SAP extract reflect post-allocation balances, or must the analytics platform replicate the allocation logic?

---

## G002: Undocumented Balance Sheet and Cash Flow Account Structures

**Area:** Financial, Reporting Structure

The P&L hierarchy is documented exhaustively (21 accounts, every node named with parent-child relationships), but the balance sheet accounts (asset and liability/equity types) and cash flow accounts (CF_I, CF_CFO, CF_D) have no documented hierarchy, no individual account listing, and no analytical structure. Karen Liu named three cash flow accounts in passing and noted that asset and liability/equity accounts "feed into the balance sheet view," but that is the entirety of the record.

The [Financial Processes](/themes/financial-processes.md) theme covers P&L consolidation in detail but contains zero balance sheet or cash flow account structure. [Financial KPIs](/kpis/financial-kpis.md) defines 11 KPIs — all P&L metrics — with no balance sheet or cash flow KPIs despite DEL-02 (balance sheet summary view) and DEL-03 (cash flow analysis) being explicit Phase 1 deliverables in [Project Scope](/themes/project-scope.md). Cash Flow Trending (UC-05) is an active medium-priority use case whose three named accounts lack hierarchy detail, calculation rules, and relationship to other account structures.

**Blocks:** DEL-02, DEL-03, UC-05

**Impact:** The balance sheet summary view (DEL-02) and cash flow analysis using the indirect method (DEL-03) are explicit Phase 1 deliverables with no documented account structure to build from. Cash Flow Trending (UC-05) is an active use case whose three named accounts (CF_I, CF_CFO, CF_D) lack hierarchy detail, calculation rules, and relationship to P&L and balance sheet nodes.

**Priority:** High

**Suggested Follow-Up:** Clarify with the VP of FP&A and the SAP/IT Director, who respectively understand the reporting requirements and the SAP account structure: (1) What GL accounts exist under the Asset and Liabilities & Equity account types, and what is their parent-child hierarchy? (2) How does the cash flow hierarchy (CF_I, CF_CFO, CF_D) relate to the P&L and balance sheet accounts — what are the calculation rules for the indirect method? (3) What specific metrics and drill-down dimensions should the balance sheet summary view (DEL-02) support?
