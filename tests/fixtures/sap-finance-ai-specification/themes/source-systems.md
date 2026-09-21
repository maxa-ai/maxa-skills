---
type: source_systems
title: Source Systems
description: Inventory of source systems, star schema architecture, and 10 data conventions for VeloGroup's SAP FI/BPC environment and manual Excel reporting.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [source-systems, sap, star-schema, data-conventions, encoding]
sources:
  - VeloGroup-Maxa-Project-Kick-Off
  - VeloGroup-Maxa-FPA-Workshop
---

# Source Systems

## System Inventory

| System | Type | Scope | Status |
|--------|------|-------|--------|
| SAP FI (BPC) | ERP | Financial transactions, GL accounts, customers, products, profit centers, hierarchies | Primary source |
| SAP BPC | Planning module within SAP FI | Budget data loading and extraction | Module — not separate system |
| Microsoft Excel | Manual reporting | Monthly reporting, P&L consolidation, variance analysis | Being replaced |

**Note:** SAP BPC is a module within the same SAP instance — it is NOT a separate source system requiring a separate data connection.

## Star Schema Architecture

The SAP data model follows a classic star schema with one central fact table surrounded by 18 dimension and reference tables organized in four groups.

### Fact Table

| Table | Rows | Description |
|-------|------|-------------|
| FinancialTransactions | 167,136 | Central fact table at the grain of account × customer × product × profit center × version × date |

See [FinancialTransaction](/entities/financial-transaction.md) for entity details.

### Dimension Tables by Group

| Group | Tables | Key Entities |
|-------|--------|--------------|
| GL Accounts | 5 tables (21 accounts, 5 types) | [GLAccount](/entities/gl-account.md) |
| Customers | 5 tables (53 customers, 4 types) | [Customer](/entities/customer.md) |
| Products | 5 tables (35 products, 8 categories) | [Product](/entities/product.md) |
| Profit Centers | 3 tables (37 profit centers) | [ProfitCenter](/entities/profit-center.md) |

## Data Conventions

| # | Convention | Type | Affected Entities |
|---|-----------|------|-------------------|
| 1 | European comma decimal formatting (VARCHAR) | encoding | [FinancialTransaction](/entities/financial-transaction.md) |
| 2 | Dates as BIGINT YYYYMMDD | encoding | [FinancialTransaction](/entities/financial-transaction.md) |
| 3 | Hash (#) = Unassigned dimension member | sentinel_value | [Customer](/entities/customer.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md) |
| 4 | Multilingual text tables (EN/DE filter) | filtering | All dimension entities |
| 5 | Z-prefix for custom namespace objects | structural | Customer types, hierarchies |
| 6 | FPA1/NNN account naming | field_mapping | [GLAccount](/entities/gl-account.md) |
| 7 | Profit center ID encoding | field_mapping | [ProfitCenter](/entities/profit-center.md) |
| 8 | Parent-child adjacency list hierarchies | structural | Hierarchy attributes on entities |
| 9 | Amounts stored as VARCHAR (not DECIMAL) | encoding | [FinancialTransaction](/entities/financial-transaction.md) |
| 10 | Version indicator for Actual vs Budget | structural | [FinancialTransaction](/entities/financial-transaction.md) |

### Key Convention Details

**European Comma Decimal Formatting:** VALUE column [MUST] be parsed using comma as decimal separator. `12734,04` = $12,734.04. Negative values use minus prefix: `-5432,10`.

**Hash (#) as Unassigned:** The # character is a first-class dimension member with master data entries, text descriptions, and hierarchy positions. Removing # transactions would eliminate the entire Operating Expense section from consolidated reporting.

**Multilingual Text Tables:** Text tables store descriptions in multiple languages (EN, DE). Join on ID and filter LANGUAGE='EN' for English descriptions.

**Profit Center ID Encoding:** Format: `{CountryCode}{CompanyCode}_PC{LineCode}{SubID}{SizeCode}`. Example: `US10_PCC1L` = US country, company 10, Cruise (PCC), sub-line 1, Large (L).

## Data Refresh

Monthly batch extract after month-end close (~5 business days after month-end). Marcus runs SAP extraction producing CSV files (one per table, ~2 hours). Row count validation against prior month as quality check.

## Data Quality

SAP enforces referential integrity at the source. Data is generally very clean. Hierarchies were stable during the 2018-2021 data period — no restructuring.
