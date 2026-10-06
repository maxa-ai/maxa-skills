---
type: follow_up_questions
title: Follow-Up Questions
description: Critical missing information identified across theme extraction, aggregated with impact and current-state context for follow-up with VeloGroup stakeholders.
confidence: high
tags: [bundle_metadata, follow_up_questions]
timestamp: "2026-10-05T20:33:03Z"
---

# Follow-Up Questions

## FQ-01: European Customer Count

**Question:** How many European customers/entities exist, and are they in scope for analytics?

**Impact:** Determines whether EUR currency and European legal entities need to be modeled in this or a future phase.

**Current State:** NOT_MENTIONED. Stefan Richter referenced "some European presence starting to form" but no customer count, revenue share, or entity list was provided.

**Related:** [Business Domain](/themes/business-domain.md)

---

## FQ-02: Cost Allocation Methodology

**Question:** What is the cost allocation methodology used across profit centers (e.g., headcount-based, revenue-based, square-footage-based)?

**Impact:** Determines profit center P&L accuracy and contribution margin calculations; blocks cross-dimensional profitability analysis and the Youth-line profitability question. See [Known Gap G001](/known-gaps.md) for full detail.

**Current State:** NOT_MENTIONED. Statistical accounts (headcount, square footage, capacity) exist in SAP for allocation purposes, but their use was not explored.

**Related:** [Financial Processes](/themes/financial-processes.md), [Known Gaps](/known-gaps.md)

---

## FQ-03: Revenue Recognition Point

**Question:** At what point is revenue recognized — at shipment, delivery, or invoice?

**Impact:** Required for period-accurate revenue reporting and ensuring consistency with standard accounting practice.

**Current State:** NOT_MENTIONED in either evidence source.

**Related:** [Financial Processes](/themes/financial-processes.md)

---

## FQ-04: FX Rate Methodology

**Question:** What FX posting rate methodology is used — spot rate, average rate, or month-end rate?

**Impact:** Spot vs. average vs. month-end rate affects FX variance analysis and period accuracy for Canadian-dollar transactions converted to USD.

**Current State:** NOT_MENTIONED. Stakeholders used the term "posting rate" without further clarification, and no separate FX rate table exists in the data export.

**Related:** [Financial Processes](/themes/financial-processes.md), [Fiscal Calendar](/reference/fiscal-calendar.md)

---

## FQ-05: SAP Server Timezone

**Question:** What is the IANA timezone of the SAP server (e.g., America/New_York, UTC)?

**Impact:** Required for correct timestamp handling in staging — SAP stores timestamps in server local time without timezone metadata.

**Current State:** NOT_MENTIONED in either evidence source.

**Related:** [Source Systems](/themes/source-systems.md)

---

## FQ-06: Large-Tier Customer IDs

**Question:** What are the CUSTOMERID values for Large-tier customers (Skymart Corp, Bigmart, CostClub, etc.)?

**Impact:** Only Speciality and Medium customer IDs are known (LACU_S02, 1000153); Large-tier IDs are needed to establish the complete ID pattern space for data discovery.

**Current State:** NOT_MENTIONED — Large-tier customers are named but not keyed.

**Related:** [Entity Examples](/reference/entity-examples.md)

---

## FQ-07: Customer and Profit Center Hierarchy Node IDs

**Question:** What are representative hierarchy node IDs (HIERARCHYID values) for the Customer Hierarchy and Profit Center Hierarchy tables?

**Impact:** Transcripts describe these hierarchies using descriptive names only (e.g., "US Division," "Cruise") rather than actual system node IDs, which are needed for data discovery mapping.

**Current State:** NOT_MENTIONED for specific node IDs; row counts (56 for Customer Hierarchy, 60 for Profit Center Hierarchy) are known.

**Related:** [Entity Examples](/reference/entity-examples.md)
