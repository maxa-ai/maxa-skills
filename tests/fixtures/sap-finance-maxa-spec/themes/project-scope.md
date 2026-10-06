---
type: project_scope
title: Project Scope
description: Project objectives, deliverables, success criteria, stakeholders, scope boundaries, timeline, and governance for the VeloGroup FP&A analytics platform engagement.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [project-scope, deliverables, stakeholders, timeline, governance]
sources:
  - VeloGroup-Maxa-Project-Kick-Off
  - VeloGroup-Maxa-FPA-Workshop
---

# Project Scope

## Speaker Map

| Speaker | Role | Authority Domain | Transcript(s) |
|---------|------|------------------|----------------|
| Stefan Richter | CFO, Executive Sponsor | Strategic direction, business priorities | Kick-Off, Workshop |
| Karen Liu | VP FP&A | Financial reporting, KPIs, P&L structure | Kick-Off, Workshop |
| Marcus Weber | SAP & IT Director | SAP data architecture, system conventions | Kick-Off, Workshop |
| Priya Sharma | Senior Financial Analyst | Day-to-day data operations, reporting pain points | Workshop |
| Sophie Marchand | Delivery Manager (Maxa) | Project methodology, timeline | Kick-Off, Workshop |
| Julien Tremblay | Analytics Lead (Maxa) | Data modeling, analytics design | Kick-Off, Workshop |
| Nadia Khoury | Analytics Engineer (Maxa) | Data profiling, technical modeling | Workshop |

## Project Objectives

### Primary Objective

Build a unified FP&A analytics platform connecting to SAP financial data as a single source of truth — eliminating Excel consolidation and enabling finance team self-service.

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: Kick-Off, Stefan Richter, 06:35
> "I want a unified FP&A analytics platform that connects to our SAP financial data and gives us a single source of truth. No more Excel consolidation. No more three-day turnaround on basic questions. I want the finance team to be able to self-serve."

### Supporting Objectives

1. **Eliminate manual Excel consolidation** — Replace the 3-day monthly P&L consolidation process across 37 profit centers.
2. **Enable self-service analytics** — Allow business unit leaders to access their own data without filing requests.
3. **Reduce key-person risk** — Codify institutional knowledge currently in people's heads and Excel formulas.
4. **Enable ad-hoc profitability analysis** — Answer questions like product line profitability in real time.

## Deliverables

| # | Deliverable | Priority |
|---|-------------|----------|
| 1 | Consolidated P&L dashboard with drill-down (by division, product line, profit center, customer segment) | High |
| 2 | Budget vs Actual variance reports with drill-down | High |
| 3 | Revenue breakdown by product line and customer segment | High |
| 4 | Balance sheet summary view | Medium |
| 5 | Cash flow analysis (indirect method) | Medium |
| 6 | Profitability analysis sliceable by product line, profit center, customer segment | High |

## Success Criteria

| Criterion | Target |
|-----------|--------|
| Monthly P&L consolidation time | Reduce from 3 days to same-day (automated) |
| Ad-hoc question turnaround | Reduce from 2-3 days to real-time |
| Analyst time saved | 10-15 hours/month on variance analysis alone |
| Monthly reporting time saved | ~24 analyst-days/year returned to higher-value work |
| Month-end close target | 3-day close (from 5-day) by eliminating manual reporting bottleneck |
| Self-service capability | Business unit leaders can access their own data without filing requests |

## Scope Boundaries

### In Scope (Phase 1)

| Item | Detail |
|------|--------|
| **Data Source** | SAP FI financial data |
| **Versions** | Actual and Budget |
| **Product Lines** | Cruise, Mountain, Racing, Youth |
| **Customer Segments** | Speciality (Z1), Large (Z2), Medium (Z3) |
| **Profit Centers** | All 37 — US Division (28), Global (3), Logistics (4), Year-end (1), Other (1) |
| **Date Range** | April 2018 through January 2021 |
| **Data Volume** | ~167,136 transactions (64,756 actual + 102,380 budget) |
| **Processing** | Batch with scheduled refreshes |

### Out of Scope (Deferred)

| Item | Phase |
|------|-------|
| Forecast / rolling forecast versions | Phase 2 |
| Operational data (supply chain, inventory, manufacturing) | Phase 2 |
| HR / workforce analytics | Phase 2+ |
| Predictive analytics | Phase 3 |
| Customer profitability ranking (with cost allocation) | Phase 2 |

## Timeline

| Phase | Duration |
|-------|----------|
| Discover + Design | 3-4 weeks |
| Build | 4-6 weeks |
| Test + Deploy | 2-3 weeks |
| **Total** | **~10-12 weeks** |
| First prototype (P&L dashboard) | 5-6 weeks from kick-off |

## Governance

| Mechanism | Frequency | Participants |
|-----------|-----------|--------------|
| Weekly touchpoint | Wednesdays 10 AM | Karen Liu, Marcus Weber, Julien Tremblay, Sophie Marchand |
| Monthly steering | Monthly | Stefan Richter + Maxa leads |
| Day-to-day communication | As needed | All — Microsoft Teams dedicated channel |

## Key Pain Points

| Pain Point | Impact |
|------------|--------|
| 3-day P&L consolidation across 37 profit centers | Delays month-end reporting |
| 2-3 day turnaround on ad-hoc profitability questions | Cannot answer board questions in real time |
| Key-person risk — institutional knowledge in heads/Excel | Business continuity risk |
| Excel crashes losing hours of work | Analyst productivity loss |
| Manual pivot table rebuilding every month | Repetitive non-value-add work |
| Cannot isolate Youth bike line profitability | Strategic decision blocked |
| Report factory — all requests funnel through FP&A team | Team capacity consumed by report generation |
