---
type: modeling_decisions
title: Modeling Decisions
description: Entity modeling decisions for VeloGroup International FP&A - a B2B cycling manufacturer with SAP FI financial transactions, GL hierarchy-driven P&L reporting, and master data governance.
confidence: high
entities_modeled: 13
entities_discarded: 0
attributes_classified: 6
timestamp: "2026-10-05T20:33:03Z"
tags: [modeling-decisions, grain, attributes]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Modeling Decisions

## Key Modeling Decisions

### All 13 Draft Entities Retained

All 13 candidate entities from the business entities analysis passed scope validation. Each entity serves at least one of the 9 in-scope business processes (per [Scope Map](/scope-map.md)). VeloGroup's SAP FI data model is a compact star schema — 1 fact table (FinancialTransaction) with 12 dimension/master data entities — where every dimension participates in financial reporting, master data governance, or P&L consolidation. No candidate entity was superfluous.

### FinancialTransaction as the Single Transactional Entity

The fact table is pre-aggregated at the dimensional grain (GL account x customer x product x profit center x version x date). This is not a journal entry or sales order — it is a financial posting aggregated at the dimensional grain. The `version` attribute (Actual/Budget) discriminates between actual and budget postings. Financial posting sub-types (cost allocations, adjusting entries, accruals) [MUST] be modeled as a payload attribute distinction (`posting_type`) rather than as separate transaction records, because they share the same dimensional grain and only differ in their semantic classification.

### P&L Hierarchy is the Analytical Core

The GL Account Hierarchy Node entity is central to answering the most business-critical questions (Gross Margin, EBIT, Net Income, OpEx splits, BvA variance). It defines the parent-child rollup structure that transforms leaf-level GL postings into P&L statement lines. The hierarchy uses a self-referential foreign key (`parent_gl_account_hierarchy_node_id`), which [MUST] allow a null/not-required value for the root node.

### Hierarchy Entities Use Self-Referential Adjacency Lists

Four hierarchy entities (GLAccountHierarchyNode, ProductHierarchyNode, CustomerHierarchyNode, ProfitCenterHierarchyNode) model parent-child adjacency lists. Self-referential foreign keys [MUST] use the `parent_` prefix with the full entity name in snake_case (e.g., `parent_gl_account_hierarchy_node_id`), and [MUST] allow a null/not-required value for root nodes — this naming convention keeps the self-reference unambiguous when a copilot generates joins.

### Division Retained Despite Zero Direct Questions

Division has no business question that references it directly, but it serves the master data governance process and is the parent entity of ProfitCenter (organizational grouping). It is a structural entity that provides the top-level organizational context (US Division, Global/ZG, Logistics/Z_LOG). Entities whose attributes support zero business questions directly [SHOULD] still be retained, with all of their attributes classified as standard — their justification is operational/organizational rather than question-driven.

### Domain Assignments Use Business Vocabulary

Domain labels reflect the business vocabulary stakeholders actually use, not an arbitrary taxonomy, so a copilot recognizes the terminology without a glossary lookup:

- **finance**: FinancialTransaction, ProfitCenter, GLAccount, AccountType, GLAccountHierarchyNode, ProfitCenterHierarchyNode
- **mdm**: Customer, Product, Division (master data entities — reference entities maintained independently and looked up by multiple business processes)
- **sales**: CustomerSegment, ProductCategory, ProductHierarchyNode, CustomerHierarchyNode (customer/product classification dimensions)

## Entity Overview

| Entity | Entity Type |
|---|---|
| [FinancialTransaction](/entities/financial-transaction.md) | transactional |
| [Customer](/entities/customer.md) | master_data |
| [Product](/entities/product.md) | master_data |
| [ProfitCenter](/entities/profit-center.md) | domain_dimension |
| [Division](/entities/division.md) | master_data |
| [GLAccount](/entities/gl-account.md) | domain_dimension |
| [CustomerSegment](/entities/customer-segment.md) | domain_dimension |
| [ProductCategory](/entities/product-category.md) | domain_dimension |
| [AccountType](/entities/account-type.md) | domain_dimension |
| [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md) | domain_dimension |
| [ProductHierarchyNode](/entities/product-hierarchy-node.md) | domain_dimension |
| [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) | domain_dimension |
| [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) | domain_dimension |

**Classification Note:** ProfitCenter is classified as `domain_dimension` rather than `master_data` because it is an analytical grouping used for classification and reporting, not a physical entity with an independent lifecycle. Division remains `master_data` because divisions have physical presence (facilities, employees) and generate transactions directly.

## Discarded Entities

None. All 13 candidate entities serve at least one in-scope business process and were retained. See [Scope Map](/scope-map.md) for the process-to-question mapping that supports this conclusion.

## Attribute Classifications

The following concepts were evaluated as potential standalone entities but classified as attributes of existing entities based on business-question dependency and independent-lifecycle analysis.

| Attribute | Parent Entity | Data Type | Supported Questions | Reasoning |
|---|---|---|---|---|
| `version` | FinancialTransaction | string | Q002, Q010, Q011 | Discriminates between Actual and Budget postings; has no independent lifecycle — it is a tag on each transaction. Required to compute BvA variance (Q002) and budget/actual splits (Q010, Q011). |
| `country` | Customer | string | Q012 | Geographic attribute of the customer; no independent lifecycle. Required to compute the US vs Canada revenue split (Q012). |
| `language` | Customer | string | — | Operational detail (SAP display language); not referenced by any business question. No independent lifecycle. |
| `price` | Product | number | Q015, Q022 | List price is a property of the product master record, changing only when the product record is updated. Required for the highest-price product lookup (Q015) and the M550 price lookup (Q022). |
| `currency` | Product | string | — | All values are USD in the extract; operational attribute. No independent lifecycle. |
| `posting_type` | FinancialTransaction | string | — | Semantic discriminator for cost allocation, adjusting entry, and accrual posting sub-types — a payload distinction, not a separate record type. No business question requires filtering by posting type. |

## Attribute Additions Beyond Base Classification

The following attributes were added to entity files beyond the base classification table above, based on relationships in the data model, denormalization-for-self-containment needs, and standard master-data fields.

### Customer

- **customer_name**: Display name; core for Q016 (Skymart Corp identification).
- **customer_segment_id, customer_segment_name**: Foreign key to CustomerSegment plus denormalized name; core for Q006, Q027.
- **customer_hierarchy_node_id**: Foreign key to CustomerHierarchyNode; standard (target entity has no directly supported questions).
- **status**: Master-data lifecycle field.

### Product

- **product_name**: Display name; core for Q014 (product count identification), Q015 (highest price product naming).
- **product_category_id, product_category_name**: Foreign key to ProductCategory plus denormalized name; core for Q003, Q007, Q017.
- **product_hierarchy_node_id**: Foreign key to ProductHierarchyNode; standard (target entity has no directly supported questions).
- **type_code**: SAP TYPECODE column; standard operational classification.
- **weight, length**: Physical product attributes; standard, optional.
- **status**: Master-data lifecycle field.

### Division

- **division_name, division_code**: Display name and SAP natural key; standard (Division has no directly supported questions).
- **status**: Master-data lifecycle field; standard, since Division's attributes are all standard.

### FinancialTransaction

- **gl_account_id, gl_account_name**: Foreign key to GLAccount plus denormalized name; core for Q003, Q009, Q019.
- **customer_id, customer_name**: Foreign key to Customer plus denormalized name; core for Q006, Q012, Q016, Q024.
- **product_id, product_name**: Foreign key to Product plus denormalized name; core for Q003, Q024.
- **profit_center_id, profit_center_name**: Foreign key to ProfitCenter plus denormalized name; core for Q024.
- **amount**: Monetary posting value (source column VALUE); core — virtually all financial questions require this.
- **posting_date, posting_date_timezone**: Operational business date (source column DATE as BIGINT YYYYMMDD) with timezone companion.
- **customer_segment_id, customer_segment_name**: Denormalized from Customer for self-containment; core for Q006 (Speciality %).
- **product_category_id, product_category_name**: Denormalized from Product for self-containment; core for Q003 (Cruise %).
- **country**: Denormalized from Customer for self-containment; core for Q012 (US vs Canada).

### ProfitCenter, GLAccount, CustomerSegment, ProductCategory, AccountType

| Entity | Attribute | Why Added |
|---|---|---|
| ProfitCenter | profit_center_name | Display name for reporting; standard. |
| ProfitCenter | division_id, division_name | Foreign key to Division plus denormalized name. |
| ProfitCenter | profit_center_hierarchy_node_id | Foreign key for organizational rollup. |
| ProfitCenter | language | SAP operational attribute (LANGUAGE column). |
| GLAccount | gl_account_name | Display name; standard. |
| GLAccount | account_type_id, account_type_name | Foreign key to AccountType plus denormalized name; core — enables INC/EXP classification for Q001, Q009, Q013. |
| GLAccount | gl_account_hierarchy_node_id | Foreign key for P&L hierarchy traversal; core for Q001, Q009, Q013, Q021, Q025, Q026, Q027. |
| CustomerSegment | customer_segment_name | Core: Q006 and Q027 reference segments by display name (Z1=Speciality, Z2=Large, Z3=Medium). |
| CustomerSegment | description | Extended description; standard. |
| ProductCategory | product_category_name | Core: Q003, Q007, Q017 reference product lines by display name (CR=Cruise, MT=Mountain, etc.). |
| ProductCategory | description | Extended description; standard. |
| AccountType | account_type_name | Display name; standard (entity has no directly supported questions). |
| AccountType | description | Extended description; standard. |

### Hierarchy Node Entities (GLAccountHierarchyNode, ProductHierarchyNode, CustomerHierarchyNode, ProfitCenterHierarchyNode)

Common structural attributes added to all four hierarchy node entities, inherent to the adjacency-list pattern:

| Attribute | Why Added |
|---|---|
| `node_name` | Display name from the source DESCRIPTION column. Essential for identifying hierarchy nodes by P&L line item name (GL), product line (Product), customer grouping (Customer), or organizational unit (ProfitCenter). |
| `hierarchy_level` | From the source LEVEL column. Required for hierarchy traversal and rollup aggregation path computation. |
| `parent_*_hierarchy_node_id` | Self-referential foreign key per the adjacency-list pattern. Uses the `parent_` prefix with the full entity name in snake_case; [MUST] allow a null/not-required value for root nodes. |
| `is_leaf` | Distinguishes leaf nodes (receive postings) from rollup/grouping nodes (calculated). Classified `core` only for GLAccountHierarchyNode, because the leaf-vs-rollup distinction is fundamental to P&L construction. Classified `standard` for the other three entities. |

**Classification Rationale:** GLAccountHierarchyNode has 4 core attributes because it has directly supported questions (Q001, Q002, Q007, Q009, Q013, Q018, Q021, Q025, Q026) — `is_leaf` is core because leaf vs rollup distinction is fundamental to P&L construction. ProductHierarchyNode, CustomerHierarchyNode, and ProfitCenterHierarchyNode have zero directly supported questions, so all of their attributes are classified standard with operational/structural justification.

## Refinement Corrections Applied

- **version (FinancialTransaction):** Added Q002 to supported questions (was Q010, Q011; now Q002, Q010, Q011). Q002 is the Budget vs Actual variance question for Net Income, and `version` is the essential Actual/Budget discriminator — without it, actual and budget amounts cannot be separated to compute variance.
- **status (GLAccount):** Added Q008 ("How many GL accounts are in the chart of accounts?") to the attribute's supported questions, because a GL account status change (active/inactive) directly affects the answer to Q008.

## Question Coverage

See [Business Questions](/reference/business-questions.md) for the full set of 27 validated questions with answers and source-type tags, and [Scope Map](/scope-map.md) for the mapping of these questions to in-scope business processes.
