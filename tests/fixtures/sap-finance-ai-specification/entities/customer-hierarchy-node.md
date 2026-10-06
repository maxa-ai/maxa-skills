---
type: entity
title: CustomerHierarchyNode
entity_name: CustomerHierarchyNode
entity_slug: customer-hierarchy-node
description: A node in the customer hierarchy that groups VeloGroup's customers by type and geography, providing drill-down structure for customer analysis.
confidence: medium
entity_type: domain_dimension
domain: sales
version: "1.0.0"
last_updated: "2026-10-06T00:00:00Z"
relationships:
  - CustomerHierarchyNode
  - Customer
tags: [hierarchy, customer-grouping, sales, master-data-governance]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| self-referential (parent) | [CustomerHierarchyNode](/entities/customer-hierarchy-node.md) | Each customer hierarchy node references its parent node in the adjacency list. Null for the root node. |
| parent_of | [Customer](/entities/customer.md) | Customers are grouped under customer hierarchy nodes for analysis by type (Speciality/Large/Medium) and geography (US/Canada). |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|

CustomerHierarchyNode has no core attributes because no business question directly references customer hierarchy node data — it functions as structural context for grouping customers by type and geography rather than as an analytical dimension queried in its own right.

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `node_name` | STRING | Yes | Display name of the customer hierarchy node, identifying the customer grouping this node represents — by type (e.g., Speciality, Large, Medium) or by geography (e.g., US, Canada). |
| `hierarchy_level` | NUMERIC | Yes | Depth level of the node within the customer hierarchy tree. Determines the grouping granularity available for customer analysis. |
| `parent_customer_hierarchy_node_id` | STRING | No | Foreign key to the parent node in the customer hierarchy adjacency list. Null for the root node. Defines the customer type and geography grouping structure. |
| `is_leaf` | BOOLEAN | Yes | Whether this node is a leaf (an individual customer placement) or a grouping node (a customer-type or geography rollup). |
| `effective_date` | DATE | Yes | Operational business date when this customer hierarchy node was established. Hierarchy and master data records [MUST] carry an operational business date distinct from the system recording timestamp, so a node's effective business change can be reasoned about by when it took effect rather than when it was captured in the system. |
| `effective_date_timezone` | STRING | Yes | Timezone offset for `effective_date` in +/-HH:MM format. Records [MUST] carry an explicit timezone offset alongside every operational date so that date comparisons remain unambiguous across reporting regions. |

## Supported Processes

- Master Data Governance

## Supported Questions

CustomerHierarchyNode has no directly supported business questions. It is retained as a structural entity because it provides the grouping scaffold — 56 nodes organizing VeloGroup's 53 customers by type (Speciality/Large/Medium) and geography (US/Canada) — that underlies customer-level reporting, even though no business question queries this entity directly. It participates in the Master Data Governance process as the structure that positions each Customer record within a type-and-geography grouping.

**Known gap:** Specific hierarchy node identifiers and the detailed parent-child structure of the 56-row hierarchy were not captured during discovery. Only the table name, row count, and grouping dimensions (type and geography) are confirmed. (confidence: medium)

## Business Rules Affecting This Entity

No business rules directly affect this entity.

## Data Conventions for This Entity

No data conventions directly affect this entity.
