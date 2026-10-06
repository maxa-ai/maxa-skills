---
type: entity
title: Customer
entity_name: Customer
entity_slug: customer
description: A B2B retailer that VeloGroup sells to, classified by customer segment (Speciality, Large, Medium) and geography (US, Canada).
confidence: high
entity_type: master_data
domain: mdm
version: "1.0.0"
last_updated: "2026-10-06T00:00:00Z"
relationships:
  - CustomerSegment
  - CustomerHierarchyNode
  - FinancialTransaction
tags: [customer, master_data, mdm, b2b, retailer]
sources:
  - VeloGroup-Maxa-Project-Kick-Off.md
  - VeloGroup-Maxa-FPA-Workshop.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| classified_by | [CustomerSegment](/entities/customer-segment.md) | Each customer is classified into exactly one segment tier — Speciality, Large, Medium, or Unassigned — that drives channel-based analysis and reporting. |
| grouped_in | [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) | Each customer is positioned in a grouping hierarchy organized by customer type and geography. |
| referenced_by | [FinancialTransaction](/entities/financial-transaction.md) | Financial transactions reference the customer associated with the posting. Operating-expense transactions use the Unassigned (#) sentinel instead of a specific customer, because those costs are organizational, not customer-specific. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `customer_name` | STRING | Yes | Display name of the B2B customer retailer (e.g., TechCycle, Skymart Corp, Suburban Cycle) | Q016 |
| `customer_segment_id` | STRING | Yes | Reference to the customer's segment classification. Classifies the customer by channel tier (Speciality, Large, Medium, or Unassigned) | Q006, Q027 |
| `country` | STRING | Yes | Customer geographic location (US or Canada). [MUST] be populated to support US vs. Canada revenue split analysis | Q012 |
| `status` | STRING | Yes | Lifecycle state of the customer record (e.g., active, inactive). [MUST] be accurate to produce correct customer counts | Q004 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `customer_segment_name` | STRING | Yes | Denormalized display name of the customer segment (e.g., Speciality, Large, Medium), stored directly on the customer record so the segment name is available without a separate lookup |
| `customer_hierarchy_node_id` | STRING | Yes | Reference to the customer hierarchy node that positions this customer within the grouping hierarchy by type and geography |
| `language` | STRING | No | SAP display language code. Operational detail not used in financial analysis |
| `created_date` | STRING | Yes | Operational date when the customer record was created in SAP (format: YYYY-MM-DD) |
| `created_date_timezone` | STRING | Yes | Timezone offset accompanying `created_date` (e.g., +00:00). [SHOULD] always be paired with its operational date field so date values are unambiguous across the regions VeloGroup operates in |
| `updated_date` | STRING | Yes | Operational date when the customer record was last modified (format: YYYY-MM-DD) |
| `updated_date_timezone` | STRING | Yes | Timezone offset accompanying `updated_date` (e.g., +00:00). [SHOULD] always be paired with its operational date field so date values are unambiguous across the regions VeloGroup operates in |

## Supported Processes

- Financial Transaction Flow — sales orders received from customers flow through SAP FI, generating financial postings tied to the customer record.
- Master Data Governance — new customers are requested by the sales team, reviewed and approved by FP&A, and created as master records with segment and hierarchy assignments.

## Supported Questions

- [Q004: How many customers does VeloGroup have in total?](/reference/business-questions.md)
- [Q006: What percentage of financial transactions are Speciality (Z1) customer transactions?](/reference/business-questions.md)
- [Q012: What percentage of total revenue is from US customers vs Canadian customers?](/reference/business-questions.md)
- [Q016: Does Skymart Corp (or any single customer) represent more than 15% of total revenue?](/reference/business-questions.md)
- [Q027: What is the Gross Margin by customer segment (Speciality vs Large vs Medium)?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### Dimensional Grain Varies by Account Type

**Rule Type:** hierarchy
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Revenue (FPA1/022, FPA1/023) and COGS (FPA1/020) are tracked at full grain: customer × product × profit center. Operating expenses (FPA1/028–035) are at profit center level only, with CUSTOMERID=# and PRODUCTID=# because OpEx is organizational cost, not customer/product-specific.

### Customer Segment Definitions

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [CustomerSegment](/entities/customer-segment.md)
**Rule Logic:** Customers are classified into three business segments: Z1=Speciality (independent bike shops, premium dealers), Z2=Large (big box retailers, sporting goods chains), Z3=Medium (mid-size regional chains). This classification is a business decision that persists regardless of source system.

## Data Conventions for This Entity

- **Hash (#) Means Unassigned Dimension**: # character in dimension FK columns represents unassigned/not applicable. [MUST NOT] be filtered — OpEx transactions legitimately have # for CUSTOMERID and PRODUCTID. Hash is a real dimension member with entries in master tables.
- **Multilingual Text Tables (EN/DE)**: Text tables store descriptions in multiple languages (EN, DE). Filter on LANGUAGE='EN' for English descriptions. Some entities have both EN and DE records (explains row count mismatch vs master tables).
