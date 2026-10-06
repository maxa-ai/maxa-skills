---
type: entity
title: ProfitCenter
entity_name: ProfitCenter
entity_slug: profit-center
description: An organizational unit responsible for P&L in VeloGroup's management reporting, encoding a product line × channel combination (e.g., Cruise-Large, Mountain-Speciality). The primary dimension management uses to analyze business performance.
confidence: high
entity_type: domain_dimension
domain: finance
version: "1.0.0"
last_updated: "2026-10-06T00:30:00Z"
relationships:
  - Division
  - ProfitCenterHierarchyNode
tags: [finance, domain_dimension, management_reporting, profit_center]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| many_to_one | [Division](/entities/division.md) | Each profit center belongs to one division — US Division, Global, or Logistics. |
| many_to_one | [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) | Each profit center is placed in the profit center hierarchy, which defines its organizational rollup path (US Division → Product Line → Channel). |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `status` | STRING | Yes | Lifecycle status of the profit center (e.g., active, inactive). Used to identify the 37 active profit centers for management reporting and cost allocation. | Q005 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `profit_center_name` | STRING | Yes | Descriptive display name of the profit center encoding its product line × channel combination (e.g., "Cruise Cycles - Large", "Mountain Bikes - Speciality"). |
| `division_id` | STRING | Yes | Reference to the parent Division — the top-level organizational unit this profit center belongs to (US Division, Global, Logistics). |
| `division_name` | STRING | Yes | Denormalized display name of the parent division, carried directly on the profit center record so reports do not require a separate lookup against Division (e.g., "US Division", "Global", "Logistics"). |
| `profit_center_hierarchy_node_id` | STRING | Yes | Reference to the corresponding ProfitCenterHierarchyNode — the position of this profit center in the organizational rollup hierarchy (US Division → Product Line → Channel). |
| `language` | STRING | Yes | Display language code for the profit center's descriptive text record. Operational attribute inherited from the source system. |
| `effective_date` | DATE | Yes | Business date when the profit center was established or became effective (YYYY-MM-DD). Used to track when organizational or hierarchy changes took effect. |
| `effective_date_timezone` | STRING | Yes | Timezone offset for `effective_date` in +/-HH:MM format, so the effective date can be interpreted unambiguously regardless of reporting timezone. |

## Supported Processes

- Master Data Governance
- Financial Transaction Flow
- P&L Consolidation Reporting
- Cost Allocation

## Supported Questions

- [Q005: How many active profit centers does VeloGroup have?](/reference/business-questions.md)
- [Q007: Is the Youth bike line profitable on its own, or is it a loss leader?](/reference/business-questions.md)
- [Q020: What is each profit center's share of total revenue (profit center contribution)?](/reference/business-questions.md)
- [Q024: Which profit centers have operating expense transactions that are not customer- or product-specific (unassigned dimension)?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### Dimensional Grain Varies by Account Type

**Rule Type:** hierarchy
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Revenue (FPA1/022, FPA1/023) and COGS (FPA1/020) are tracked at full grain: customer × product × profit center. Operating expenses (FPA1/028–035) are at profit center level only, with CUSTOMERID=# and PRODUCTID=# because OpEx is organizational cost, not customer/product-specific.

### Profit Center as Primary Management Reporting Dimension

**Rule Type:** hierarchy
**Affected Entities:** [Division](/entities/division.md), [FinancialTransaction](/entities/financial-transaction.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Profit center is the primary management reporting dimension. When the CFO asks 'how is Cruise doing?' the answer comes from profit centers under Cruise, not the product category. Profit centers capture both product line and channel (Large vs Speciality). Hierarchy: Division → Product Line → Channel.

## Data Conventions for This Entity

- **Hash (#) Means Unassigned Dimension**: # character in dimension FK columns represents unassigned/not applicable. [MUST NOT] be filtered — OpEx transactions legitimately have # for CUSTOMERID and PRODUCTID. Hash is a real dimension member with entries in master tables.
- **Multilingual Text Tables (EN/DE)**: Text tables store descriptions in multiple languages (EN, DE). Filter on LANGUAGE='EN' for English descriptions. Some entities have both EN and DE records (explains row count mismatch vs master tables).
- **Z Prefix for Custom Namespace**: SAP Z/Y prefix indicates customer-defined objects (not SAP standard). Z1/Z2/Z3 for customer types, ZCRUISE/ZMTN/ZRACING/ZYOUTH for hierarchy nodes, ZG/Z_LOG for division codes.
- **Profit Center ID Encoding Convention**: Format: CountryCode_PC+ProductLineCode+SubID+SizeCode. US10_PCC1L = US, company 10, Cruise (PCC), sub-line 1, Large (L). PCC=Cruise, PCM=Mountain, PCR=Racing, PCY=Youth. L=Large channel, S=Small/Speciality.
