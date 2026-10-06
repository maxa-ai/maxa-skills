---
type: entity
title: ProfitCenterHierarchyNode
entity_name: ProfitCenterHierarchyNode
entity_slug: profit-center-hierarchy-node
description: A node in the profit center hierarchy that organizes profit centers under the US Division → Product Line → Channel structure, defining the management reporting rollup used for organizational analysis.
confidence: medium
entity_type: domain_dimension
domain: finance
version: "1.0.0"
last_updated: "2026-10-05T20:02:35Z"
relationships:
  - ProfitCenterHierarchyNode
  - ProfitCenter
tags: [finance, domain_dimension, hierarchy, profit_center, management_reporting]
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
| self-referential (parent-child) | [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md) | Each node links to its parent node to form the adjacency-list hierarchy defining the US Division → Product Line → Channel rollup path. The root node has no parent. |
| referenced_by | [ProfitCenter](/entities/profit-center.md) | Individual profit centers are grouped under a hierarchy node, enabling aggregation from a specific profit center up through product line and division groupings for management reporting. |

## Core Attributes

No core attributes are defined for this entity. This entity functions as a structural organizational classification used for hierarchy traversal and rollup, rather than one that is queried directly to answer business questions.

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `node_name` | STRING | Yes | Display name of the profit center hierarchy node (e.g., "US Division", "Cruise", "Mountain", "Global/ZG", "Logistics/Z_LOG"). Identifies the organizational rollup grouping used for management reporting. |
| `hierarchy_level` | NUMBER | Yes | Depth level of the node within the profit center hierarchy tree (Root → Division → Product Line → Channel). Determines the organizational granularity and is used to compute the rollup aggregation path. |
| `parent_profit_center_hierarchy_node_id` | STRING | No | Self-referential foreign key to the parent node in the profit center hierarchy adjacency list, enabling traversal of the US Division → Product Line → Channel rollup structure. Null for the root node. May change when the organizational structure is restructured. |
| `is_leaf` | BOOLEAN | Yes | Indicates whether this node is a leaf (an actual profit center placement) or a grouping node (a division or product line rollup). |
| `effective_date` | STRING | Yes | Operational business date on which this profit center hierarchy node was established or last restructured, captured separately from the system recording timestamp so that business-effective timing can be distinguished from system entry timing. |
| `effective_date_timezone` | STRING | Yes | Timezone offset (±HH:MM) paired with `effective_date`, ensuring the business-effective date can be interpreted unambiguously regardless of the recording system's local timezone. |

## Supported Processes

- Master Data Governance
- P&L Consolidation Reporting

## Supported Questions

No business questions directly reference this entity. It functions as a structural/organizational classification entity that supports profit center rollup aggregation — grouping the 37 profit centers under the US Division → Product Line → Channel structure — for processes such as P&L Consolidation Reporting and Master Data Governance, but no business question queries it directly by name.

## Business Rules Affecting This Entity

No business rules directly affect this entity.

## Data Conventions for This Entity

No data conventions directly affect this entity.
