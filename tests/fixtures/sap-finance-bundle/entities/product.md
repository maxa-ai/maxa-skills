---
type: entity
title: Product
entity_name: Product
entity_slug: product
description: Physical good manufactured and sold by VeloGroup, including bicycles and e-bikes across four main product lines (Cruise, Mountain, Racing, Youth) plus ancillary categories.
confidence: high
entity_type: master_data
domain: mdm
version: "1.0.0"
last_updated: 2026-05-27T19:05:07Z
relationships:
  - FinancialTransaction
tags: [master-data, product, bicycle, e-bike, pricing, product-line]
sources:
  - VeloGroup-Maxa-Project-Kick-Off
  - VeloGroup-Maxa-FPA-Workshop
---

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| referenced_by | [FinancialTransaction](/entities/financial-transaction.md) | Revenue and COGS financial transactions reference Product via `product_id`. Each transaction is recorded at the product dimensional grain, enabling product-level revenue and profitability analysis. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `product_name` | STRING | Yes | Display name of the product as registered in SAP master data. | Q021 |
| `product_category_id` | STRING | Yes | Product line classification code (CR=Cruise, MT=Mountain, RC=Racing, YH=Youth, FG=Finished Goods, TM, RB, #). Determines the product's line assignment for transaction analysis. Product categories have no independent lifecycle — they are an 8-value classification enum modeled as an attribute on Product rather than a separate entity, because all product line analysis uses this as a filter/group-by attribute. | Q017, Q022 |
| `price` | NUMERIC | Yes | List price of the product in USD. Used for product pricing analysis and highest-priced product identification. | Q017 |
| `status` | STRING | Yes | Lifecycle state of the product master record (e.g., Active, Discontinued). Tracks whether the product is currently available for sale. | — |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `currency_code` | STRING | Yes | Currency of the product price. Always 'USD' in VeloGroup's current dataset — all products priced in USD. |
| `type_code` | STRING | No | SAP product type code for internal classification purposes. |
| `created_date` | DATETIME | Yes | Business date when the product master record was created in SAP. |
| `created_date_timezone` | STRING | Yes | Timezone offset for the created date, because SAP stores timestamps in server local time without timezone metadata — the timezone [MUST] be preserved to support correct temporal analysis. |
| `updated_date` | DATETIME | Yes | Business date when the product master record was last updated. |
| `updated_date_timezone` | STRING | Yes | Timezone offset for the updated date, because SAP stores timestamps in server local time without timezone metadata — the timezone [MUST] be preserved to support correct temporal analysis. |

## Supported Processes

- Master data governance — products are created and maintained through SAP master data governance; new products are set up with category, pricing, and hierarchy placement once approved for production.
- Financial transaction flow (Revenue/COGS) — Product is a required dimension on revenue and COGS transactions, enabling product-level profitability analysis.

## Supported Questions

- [Q006: Is the Youth bike line profitable on its own, or is it a loss leader?](/reference/business-questions.md)
- [Q017: What is the transaction share by product line (Cruise, Mountain, Racing, Youth)?](/reference/business-questions.md)
- [Q020: What is the e-bike revenue growth rate year-over-year?](/reference/business-questions.md)
- [Q021: How many products does VeloGroup have in its catalog?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### Revenue and COGS at Full Dimensional Grain

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Revenue (Gross Revenue, Sales Deductions) and COGS transactions carry full dimensional detail — Customer, Product, and Profit Center are all populated. This enables product-level and customer-level profitability analysis.
**Supporting KPIs:** FKPI-04, FKPI-05

### Hash (#) as Legitimate Dimension Member

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** The # (Unassigned) value is a first-class dimension member that [MUST NOT] be filtered out. It has master data entries, text descriptions, and hierarchy positions. Removing # transactions would eliminate the entire Operating Expense section from consolidated reporting.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[47:19]
> {"speaker": "Karen Liu", "timestamp": "47:19", "quote": "Yes. Don't filter it out. If you remove hash transactions, your entire Operating Expense section disappears. It's meaningful data."}

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[21:36]
> {"speaker": "Marcus Weber", "timestamp": "21:36", "quote": "If a financial transaction doesn't have a customer assigned, the customer foreign key will just be the hash symbol. You'll see this across all dimensions. And this is important, you can't just filter those out because some of those unassigned records are perfectly legitimate financial postings."}

## Data Conventions for This Entity

- **Hash Symbol for Unassigned Dimension Members**: The # character represents 'Unassigned' across all dimensions. Operating expenses have CUSTOMERID=# and PRODUCTID=#. Hash is a real dimension member with master data entries, text, and hierarchy position. [MUST NOT] be filtered out.
- **Multilingual Text Tables with Language Filter**: Text tables store descriptions in multiple languages (EN, DE). Join on ID and filter LANGUAGE='EN' for English descriptions [MUST] be applied to retrieve the correct product name variant.
