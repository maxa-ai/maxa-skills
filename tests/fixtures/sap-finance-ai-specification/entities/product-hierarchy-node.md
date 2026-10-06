---
type: entity
title: ProductHierarchyNode
entity_name: ProductHierarchyNode
entity_slug: product-hierarchy-node
description: A node in the product hierarchy that groups products under product line groupings (e.g., Cruise, Mountain, Racing, Youth, Finished Goods), providing drill-down structure for product analysis within a parent-child hierarchy tree.
confidence: high
entity_type: domain_dimension
domain: sales
version: "1.0.0"
last_updated: "2026-10-06T00:00:00Z"
relationships:
  - ProductHierarchyNode
  - Product
tags: [product-hierarchy, domain-dimension, sales, master-data-governance]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
---

<!-- SKELETON: Business Rules and Data Conventions sections below are pre-populated -->
<!-- by the prepare_entity_skeletons tool. Do NOT modify, rewrite, or remove them. -->
<!-- Fill in all other sections: description, relationships, attributes, processes, questions. -->

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| self-referential (parent/child) | [ProductHierarchyNode](/entities/product-hierarchy-node.md) | A product hierarchy node may reference a parent node, forming a multi-level rollup tree used for drill-down analysis. The root node has no parent. |
| groups | [Product](/entities/product.md) | A product hierarchy node groups one or more products under a product line (e.g., the Cruise grouping gathers products C900, C950, C990, E101, E102, E103). |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|

ProductHierarchyNode has no core attributes because no business question directly references product hierarchy node data — it functions as structural reference data supporting product categorization rather than as an analytical dimension queried in its own right.

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `node_name` | STRING | Yes | Display name of the product hierarchy node (e.g., Cruise, Mountain, Racing, Youth, Finished Goods). Identifies the product line grouping this node represents. |
| `hierarchy_level` | NUMBER | Yes | Depth level of the node within the product hierarchy tree. Lower numbers represent broader groupings (product lines); higher numbers represent more specific placements (individual products). |
| `parent_product_hierarchy_node_id` | STRING | No | Reference to the parent node in the product hierarchy's parent-child structure. Null for the root node. Defines the product line grouping rollup path used for drill-down analysis. |
| `is_leaf` | BOOLEAN | Yes | Whether this node is a leaf (an individual product placement) or a grouping node (a product line rollup such as Cruise or Mountain). |
| `effective_date` | DATE | Yes | Business date when this product hierarchy node was established (YYYY-MM-DD). |
| `effective_date_timezone` | STRING | Yes | Timezone offset paired with `effective_date` (e.g., +00:00). Reference data records [MUST] carry an explicit timezone offset alongside every operational date so that date comparisons remain unambiguous across reporting regions. |

## Supported Processes

- Master Data Governance

## Supported Questions

ProductHierarchyNode has no directly supported business questions. It is retained as structural reference data because it defines the product line grouping structure (e.g., Cruise, Mountain, Racing, Youth, Finished Goods) that Product records roll up into for drill-down analysis. ProductHierarchyNode participates in the Master Data Governance process even though no business question queries its attributes directly.

## Business Rules Affecting This Entity

No business rules directly affect this entity.

## Data Conventions for This Entity

No data conventions directly affect this entity.
