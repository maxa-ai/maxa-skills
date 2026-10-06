---
type: entity
title: Division
entity_name: Division
entity_slug: division
description: A top-level organizational unit in VeloGroup's corporate structure that groups profit centers by geographic and functional boundary.
confidence: high
entity_type: master_data
domain: mdm
version: "1.0.0"
last_updated: "2026-10-06T00:00:00Z"
relationships:
  - ProfitCenter
tags: [organizational-structure, master-data, mdm]
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
| parent_of | [ProfitCenter](/entities/profit-center.md) | A division groups one or more profit centers. VeloGroup has four divisions: US Division (28 profit centers), Global (3 profit centers), Logistics (4 profit centers), and Year-end (1 profit center for year-end adjustments). |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|

Division has no core attributes because no business question directly references division-level data — it functions as structural context for Profit Center rather than as an analytical dimension in its own right.

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `division_name` | STRING | Yes | Display name of the organizational division (e.g., US Division, Global, Logistics, Year-end). |
| `division_code` | STRING | Yes | Organizational code identifying the division (e.g., US10, ZG, Z_LOG, YB). This is the natural key used to identify a division in the source system. |
| `status` | STRING | Yes | Lifecycle state of the division record (e.g., active/inactive). Classified as standard rather than core because no business question requires filtering or aggregating by division status. |
| `created_date` | DATE | Yes | Operational date when the division record was established (YYYY-MM-DD). |
| `created_date_timezone` | STRING | Yes | Timezone offset paired with `created_date` (e.g., +00:00). Division records [MUST] carry an explicit timezone offset alongside every operational date so that date comparisons remain unambiguous across reporting regions. |
| `updated_date` | DATE | Yes | Operational date when the division record was last modified (YYYY-MM-DD). |
| `updated_date_timezone` | STRING | Yes | Timezone offset paired with `updated_date` (e.g., +00:00). Division records [MUST] carry an explicit timezone offset alongside every operational date so that date comparisons remain unambiguous across reporting regions. |

## Supported Processes

- Master Data Governance

## Supported Questions

Division has no directly supported business questions. It is retained as a structural entity because it provides the top-level organizational context (US Division, Global, Logistics, Year-end) and is the parent of Profit Center, which is itself central to management reporting. Division participates in the Master Data Governance process even though no business question queries it directly.

## Business Rules Affecting This Entity

### Profit Center as Primary Management Reporting Dimension

**Rule Type:** hierarchy
**Affected Entities:** [Division](/entities/division.md), [FinancialTransaction](/entities/financial-transaction.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Profit center is the primary management reporting dimension. When the CFO asks 'how is Cruise doing?' the answer comes from profit centers under Cruise, not the product category. Profit centers capture both product line and channel (Large vs Speciality). Hierarchy: Division → Product Line → Channel.

## Data Conventions for This Entity

No data conventions directly affect this entity.
