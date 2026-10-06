---
type: business_domain
title: Project Scope
description: Unified FP&A analytics platform replacing Excel-based reporting, sourced from SAP FI data covering actual and budget data for fiscal 2018-2021 across all VeloGroup profit centers, product lines, and customer segments.
confidence: high
timestamp: "2026-10-05T20:02:35Z"
tags: [project-scope, phase-1, deliverables]
sources:
  - VeloGroup-Maxa-Project-Kick-Off.md
  - VeloGroup-Maxa-FPA-Workshop.md
---

# Project Scope

**Project:** VeloGroup International FP&A Analytics Platform
**Project Type:** Analytics modernization

## Key Stakeholders

| Name | Role | Involvement |
|---|---|---|
| Stefan Richter | CFO | Executive sponsor |
| Karen Liu | VP of Financial Planning & Analysis | Subject matter expert |
| Marcus Weber | SAP and IT Director | Subject matter expert |
| Priya Sharma | Senior Financial Analyst | End user |

## Project Objectives

| ID | Objective | Priority | Notes |
|---|---|---|---|
| OBJ-01 | Unified FP&A analytics platform replacing Excel-based consolidation and reporting | High | Three-year wish list item for the CFO; eliminates a 3-day manual consolidation |
| OBJ-02 | Self-service financial reporting for business unit leaders | High | Currently all requests funnel through the FP&A team |
| OBJ-03 | Automated month-end close reporting to achieve a 3-day close | High | Current process: 5 business days; target: eliminate days 4-5 (extraction + report building) |
| OBJ-04 | Reduce key-person risk by codifying reporting logic in a platform | High | Roll-up logic currently lives in people's heads and Excel formulas |
| OBJ-05 | Enable cross-dimensional profitability analysis (product line x customer segment x profit center) | High | Cannot currently answer whether the Youth bike line is profitable with confidence |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[29]
> {"speaker": "Stefan Richter", "timestamp": "06:35", "quote": "The primary objective is straightforward. I want a unified FP&A analytics platform that connects to our SAP financial data and gives us a single source of truth. No more Excel consolidation. No more three-day turnaround on basic questions. I want the finance team to be able to self-serve. When a product line manager wants to see their numbers, they should be able to go look, without filing a request with Karen's team."}

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[25]
> {"speaker": "Stefan Richter", "timestamp": "05:52", "quote": "Which is exactly why we're here. One of the things that keeps me up at night, frankly, is key-person risk. If Karen or one of her senior analysts left tomorrow, so much of the institutional knowledge about how we report and consolidate would walk out the door with them."}

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[36]
> {"speaker": "Stefan Richter", "timestamp": "08:28", "quote": "The profitability by product line is critical. I want to stress that. We've been having an internal debate for, I don't know, two years now about whether the Youth bike line is actually profitable on its own or if it's essentially a loss leader that drives foot traffic and brand loyalty for our other lines. And the honest answer is, right now, we genuinely cannot answer that question with confidence. We can't isolate the costs properly."}

## Deliverables

| ID | Deliverable | Type |
|---|---|---|
| DEL-01 | Consolidated P&L dashboard with drill-down (company -> division -> product line -> profit center -> customer segment) | Dashboard/Report |
| DEL-02 | Balance sheet summary view | Dashboard/Report |
| DEL-03 | Cash flow analysis (indirect method) | Dashboard/Report |
| DEL-04 | Budget vs Actual comparison reports with variance drill-down (dollar + percentage) | Dashboard/Report |
| DEL-05 | Profitability analysis sliceable by product line, profit center, and customer segment | Dashboard/Report |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[37]
> {"speaker": "Danny Le", "timestamp": "08:55", "quote": "That's a perfect use case for what we're building. So beyond the P&L dashboard, the other deliverables we're targeting: a balance sheet summary view, cash flow analysis using the indirect method, budget versus actual comparison reports with variance drill-down, and then the profitability analysis sliceable by product line, profit center, and customer segment."}

## Success Criteria

| ID | Criterion | Metric | Target |
|---|---|---|---|
| SC-01 | Reporting speed | Month-end close cycle time | <= 3 business days (from current 5) |
| SC-02 | Analyst time savings | Person-days saved per month | 2 days/month (~24 analyst-days/year) |
| SC-03 | Ad hoc query turnaround | Time to answer profitability questions | Same-day (from current 2-3 days) |
| SC-04 | Self-service adoption | Business unit leaders using dashboards directly | Self-serve without filing requests to FP&A team |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[95]
> {"speaker": "Karen Liu", "timestamp": "16:00", "quote": "If we can automate the reporting layer, the extraction and report-building step — days four and five — could be same-day. The close itself takes three days of accounting work regardless. So three-day close is absolutely achievable if we eliminate the manual reporting bottleneck."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[258]
> {"speaker": "Karen Liu", "timestamp": "45:10", "quote": "Honestly, if I could get UC1 and UC2 working first, that alone would save me two days a month. That's the ROI case right there — twenty-four analyst days per year returned to higher-value work."}

## Scope Boundaries

### In Scope

| Domain | Entities | Processes |
|---|---|---|
| Finance (SAP FI) | GL Account, Customer, Product, Profit Center, Financial Transaction | P&L consolidation, budget vs actual, month-end close reporting |
| Master Data | Customer Segment (Z1/Z2/Z3), Product Category, Account Type | Hierarchy management, dimension maintenance |

**Data scope:**
- Data source: SAP FI (star schema: 1 fact table + 18 dimension tables)
- Versions: Actual + Budget
- Product lines: Cruise, Mountain, Racing, Youth
- Customer segments: Speciality (Z1), Large (Z2), Medium (Z3)
- Profit centers: All 37 (28 US Division + 3 Global/ZG + 4 Logistics/Z_LOG + 2 other)
- Date range: April 2018 - January 2021
- Currency: USD (CAD converted at posting rate in SAP)
- Granularity: Monthly reporting

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[51]
> {"speaker": "Danny Le", "timestamp": "12:15", "quote": "Right. So for Phase 1, here's what we're proposing as in-scope. Data source: SAP FI financial data. The core data model is a star schema with FinancialTransactions as the central fact table surrounded by dimension tables. We'll cover both Actual and Budget data, so two versions. All four product lines: Cruise, Mountain, Racing, Youth. All three customer segments: Speciality, Large, Medium. All profit centers, US Division, Global, and Logistics. Date range: fiscal 2018 through 2021 data. Monthly reporting granularity."}

### Out of Scope

| Domain | Reason |
|---|---|
| Forecast / Rolling Forecast | Phase 2 priority — methodology still being designed internally |
| Operational data (supply chain, inventory, manufacturing) | Phase 2 — requires SAP CO/MM modules |
| HR / Workforce analytics | Not part of current engagement |
| Detailed tax reporting | Not part of current engagement |
| Real-time data feeds | Phase 1 uses batch processing with scheduled refreshes |
| Predictive analytics | Phase 3 candidate |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[60]
> {"speaker": "Danny Le", "timestamp": "14:12", "quote": "So the following are deferred to Phase 2 or beyond. First, forecast and rolling forecast versions. If you have forward-looking data beyond the annual budget, that's not Phase 1. Second, operational data, so supply chain, inventory, manufacturing data. Third, HR and workforce analytics. Fourth, detailed tax reporting. And fifth, real-time data feeds. For Phase 1, batch processing with scheduled refreshes is the approach. We're not doing live streaming from SAP."}

## Timeline and Phases

| Phase | Description | Target Date |
|---|---|---|
| Phase 1 | Actual + Budget analytics platform (P&L, BS, Cash Flow, BvA, Profitability) | ~10-12 weeks from kick-off |
| Phase 2 | Rolling forecast integration + operational data (SAP CO/MM) | TBD |
| Phase 3 | Predictive analytics | TBD |

## Constraints

| Constraint | Impact |
|---|---|
| Data starts April 2018 (SAP migration date) | No pre-migration legacy data available |
| Monthly batch extract (not real-time) | Operational metrics limited to monthly granularity |
| Calendar year fiscal year (Dec 31 year-end) | Standard periods, no offset |
| 167,136 total transactions | Manageable volume; no performance concerns |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[55]
> {"speaker": "Marcus Weber", "timestamp": "13:30", "quote": "That's correct. Fiscal year runs on a calendar year basis, so December 31 year-end. The data starts in April 2018 because that's when we completed the SAP migration from the legacy system. Prior to that... the data is in the old system and it's, um..."}

See [Scope Map](/scope-map.md) for the mapping of these processes to business questions, and [Known Gaps](/known-gaps.md) for unresolved scope-adjacent questions.
