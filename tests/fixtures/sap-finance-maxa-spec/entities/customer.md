---
type: entity
title: Customer
entity_name: Customer
entity_slug: customer
description: B2B retail customer that VeloGroup sells to, including independent bike shops, big box retailers, and regional chains across the US and Canada, classified by customer type segment (Speciality, Large, Medium).
confidence: high
entity_type: master_data
domain: mdm
version: "1.0.0"
last_updated: 2026-05-27T19:05:07Z
relationships:
  - FinancialTransaction
tags: [master-data, customer, segmentation, b2b, mdm]
sources:
  - VeloGroup-Maxa-Project-Kick-Off
  - VeloGroup-Maxa-FPA-Workshop
---

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| referenced_by | [FinancialTransaction](/entities/financial-transaction.md) | Each financial transaction references a customer via `customer_id`. Revenue and COGS transactions carry a specific customer; operating expense transactions use # (Unassigned) as the customer dimension. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `customer_name` | STRING | Yes | Official business name of the customer as registered in SAP master data. | Q005, Q007, Q008, Q022 |
| `customer_type_id` | STRING | Yes | Customer segment classification code (Z1=Speciality, Z2=Large, Z3=Medium, #=Unassigned). Determines the customer's channel classification for transaction analysis. | Q005, Q007, Q016, Q022 |
| `country` | STRING | Yes | Country where the customer is located (US or Canada). Used for geographic filtering and revenue share analysis. | Q008 |
| `status` | STRING | Yes | Lifecycle state of the customer master record (e.g., Active, Inactive). Tracks whether the customer is currently active for transactions. | Q007 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `language` | STRING | No | Language preference for the customer record as stored in SAP. Operational detail for communication purposes. |
| `created_date` | DATETIME | Yes | Business date when the customer master record was created in SAP. |
| `created_date_timezone` | STRING | Yes | Timezone offset for the created date, because financial systems [MUST] preserve timezone context to avoid ambiguity in cross-timezone operations. |
| `updated_date` | DATETIME | Yes | Business date when the customer master record was last updated. |
| `updated_date_timezone` | STRING | Yes | Timezone offset for the updated date, because financial systems [MUST] preserve timezone context to avoid ambiguity in cross-timezone operations. |

## Supported Processes

- Master data governance — new customers are requested by the sales team, reviewed and approved by FP&A, then created in SAP with customer type, country, and hierarchy node linkage
- Financial transaction flow (revenue/COGS) — the Customer dimension is populated on all revenue and COGS transactions, enabling customer-level profitability analysis

## Supported Questions

- [Q005: What percentage of total revenue does each individual customer represent?](/reference/business-questions.md)
- [Q007: Which channel is more profitable per unit — Speciality (Z1) or Large (Z2)?](/reference/business-questions.md)
- [Q008: How many customers does VeloGroup have, and how are they distributed by country?](/reference/business-questions.md)
- [Q016: What percentage of financial transactions come from each customer segment (Speciality, Large, Medium)?](/reference/business-questions.md)
- [Q022: Which customers rank highest by contribution to gross margin?](/reference/business-questions.md)

## Business Rules Affecting This Entity

### Revenue and COGS at Full Dimensional Grain

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Revenue (Gross Revenue, Sales Deductions) and COGS transactions [MUST] carry full dimensional detail — Customer, Product, and Profit Center [MUST] all be populated. This enables product-level and customer-level profitability analysis.
**Supporting KPIs:** FKPI-04, FKPI-05

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[13:05]
> {"speaker": "Karen Liu", "timestamp": "13:05", "quote": "Revenue and COGS: full grain with customer, product, and profit center. OpEx: profit center only with hash for customer and product."}

### Hash (#) as Legitimate Dimension Member

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** The # (Unassigned) value is a first-class dimension member that [MUST NOT] be filtered out. It has master data entries, text descriptions, and hierarchy positions. Removing # transactions would eliminate the entire Operating Expense section from consolidated reporting.

Source: Workshop, 47:19 / Kick-Off, 21:36

## Data Conventions for This Entity

### Hash Symbol for Unassigned Dimension Members (SAP FI (BPC))

**Convention Type:** sentinel_value
**Affected Entities:** [Customer](/entities/customer.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Description:** The # character represents 'Unassigned' across all dimensions. Operating expenses have CUSTOMERID=# and PRODUCTID=#. Hash is a real dimension member with master data entries, text, and hierarchy position. [MUST NOT] be filtered out.

### Multilingual Text Tables with Language Filter (SAP FI (BPC))

**Convention Type:** filtering
**Affected Entities:** [Customer](/entities/customer.md), [GLAccount](/entities/gl-account.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Description:** Text tables store descriptions in multiple languages (EN, DE). Join on ID and filter LANGUAGE='EN' for English descriptions. Some customers have both EN and DE entries.
