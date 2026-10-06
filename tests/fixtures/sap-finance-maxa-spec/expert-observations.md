---
type: expert_observations
title: Expert Observations
description: Domain expert interpretive commentary on non-obvious, high-priority, or potentially dangerous aspects of VeloGroup's financial data and business context that structured files alone may not convey.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [ai_specification, expert-observations, interpretive, domain-expertise]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Expert Observations

These observations restore the interpretive "so what" behind facts that the specification already contains in structured form. When a stakeholder explains *why* something matters, that framing signals importance in a way that a structured data table cannot.

## 1. The Sign Convention is a Compound Rule — Get It Wrong and Everything Breaks

The P&L hierarchy is both the display structure and the calculation structure. Revenue values are positive. COGS values are positive. The hierarchy determines the arithmetic: revenue adds, costs subtract. If a downstream consumer applies signs from the data values rather than from the hierarchy position, every subtotal from Gross Margin through Net Income will be wrong.

> "Exactly. The hierarchy is both the display structure and the calculation structure."
> — Karen Liu, Workshop, 50:30

This was correctly identified as a compound rule during extraction — the system-specific encoding (all values positive in VARCHAR) is distinct from the business decision (hierarchy determines arithmetic). Consumers [MUST] apply hierarchy-based arithmetic, not value-based signs.

## 2. Dimensional Grain Varies by Account Type — This Limits What Analysis Is Possible

Revenue and COGS carry full dimensional grain (customer × product × profit center). Operating expenses carry profit center only (customer=# and product=#). This is not a data quality issue — it is a fundamental business decision about how costs are tracked.

The practical consequence: **product-level and customer-level profitability can only be computed at the gross margin level, not at the operating income level.** If someone tries to compute "customer profitability including allocated OpEx," they need a cost allocation methodology — which VeloGroup explicitly describes as "a whole separate exercise" deferred to Phase 2.

## 3. Budget Has More Rows Than Actual — This is Intentional, Not an Error

Budget accounts for 61% of all transactions (102,380) versus 39% actual (64,756). A consumer encountering this distribution might assume a data quality issue or filtering error. It is neither.

> "Budget has more rows because we forecast at a very granular level. My team builds the budget at the individual product-customer-profit center level for every month. That creates a lot of line items."
> — Karen Liu, Workshop, 16:54

The VERSION dimension is not evenly distributed. Queries that don't filter on version will be dominated by budget data. Any "total" aggregation should specify whether it includes both versions or only Actual.

## 4. COGS Dominates Transaction Volume — Expect 75% of Query Load Here

At ~126,390 of 167,136 total transactions, COGS (FPA1/020) represents three-quarters of all financial postings. This is because COGS is tracked at the full product-customer-profit center grain, generating many line items per sale.

Data engineering decisions (partitioning, indexing, materialization) should account for this extreme skew. A query touching "all transactions" is really a query dominated by COGS rows.

## 5. Hash (#) is Meaningful Data — Filtering It Out Destroys the P&L

The # (Unassigned) value is a first-class dimension member with master data entries, text descriptions, and hierarchy positions. Every operating expense transaction has CUSTOMERID=# and PRODUCTID=#.

> "If you remove hash transactions, your entire Operating Expense section disappears. It's meaningful data."
> — Karen Liu, Workshop, 47:19

This is the most dangerous data convention for a new consumer. Standard data cleaning practices (remove nulls, remove placeholders) would eliminate the entire OpEx section from the P&L.

## 6. Customer Concentration is a CFO-Level Strategic Alert, Not Just a Report

Stefan Richter doesn't just want customer concentration as a metric — he uses the 15% threshold as a strategic risk indicator. He specifically monitors Skymart Corp. This should be implemented as a real-time alert or dashboard KPI with threshold highlighting, not buried in a static report.

> "If Skymart Corp represents more than, say, fifteen percent of our revenue, I get nervous."
> — Stefan Richter, Workshop, 40:40

## 7. The Youth Line Profitability Question Has Been Unanswered for Two Years

This isn't a new analytical question — it's a strategic decision that has been blocked by data infrastructure limitations for 24 months. The analytics platform is expected to resolve it. The fact that the CFO has been unable to answer "is this product line profitable?" for two years underscores the urgency and the institutional frustration behind the project.

## 8. Profit Center is THE Management Reporting Dimension

Karen Liu is emphatic: "The profit center is our primary management reporting dimension. I can't stress this enough." Stefan manages the business by profit center group. The P&L is viewed by profit center, not by product category. While product category analysis is useful, the profit center hierarchy is the authoritative lens for management reporting.

## 9. The Excel Pain is Real and Acute

Priya Sharma's description of losing 4 hours of work when Excel crashed is not anecdotal background — it explains why the team is motivated and engaged. The monthly cycle of "delete old pivots, reimport CSV, rebuild from scratch" represents wasted capacity at scale: 6+ hours/month for P&L alone, plus 10-15 hours on variance analysis. The project ROI case (24 analyst-days/year) is built on eliminating this waste.

## 10. Rolling Forecast is Coming — Design for Three Versions, Not Two

The data model currently supports Actual and Budget. Stefan explicitly flagged rolling forecast for Phase 2 integration. When it arrives, the VERSION dimension will need to accommodate additional version types beyond the current binary. Design decisions made now about version handling should anticipate this expansion.
