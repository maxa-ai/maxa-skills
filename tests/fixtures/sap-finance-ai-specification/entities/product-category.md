---
type: entity
title: ProductCategory
entity_name: ProductCategory
entity_slug: product-category
description: Static reference data classifying VeloGroup's products into product lines (Cruise, Mountain, Racing, Youth) and minor internal-tracking categories; 8 fixed values used as the primary product-line analysis dimension.
confidence: high
entity_type: domain_dimension
domain: sales
version: "1.0.0"
last_updated: "2026-10-06T00:00:00Z"
relationships:
  - Product
tags: [domain_dimension, sales, reference_data, product_classification, master_data_governance]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| one_to_many | [Product](/entities/product.md) | ProductCategory classifies Products — each product belongs to exactly one product category, referenced via `product_category_id` on the Product record. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `product_category_name` | STRING | Yes | Display name of the product category / product line (e.g., "Cruise", "Mountain", "Racing", "Youth"). [MUST] be used as the primary analysis dimension for product-line transaction share (Q003), product-line profitability (Q007), and product-line revenue trend (Q017) — all three business questions reference product lines by this display name rather than their internal code. | Q003, Q007, Q017 |
| `status` | STRING | Yes | Lifecycle status of the product category record (e.g., active, inactive). [MUST] be used to filter to valid, currently-active product line categories before computing transaction share (Q003) or profitability (Q007) metrics, since inactive categories should not distort current-period analysis. | Q003, Q007 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|
| `description` | STRING | No | Extended business description of the product category providing FP&A relevance context — for example, "Primary product line" for Cruise versus "Internal tracking; not relevant for FP&A" for Trade Materials. Useful for distinguishing the four primary product lines (Cruise, Mountain, Racing, Youth) from minor internal categories (Finished Goods, Trade Materials, Raw Materials, Unassigned) that carry minimal transaction volume. |
| `effective_date` | DATE | Yes | Operational business date when the product category classification record was loaded or became effective (YYYY-MM-DD format). [MUST] be populated on every product category record so that point-in-time reference-data lookups remain reliable even as the classification scheme evolves. |
| `effective_date_timezone` | STRING | Yes | Timezone offset for `effective_date`, expressed in +/-HH:MM format. [MUST] accompany `effective_date` on every record so the operational date is unambiguous regardless of the reporting timezone in which it is consumed. |

## Supported Processes

- Master Data Governance

## Supported Questions

- [Q003: What percentage of total financial transactions belong to the Cruise product line?](/reference/business-questions.md)
- [Q007: Is the Youth bike line profitable on its own, or is it a loss leader?](/reference/business-questions.md)
- [Q017: What is the revenue trend by product line (Cruise, Mountain, Racing, Youth) across 2018–2021?](/reference/business-questions.md)

## Business Rules Affecting This Entity

No business rules directly affect this entity.

## Data Conventions for This Entity

- **Z Prefix for Custom Namespace**: SAP Z/Y prefix indicates customer-defined objects (not SAP standard). Z1/Z2/Z3 for customer types, ZCRUISE/ZMTN/ZRACING/ZYOUTH for hierarchy nodes, ZG/Z_LOG for division codes.
