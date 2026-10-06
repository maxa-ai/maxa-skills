---
okf_version: "0.1"
---

# VeloGroup Business Discovery — AI Specification

## Entities

* [Customer](/entities/customer.md) — B2B retail customer that VeloGroup sells to, including independent bike shops, big box retailers, and regional chains across the US and Canada.
* [Financial Transaction](/entities/financial-transaction.md) — Central fact record representing a financial posting at the dimensional grain of account, customer, product, profit center, version, and date.
* [Fiscal Calendar](/entities/fiscal-calendar.md) — Fiscal calendar defining the reporting year structure, period boundaries, and reporting currency for financial analytics.
* [GL Account](/entities/gl-account.md) — General Ledger account used to classify financial transactions by type, organized in a parent-child P&L hierarchy.
* [Product](/entities/product.md) — Physical good manufactured and sold by VeloGroup, including bicycles and e-bikes across four main product lines.
* [Profit Center](/entities/profit-center.md) — Organizational unit responsible for its own P&L — the primary management reporting dimension used by the CFO.

## KPIs

* [Financial KPIs](/kpis/financial-kpis.md) — 15 metrics covering the P&L from Gross Revenue through Net Income, budget variance, revenue segmentation, and profitability analysis.
* [Operational KPIs](/kpis/operational-kpis.md) — 6 metrics covering transaction volumes, product mix, customer concentration, monthly trends, and close efficiency.

## Business Context

* [Project Scope](/themes/project-scope.md) — Project objectives, deliverables, success criteria, stakeholders, scope boundaries, and timeline.
* [Business Domain](/themes/business-domain.md) — Industry context, business model, geographic scope, customer segments, product lines, and competitive landscape.
* [Use Cases](/themes/use-cases.md) — Seven prioritized use cases from monthly P&L reporting through customer profitability ranking.
* [Operational Processes](/themes/operational-processes.md) — Six operational processes covering transaction flows, month-end close, budget, and master data governance.
* [Financial Processes](/themes/financial-processes.md) — Chart of accounts, P&L hierarchy, month-end close, budget vs actual, fiscal calendar, and currency handling.
* [Source Systems](/themes/source-systems.md) — SAP FI/BPC star schema architecture, 10 data conventions, and data quality characteristics.

## Reference

* [Business Questions](/reference/business-questions.md) — 22 validated business questions with known answers for model alignment.
* [Numerical Examples](/reference/numerical-examples.md) — 43 concrete numerical values for validation and testing.
* [Entity Examples](/reference/entity-examples.md) — Sample data for all 6 ERE-confirmed entities with IDs and values.
* [Fiscal Calendar Reference](/reference/fiscal-calendar.md) — Fiscal year structure, currency context, data scope, and close/budget calendars.

## Supplementary

* [Scope Map](/scope-map.md) — Maps 13 business processes to 25 business questions with coverage analysis.
* [Modeling Decisions](/modeling-decisions.md) — 6 entities modeled, 6 entities discarded, 7 attribute classifications.
* [Known Gaps](/known-gaps.md) — 9 documented gaps in the knowledge base.
* [Follow-Up Questions](/follow-up-questions.md) — 12 critical missing information items aggregated from all themes.
* [Conflicts](/conflicts.md) — No conflicts identified between source transcripts.
* [Expert Observations](/expert-observations.md) — 10 domain expert interpretive observations about non-obvious aspects of the data.
* [Raw Source Assets](/raw/) — Original workshop and kick-off transcripts.
