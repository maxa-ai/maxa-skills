---
type: entity
title: Product
entity_name: Product
entity_slug: product
description: A physical cycling product manufactured and sold by VeloGroup International, carrying SKU, list price, and category classification used to analyze revenue and cost of goods sold by product line (Cruise, Mountain, Racing, Youth).
confidence: medium
entity_type: master_data
domain: mdm
version: "1.0.0"
last_updated: "2026-10-06T00:00:00Z"
relationships:
  - ProductCategory
  - ProductHierarchyNode
  - FinancialTransaction
tags: [master_data, product, pricing, product_line]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
  - teachers_manual/entity_examples/product.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| many_to_one | [ProductCategory](/entities/product-category.md) | Each product is classified into exactly one product category (CR/Cruise, MT/Mountain, RC/Racing, YH/Youth, FG, TM, RB), the product line grouping used throughout financial reporting. |
| many_to_one | [ProductHierarchyNode](/entities/product-hierarchy-node.md) | Each product is positioned under one hierarchy node (e.g., ZCRUISE, ZMTN, ZRACING, ZYOUTH, ZFGOODS) that provides drill-down structure for product line analysis. |
| one_to_many | [FinancialTransaction](/entities/financial-transaction.md) | A product is referenced by many financial transactions. Revenue and COGS postings [MUST] carry the specific product dimension, while Operating Expense postings use an unassigned placeholder for this dimension because OpEx is organizational cost, not product-specific. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `product_name` | STRING | Yes | Display name of the product (e.g., M550 Mountain Premium, C900 Cruise Standard) | Q014, Q015 |
| `product_category_id` | STRING | Yes | Foreign key to the product category that classifies the product by product line (CR/Cruise, MT/Mountain, RC/Racing, YH/Youth, FG, TM, RB) | Q003, Q007, Q017 |
| `price` | NUMERIC | Yes | List price of the product in local currency (e.g., M550 at $4,999, C900 at $799); used for price ranking and lookup | Q015, Q022 |
| `status` | STRING | Yes | Lifecycle state of the product record (e.g., active, inactive) — required for accurate product counts over time | Q014 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `product_category_name` | STRING | Yes | Denormalized display name of the product category, carried directly on the product record for self-containment (e.g., Cruise, Mountain, Racing, Youth) |
| `product_hierarchy_node_id` | STRING | Yes | Foreign key to the product hierarchy node that positions the product within the product line grouping hierarchy (e.g., ZCRUISE, ZMTN, ZRACING, ZYOUTH, ZFGOODS) |
| `currency` | STRING | Yes | Currency code for the list price (e.g., USD); all VeloGroup products are currently priced in USD |
| `type_code` | STRING | Yes | SAP product type classification code (TYPECODE), used for operational classification of product master data |
| `weight` | NUMERIC | No | Product weight — a physical attribute used for logistics and product specification |
| `length` | NUMERIC | No | Product length — a physical attribute used for logistics and product specification |
| `created_date` | STRING | Yes | Operational date when the product record was created in SAP (YYYY-MM-DD) |
| `created_date_timezone` | STRING | Yes | Timezone offset paired with `created_date`, ensuring the operational date is interpreted unambiguously across time zones (e.g., +00:00) |
| `updated_date` | STRING | No | Operational date when the product record was last modified (YYYY-MM-DD); present once a product has been updated at least once |
| `updated_date_timezone` | STRING | No | Timezone offset paired with `updated_date`, ensuring the operational date is interpreted unambiguously across time zones (e.g., +00:00) |

## Supported Processes

- Master Data Governance
- Financial Transaction Flow

## Supported Questions

- [Q003: What percentage of total financial transactions belong to the Cruise product line?](/reference/business-questions.md)
- [Q007: Is the Youth bike line profitable on its own, or is it a loss leader?](/reference/business-questions.md)
- [Q014: How many products does VeloGroup have?](/reference/business-questions.md)
- [Q015: Which product has the highest list price?](/reference/business-questions.md)
- [Q017: What is the revenue trend by product line (Cruise, Mountain, Racing, Youth) across 2018–2021?](/reference/business-questions.md)
- [Q022: What is the price of the M550 Mountain bike?](/reference/business-questions.md)
- [Q024: Which profit centers have OpEx transactions that are not customer- or product-specific (# Unassigned)?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### Dimensional Grain Varies by Account Type

**Rule Type:** hierarchy
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Revenue (FPA1/022, FPA1/023) and COGS (FPA1/020) are tracked at full grain: customer × product × profit center. Operating expenses (FPA1/028–035) are at profit center level only, with CUSTOMERID=# and PRODUCTID=# because OpEx is organizational cost, not customer/product-specific.

## Data Conventions for This Entity

- **Hash (#) Means Unassigned Dimension**: # character in dimension FK columns represents unassigned/not applicable. [MUST NOT] be filtered — OpEx transactions legitimately have # for CUSTOMERID and PRODUCTID. Hash is a real dimension member with entries in master tables.
- **Multilingual Text Tables (EN/DE)**: Text tables store descriptions in multiple languages (EN, DE). Filter on LANGUAGE='EN' for English descriptions. Some entities have both EN and DE records (explains row count mismatch vs master tables).
- **Product Category Codes**: Eight categories: CR (Cruise), MT (Mountain), RC (Racing), YH (Youth), FG (Finished Goods), TM (Trade Materials), RB (Raw Materials), # (Unassigned).
