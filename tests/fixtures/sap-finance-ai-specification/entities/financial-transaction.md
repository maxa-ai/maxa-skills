---
type: entity
title: Financial Transaction
entity_name: FinancialTransaction
entity_slug: financial-transaction
description: Central fact record representing a financial posting at the dimensional grain of account, customer, product, profit center, version, and date — covering both Actual and Budget versions across revenue, COGS, and operating expense account types.
confidence: high
entity_type: transaction
domain: finance
version: "1.0.0"
last_updated: 2026-07-15T15:30:00Z
relationships:
  - GLAccount
  - Customer
  - Product
  - ProfitCenter
  - FiscalCalendar
tags: [finance, fact-table, p-and-l, budget, actual]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

## Relationships

| Type | Target Entity | Description |
|---|---|---|
| N:1 | [GLAccount](/entities/gl-account.md) | Each financial transaction is classified by exactly one GL account that determines its P&L placement (e.g., Gross Revenue, COGS, Payroll). |
| N:1 | [Customer](/entities/customer.md) | Each revenue and COGS transaction references a specific customer. Operating expense transactions use the # (Unassigned) sentinel value. |
| N:1 | [Product](/entities/product.md) | Each revenue and COGS transaction references a specific product. Operating expense transactions use the # (Unassigned) sentinel value. |
| N:1 | [ProfitCenter](/entities/profit-center.md) | Every financial transaction is assigned to a profit center — the primary management reporting dimension. Even operating expenses are assigned to a profit center. |
| N:1 | [FiscalCalendar](/entities/fiscal-calendar.md) | Each transaction links to a fiscal calendar period for reporting period assignment within the calendar-year fiscal structure. |

## Core Attributes

| Attribute | Type | Required | Description | Supported Questions |
|---|---|---|---|---|
| `gl_account_id` | STRING | Yes | GL account identifier classifying this transaction by P&L line (e.g., FPA1/022 for Gross Revenue, FPA1/020 for COGS). Determines the financial statement placement of the posting. | Q001, Q002, Q003, Q010, Q011, Q012, Q013, Q019 |
| `customer_id` | STRING | Yes | Customer identifier. Populated with actual customer ID for revenue and COGS transactions; set to '#' (hash placeholder) for operating expenses not tied to a specific customer. | Q005, Q007, Q016, Q022 |
| `customer_type_id` | STRING | Yes | Customer segment classification code (Z1=Speciality, Z2=Large, Z3=Medium, #=Unassigned). Denormalized from customer master for segment-level transaction analysis. | Q007, Q016 |
| `product_id` | STRING | Yes | Product identifier. Populated with actual product ID for revenue and COGS transactions; set to '#' (hash placeholder) for operating expenses not tied to a specific product. | Q006, Q017, Q020 |
| `product_category_id` | STRING | Yes | Product line classification code (CR=Cruise, MT=Mountain, RC=Racing, YH=Youth, FG=Finished Goods, TM, RB, #). Denormalized from product master for product line transaction analysis. | Q004, Q006, Q014, Q017 |
| `profit_center_id` | STRING | Yes | Profit center identifier for management reporting. Always populated — even operating expenses are assigned to a profit center. | Q004, Q014, Q015 |
| `fiscal_calendar_id` | STRING | Yes | Fiscal calendar period identifier linking this transaction to its reporting period within the fiscal year structure. | Q018, Q019 |
| `version` | STRING | Yes | Distinguishes Actual from Budget transactions. Two values: 'Actual' for realized financial activity, 'Budget' for planned amounts. Same dimensional grain applies to both versions. | Q002, Q003 |
| `posting_date` | DATETIME | Yes | Business date of the financial posting in YYYYMMDD format. The operational date used for period assignment, trend analysis, and fiscal calendar alignment. | Q018, Q019 |
| `value` | NUMERIC | Yes | Monetary amount of the financial posting in USD. All amounts are converted to USD at the SAP posting rate. Represents the financial impact of the transaction on the P&L. | Q001, Q002, Q003, Q004, Q005, Q006, Q010, Q011, Q012, Q013, Q014, Q015, Q020 |
| `account_type_id` | STRING | Yes | GL account type classification (INC=Income, EXP=Expense, AST=Asset, LEQ=Liabilities & Equity, NFIN=Non-Financial). Denormalized from GL account master for account-type-level filtering and analysis. | Q001, Q010 |

## Standard Attributes

| Attribute | Type | Required | Description |
|---|---|---|---|
| `customer_name` | STRING | Yes | Denormalized customer display name for self-containment. Enables direct reporting without joining to customer master data. |
| `product_name` | STRING | Yes | Denormalized product display name for self-containment. Enables direct reporting without joining to product master data. |
| `profit_center_name` | STRING | Yes | Denormalized profit center display name for self-containment. Enables direct reporting without joining to profit center master data. |
| `posting_date_timezone` | STRING | Yes | Timezone offset for the posting date, indicating the timezone in which the posting date was recorded. |
| `currency_code` | STRING | Yes | Reporting currency code for the transaction value. Always 'USD' in VeloGroup's current dataset as SAP handles FX conversion at posting time. |
| `accrual_type` | STRING | Yes | Classification of the accrual entry type (e.g., revenue accrual, expense accrual). Industry-standard field for month-end close audit trail. |
| `adjustment_type` | STRING | Yes | Classification of the adjustment entry type (e.g., depreciation, cost allocation, reclassification). Industry-standard field for month-end close audit trail. |

## Supported Processes

- Chart of Accounts & P&L Hierarchy
- Month-End Close Process
- P&L Consolidation & Reporting
- Budget vs Actual Process
- Fiscal Calendar
- Currency & FX Handling
- Cash Flow Reporting (Indirect Method)
- Data Extraction and Reporting

## Supported Questions

- Q001: What is the Gross Margin percentage?
- Q002: What is the budget vs actual dollar variance for Gross Revenue?
- Q003: What is the budget vs actual percentage variance for a given P&L line item?
- Q004: What is the revenue by product line (Cruise, Mountain, Racing, Youth)?
- Q005: What percentage of total revenue does each individual customer represent?
- Q006: Is the Youth bike line profitable on its own, or is it a loss leader?
- Q007: Which channel is more profitable per unit — Speciality (Z1) or Large (Z2)?
- Q010: What is the COGS ratio (COGS as a percentage of Net Revenue)?
- Q011: What is the total Gross Revenue (top-line sales)?
- Q012: What is the Net Revenue (Gross Revenue minus Sales Deductions)?
- Q013: What is the total COGS?
- Q014: What is the contribution margin by product line?
- Q015: What is each profit center's share of total revenue?
- Q016: What percentage of financial transactions come from each customer segment?
- Q017: What is the transaction share by product line?
- Q018: What is the monthly transaction volume trend year-over-year?
- Q019: What was the monthly revenue trend during 2020 (COVID impact)?
- Q020: What is the e-bike revenue growth rate year-over-year?
- Q022: Which customers rank highest by contribution to gross margin?

## Business Rules Affecting This Entity

### Rule 1: Hierarchy-Driven P&L Arithmetic

**Rule Type:** hierarchy
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md)
**Rule Logic:** Revenue accounts add, cost accounts subtract. The P&L hierarchy implicitly defines the arithmetic — parent node values are computed by summing or subtracting children based on their position in the hierarchy. Gross Margin = Net Revenue children minus COGS children.
**Supporting KPIs:** FKPI-04, FKPI-05, FKPI-08, FKPI-09

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[50:03]
> {"speaker": "Karen Liu", "timestamp": "50:03", "quote": "In our extract, revenue is positive and COGS is positive. When you calculate Gross Margin, you subtract COGS from Net Revenue. The sign isn't embedded in the value — you apply it based on the P&L hierarchy structure. Revenue accounts add, cost accounts subtract."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[50:22]
> {"speaker": "Julien Tremblay", "timestamp": "50:22", "quote": "So the hierarchy implicitly defines the arithmetic. Gross Margin equals the sum of Net Revenue children minus the sum of COGS children."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[50:30]
> {"speaker": "Karen Liu", "timestamp": "50:30", "quote": "Exactly. The hierarchy is both the display structure and the calculation structure."}

### Rule 2: Transactions Post Only to Leaf Accounts

**Rule Type:** hierarchy
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md)
**Rule Logic:** Financial transactions [MUST] only post to leaf-level GL accounts. Parent/rollup nodes (e.g., Gross Margin FPA1/017, Operating Expense FPA1/018) are calculated by summing children — they [MUST NOT] be posted to directly.
**Supporting KPIs:** (none specified)

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[12:01]
> {"speaker": "Karen Liu", "timestamp": "12:01", "quote": "Same principle. Across the entire hierarchy, transactions only post to leaf-level accounts. Everything else is a rollup."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[30:56]
> {"speaker": "Karen Liu", "timestamp": "30:56", "quote": "Leaf accounts are the ones with actual postings. FPA1/022 for Gross Revenue, FPA1/020 for COGS, FPA1/033 for Payroll — those are leaves. FPA1/017 for Gross Margin, FPA1/018 for Operating Expense — those are rollup nodes. Calculated, never posted to."}

### Rule 3: Revenue and COGS at Full Dimensional Grain

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Revenue (Gross Revenue, Sales Deductions) and COGS transactions carry full dimensional detail — Customer, Product, and Profit Center are all populated. This enables product-level and customer-level profitability analysis.
**Supporting KPIs:** FKPI-04, FKPI-05

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[13:05]
> {"speaker": "Karen Liu", "timestamp": "13:05", "quote": "Revenue and COGS: full grain with customer, product, and profit center. OpEx: profit center only with hash for customer and product."}

### Rule 4: Operating Expenses at Profit Center Grain Only

**Rule Type:** enrichment
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** Operating expense transactions (Payroll, Building, Utilities, Travel, etc.) are assigned to a Profit Center only. CUSTOMERID and PRODUCTID are set to # (Unassigned) because these costs are organizational, not customer- or product-specific.
**Supporting KPIs:** FKPI-07

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[12:37]
> {"speaker": "Karen Liu", "timestamp": "12:37", "quote": "Meaning for an operating expense transaction, the CUSTOMERID is set to hash and the PRODUCTID is set to hash. Because a payroll expense isn't tied to a specific customer or a specific product. It's an organizational cost assigned to a profit center."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[12:54]
> {"speaker": "Nadia Khoury", "timestamp": "12:54", "quote": "So the dimensionality varies by account type. Revenue and COGS: full grain with customer, product, and profit center. OpEx: profit center only with hash for customer and product."}

### Rule 5: Hash (#) as Legitimate Dimension Member

**Rule Type:** enrichment
**Affected Entities:** [Customer](/entities/customer.md), [FinancialTransaction](/entities/financial-transaction.md), [Product](/entities/product.md), [ProfitCenter](/entities/profit-center.md)
**Rule Logic:** The # (Unassigned) value is a first-class dimension member that [MUST NOT] be filtered out. It has master data entries, text descriptions, and hierarchy positions. Removing # transactions would eliminate the entire Operating Expense section from consolidated reporting.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[47:19]
> {"speaker": "Karen Liu", "timestamp": "47:19", "quote": "Yes. Don't filter it out. If you remove hash transactions, your entire Operating Expense section disappears. It's meaningful data."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[13:10]
> {"speaker": "Marcus Weber", "timestamp": "13:10", "quote": "And just to be clear — hash isn't a null. It's a real dimension member. It has an entry in the customer master, an entry in the product master. It has text, it has a hierarchy position. Don't filter it out."}

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[21:36]
> {"speaker": "Marcus Weber", "timestamp": "21:36", "quote": "If a financial transaction doesn't have a customer assigned, the customer foreign key will just be the hash symbol. You'll see this across all dimensions. And this is important, you can't just filter those out because some of those unassigned records are perfectly legitimate financial postings."}

### Rule 7: Budget Validation Must Tie to Approved Totals

**Rule Type:** reconciliation
**Affected Entities:** [FinancialTransaction](/entities/financial-transaction.md)
**Rule Logic:** After budget data is loaded into SAP BPC, the loaded totals [MUST] match Karen's approved budget totals to the penny before Marcus signs off. This is a mandatory reconciliation gate that [MUST] be satisfied before budget data is considered valid for variance analysis.
**Supporting KPIs:** FKPI-10, FKPI-11

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[37:48]
> {"speaker": "Marcus Weber", "timestamp": "37:48", "quote": "I run the import jobs, then we validate. The loaded budget totals have to match Karen's approved totals to the penny before I sign off."}

## Data Conventions for This Entity

- **European Comma Decimal Formatting**: VALUE column [MUST] be parsed using comma as decimal separator. '12734,04' = $12,734.04. No thousands separator. Negative values use minus prefix: '-5432,10'.
- **Dates as BIGINT in YYYYMMDD Format**: Date field [MUST] be parsed from BIGINT integer in YYYYMMDD format. 20210101 = January 1, 2021. No separators, no time component.
- **Amounts Stored as VARCHAR**: Financial amounts are stored as VARCHAR type, not DECIMAL. Transformation [MUST] include VARCHAR-to-numeric conversion with comma-to-period swap.
- **Version Indicator for Actual vs Budget**: Each transaction carries a version indicator distinguishing Actual from Budget entries. Both versions share the same dimensional structure and grain.
- **BPC CSV Export Format**: BPC reports export full dataset to CSV. One file per table. The VARCHAR formatting with European commas originates from this export process.
- **Monthly CSV Import and Pivot Table Rebuild**: FP&A team imports monthly CSV extracts into Excel and manually rebuilds pivot tables each month. Source data shape changes prevent simple refresh.
