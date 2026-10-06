---
okf_version: "0.1"
---

# VeloGroup International FP&A — AI Specification

This AI specification covers VeloGroup International's FP&A analytics platform: a B2B cycling manufacturer/distributor replacing Excel-based reporting with a unified analytics platform built on SAP FI financial data. It spans 13 entities, 16 KPIs, 6 business-context themes, and 27 validated business questions, grounded in two stakeholder discovery transcripts (a project kick-off and an FP&A workshop).

**Scope:** Actual and Budget financial data for fiscal 2018–2021, across all 37 profit centers, 4 product lines (Cruise, Mountain, Racing, Youth), and 3 customer segments (Speciality, Large, Medium). See [Project Scope](/themes/project-scope.md) for full scope boundaries.

## Entities

* [FinancialTransaction](/entities/financial-transaction.md) — An aggregated financial posting recorded in the general ledger at the dimensional grain of GL account, customer, product, profit center, version, and date.
* [Customer](/entities/customer.md) — A B2B retailer that VeloGroup sells to, classified by customer segment and geography.
* [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) — A node in the customer hierarchy that groups customers by type and geography.
* [CustomerSegment](/entities/customer-segment.md) — A reference classification dimension grouping customers into business-size tiers (Speciality, Large, Medium, Unassigned).
* [Division](/entities/division.md) — A top-level organizational unit that groups profit centers by geographic and functional boundary.
* [GLAccount](/entities/gl-account.md) — A General Ledger account in VeloGroup's chart of accounts; leaf accounts receive postings, rollup nodes are calculated.
* [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) — A node in the P&L hierarchy tree defining the parent-child rollup structure for financial reporting.
* [Product](/entities/product.md) — A physical cycling product manufactured and sold by VeloGroup, carrying SKU, list price, and category classification.
* [ProductCategory](/entities/product-category.md) — Static reference data classifying products into product lines (Cruise, Mountain, Racing, Youth) and minor tracking categories.
* [ProductHierarchyNode](/entities/product-hierarchy-node.md) — A node in the product hierarchy grouping products under product line groupings.
* [ProfitCenter](/entities/profit-center.md) — An organizational unit encoding a product line × channel combination; the primary dimension management uses to analyze performance.
* [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) — A node organizing profit centers under the US Division → Product Line → Channel structure.
* [AccountType](/entities/account-type.md) — A classification of GL accounts into one of five accounting categories (Income, Expense, Assets, Liabilities & Equity, Non-financial).

## KPIs

* [Financial KPIs](/kpis/financial-kpis.md) — 11 financial P&L metrics: Gross Revenue, Net Revenue, COGS, Gross Margin, Gross Margin %, Budget vs Actual Variance, Operating Expense Total, EBIT, Net Income, COGS Ratio, Revenue by Product Line.
* [Operational KPIs](/kpis/operational-kpis.md) — 5 operational/analytical metrics: transaction volume by account type, product mix, customer concentration, profit center contribution, monthly revenue trend with YoY comparison.

## Business Context

* [Project Scope](/themes/project-scope.md) — Project objectives, deliverables, success criteria, stakeholders, and scope boundaries.
* [Business Domain](/themes/business-domain.md) — Industry context, geographic scope, customer segments, product lines, and organizational structure.
* [Use Cases](/themes/use-cases.md) — Seven formalized use cases prioritized High/Medium/Low for the FP&A analytics platform.
* [Operational Processes](/themes/operational-processes.md) — Month-end close, financial transaction flow, annual budget process, master data governance, data extraction, and variance analysis workflow.
* [Financial Processes](/themes/financial-processes.md) — P&L consolidation structure, budget vs actual variance, annual budget cycle, FX handling, fiscal calendar, and cost allocation.
* [Source Systems](/themes/source-systems.md) — SAP FI (BPC) star schema and Excel reporting landscape, including all data conventions.

## Reference

* [Business Questions](/reference/business-questions.md) — 27 validated business questions with known answers, source-type tagged.
* [Numerical Examples](/reference/numerical-examples.md) — 36 concrete numerical values from discovery evidence, source-type tagged.
* [Entity Examples](/reference/entity-examples.md) — Concrete ID patterns and example records for all 13 entities.
* [Fiscal Calendar](/reference/fiscal-calendar.md) — Fiscal year, period mapping, currency context, and data scope.

## Supplementary

* [Scope Map](/scope-map.md) — Process-to-question coverage mapping; explains in-scope vs out-of-scope processes.
* [Modeling Decisions](/modeling-decisions.md) — Entity grain, discarded-entity reasoning, and attribute classifications.
* [Known Gaps](/known-gaps.md) — Two high-priority gaps: cost allocation methodology, balance sheet/cash flow account structures.
* [Follow-Up Questions](/follow-up-questions.md) — Seven critical open questions for follow-up with stakeholders.
* [Conflicts](/conflicts.md) — Consolidated log of unresolved contradictions (none found).
* [Expert Observations](/expert-observations.md) — Cross-cutting domain-expert interpretations of non-obvious, high-priority context.
* [Raw Source Assets](/raw/) — The two source transcripts (Project Kick-Off, FPA Workshop) underlying this AI specification.

## Entity Inventory

| Entity | Type | Domain | Relationships |
|---|---|---|---|
| FinancialTransaction | transactional | finance | GLAccount, Customer, Product, ProfitCenter |
| Customer | master_data | mdm | CustomerSegment, CustomerHierarchyNode, FinancialTransaction |
| CustomerHierarchyNode | domain_dimension | sales | CustomerHierarchyNode (self), Customer |
| CustomerSegment | domain_dimension | sales | Customer |
| Division | master_data | mdm | ProfitCenter |
| GLAccount | domain_dimension | finance | AccountType, GLAccountHierarchyNode |
| GLAccountHierarchyNode | domain_dimension | finance | GLAccount, GLAccountHierarchyNode (self) |
| Product | master_data | mdm | ProductCategory, ProductHierarchyNode, FinancialTransaction |
| ProductCategory | domain_dimension | sales | Product |
| ProductHierarchyNode | domain_dimension | sales | ProductHierarchyNode (self), Product |
| ProfitCenter | domain_dimension | finance | Division, ProfitCenterHierarchyNode |
| ProfitCenterHierarchyNode | domain_dimension | finance | ProfitCenterHierarchyNode (self), ProfitCenter |
| AccountType | domain_dimension | finance | GLAccount |
