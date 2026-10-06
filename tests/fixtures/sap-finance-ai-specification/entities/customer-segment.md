---
type: entity
title: Customer Segment
entity_name: CustomerSegment
entity_slug: customer-segment
description: A reference classification dimension that groups customers into business-size tiers — Speciality, Large, Medium, and Unassigned — used to drive customer segmentation and transaction-share reporting.
confidence: high
entity_type: domain_dimension
domain: sales
version: "1.0.0"
last_updated: "2026-10-05T20:33:03Z"
relationships:
  - Customer
tags: [customer-segment, domain_dimension, sales, segmentation, master-data-governance]
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
| groups | [Customer](/entities/customer.md) | Each customer segment groups one or more customers into a business-size tier (Speciality, Large, Medium, or Unassigned); the grouping is used for segmentation and transaction-share analysis. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `customer_segment_name` | STRING | Yes | Display name of the customer segment classification tier (e.g., "Speciality", "Large", "Medium", "Unassigned"). This is the primary analysis dimension used to report transaction share and revenue mix by customer tier. | Q006, Q027 |
| `status` | STRING | Yes | Lifecycle status of the customer segment record (e.g., active, inactive). A segment [MUST] be in active status to be included when computing transaction-share and revenue-mix analysis by tier. | |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `description` | STRING | No | Extended business description of the customer segment providing context beyond the display name (e.g., "Independent bike shops, premium dealers, enthusiast retailers" for Speciality). |
| `effective_date` | STRING | Yes | Operational business date (YYYY-MM-DD) when the customer segment classification record was loaded or became effective. This date [MUST] be captured so that segment reference data changes can be tied to a specific point in time for audit and historical reporting purposes. |
| `effective_date_timezone` | STRING | Yes | Timezone offset for `effective_date`, expressed in +/-HH:MM format. This [MUST] accompany `effective_date` so the business date is unambiguous when source and reporting systems operate in different timezones. |

## Supported Processes

- Master data governance

## Supported Questions

- [Q006: What percentage of financial transactions are Speciality (Z1) customer transactions?](/reference/business-questions.md)
- [Q027: What is the Gross Margin by customer segment (Speciality vs Large vs Medium)?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### Customer Segment Definitions

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [CustomerSegment](/entities/customer-segment.md)
**Rule Logic:** Customers are classified into three business segments: Z1=Speciality (independent bike shops, premium dealers), Z2=Large (big box retailers, sporting goods chains), Z3=Medium (mid-size regional chains). This classification is a business decision that persists regardless of source system.

## Data Conventions for This Entity

- **Z Prefix for Custom Namespace**: SAP Z/Y prefix indicates customer-defined objects (not SAP standard). Z1/Z2/Z3 for customer types, ZCRUISE/ZMTN/ZRACING/ZYOUTH for hierarchy nodes, ZG/Z_LOG for division codes.
