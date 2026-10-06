---
type: business_domain
title: Use Cases
description: Seven formalized use cases for VeloGroup's FP&A analytics platform, prioritized High (UC1-UC3), Medium (UC4-UC6), or Low/Phase 2 (UC7), covering P&L reporting, variance analysis, revenue breakdown, gross margin analysis, cash flow, OpEx analysis, and customer profitability.
confidence: high
timestamp: "2026-10-05T20:11:39Z"
tags: [use-cases, phase-1, priorities]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Use Cases

## UC-01: Monthly P&L by Profit Center

| Field | Value |
|---|---|
| **Priority** | High |
| **Status** | Active |
| **Description** | Generate a standard income statement for any profit center or group of profit centers, for any month or date range |
| **Stakeholders** | Stefan Richter (CFO), Karen Liu (VP FP&A), Priya Sharma (Sr. Analyst) |
| **Current Pain Points** | Takes Priya at least 6 hours/month; pivot tables rebuilt from scratch each month; Excel crashes on the 167K-row CSV |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[238]
> {"speaker": "Amélie Théorêt", "timestamp": "42:07", "quote": "Use Case 1 — Monthly P&L by profit center. Generate a standard income statement for any profit center or group of profit centers, for any month or date range."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[241]
> {"speaker": "Priya Sharma", "timestamp": "42:28", "quote": "At least six hours per month for the full set. I build one P&L per product line group — Cruise, Mountain, Racing, Youth — plus the consolidated company-wide P&L. It's all manual. Copy the data, filter, pivot, format, repeat."}

---

## UC-02: Budget vs Actual Variance Analysis with Drill-Down

| Field | Value |
|---|---|
| **Priority** | High |
| **Status** | Active |
| **Description** | Compare actual results to budget at every level of the P&L and across all dimensions, with both dollar variance and percentage variance side by side |
| **Stakeholders** | Stefan Richter (CFO), Karen Liu (VP FP&A) |
| **Current Pain Points** | Entirely manual Excel rebuild each month; cross-dimensional drill-down is one dimension at a time; each ad hoc variance question takes ~1 hour |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[244]
> {"speaker": "Karen Liu", "timestamp": "43:03", "quote": "High. And I want both dollar variance and percentage variance side by side. A $50,000 variance in Gross Revenue means something different than a $50,000 variance in Travel expense."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[263]
> {"speaker": "Karen Liu", "timestamp": "45:50", "quote": "All dimensions. I want to start at Net Income, see the budget vs actual variance. Then drill into Gross Margin, see the variance there. Then slice by product line — is the variance coming from Cruise or Mountain? Then by customer type — is it a Speciality problem or a Large problem? Then by individual profit center. Full cross-dimensional navigation."}

### ROI Impact

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[258]
> {"speaker": "Karen Liu", "timestamp": "45:10", "quote": "Honestly, if I could get UC1 and UC2 working first, that alone would save me two days a month. That's the ROI case right there — twenty-four analyst days per year returned to higher-value work."}

---

## UC-03: Revenue Breakdown by Product Line and Customer Segment

| Field | Value |
|---|---|
| **Priority** | High |
| **Status** | Active |
| **Description** | Visualize how revenue distributes across Cruise, Mountain, Racing, Youth and across Large, Speciality, Medium |
| **Stakeholders** | Karen Liu, Stefan Richter |
| **Current Pain Points** | Manual cross-tabulation takes ~1 hour |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[259]
> {"speaker": "Danny Le", "timestamp": "45:24", "quote": "That's compelling. And the data model we build for UC1 and UC2 naturally supports UC3 as well — it's the same dimensional structure, just different slicing."}

---

## UC-04: Gross Margin Analysis by Product

| Field | Value |
|---|---|
| **Priority** | Medium |
| **Status** | Active |
| **Description** | Product-level profitability — which products have the highest and lowest margins, matching revenue and COGS at the individual product level |
| **Stakeholders** | Karen Liu, Stefan Richter |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[249]
> {"speaker": "Karen Liu", "timestamp": "44:02", "quote": "Medium priority. Important for strategic product decisions, but I can live without it in Phase 1 if we get the top three working."}

---

## UC-05: Cash Flow Trending (Indirect Method)

| Field | Value |
|---|---|
| **Priority** | Medium |
| **Status** | Active |
| **Description** | Cash flow analysis using the indirect method, leveraging CF_I, CF_CFO, and CF_D accounts |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[251]
> {"speaker": "Karen Liu", "timestamp": "44:16", "quote": "Medium priority. We have the CF accounts — CF_I, CF_CFO, CF_D — so the data supports it. But it's not the most frequently requested analysis."}

---

## UC-06: Operating Expense Analysis by Category

| Field | Value |
|---|---|
| **Priority** | Medium |
| **Status** | Active |
| **Description** | Building vs Employee expense breakdown, trends in Payroll, Travel, Utilities |
| **Stakeholders** | Stefan Richter |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[253]
> {"speaker": "Stefan Richter", "timestamp": "44:37", "quote": "Medium. I look at this quarterly, not monthly. Important but not urgent."}

---

## UC-07: Customer Profitability Ranking

| Field | Value |
|---|---|
| **Priority** | Low |
| **Status** | Deferred (Phase 2) |
| **Description** | Rank customers by their contribution to gross margin; requires allocation of shared costs |
| **Stakeholders** | Karen Liu, Stefan Richter |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[256]
> {"speaker": "Karen Liu", "timestamp": "44:52", "quote": "Low priority. Phase 2 candidate. The data supports it — we track revenue and COGS at the customer level — but computing true customer profitability requires some allocation of shared costs, which is a whole separate exercise."}

---

## Use Case Priority Summary

| Priority | Use Cases | Phase |
|---|---|---|
| High | UC-01, UC-02, UC-03 | Phase 1 |
| Medium | UC-04, UC-05, UC-06 | Phase 1 (if time) |
| Low | UC-07 | Phase 2 |

**Key Insight:** UC1 and UC2 together save ~24 analyst-days/year and enable a 3-day close (from 5-day). UC3 is naturally supported by the same dimensional model used for UC1/UC2.
