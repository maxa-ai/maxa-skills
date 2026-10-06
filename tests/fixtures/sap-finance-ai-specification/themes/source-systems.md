---
type: business_domain
title: Source Systems
description: SAP FI (BPC) star schema landscape with 1 fact table and 18 dimension tables, plus Excel-based reporting currently used for P&L consolidation and variance analysis.
confidence: high
timestamp: "2026-10-05T20:02:35Z"
tags: [source-systems, sap, data-conventions]
sources:
  - VeloGroup-Maxa-Project-Kick-Off.md
  - VeloGroup-Maxa-FPA-Workshop.md
---

# Source Systems

## System 1: SAP FI (BPC)

| Field | Value |
|---|---|
| **Source System ID** | sap_fi_bpc |
| **System Type** | ERP |
| **Divisions Using** | US Division, Global (ZG), Logistics (Z_LOG) — company-wide |
| **Server Timezone** | NOT_MENTIONED |
| **Data Scope** | All financial transactions (actual + budget), all dimension/master data |
| **Data Refresh** | Monthly batch extract after month-end close (~day 4); CSVs produced (1 per table) |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[7]
> {"speaker": "Marcus Weber", "timestamp": "01:55", "quote": "And I'm Marcus Weber. I run the SAP landscape and IT infrastructure here at VeloGroup. Twelve years with the company, so I've been around since before we were even on SAP, which tells you something. I manage the whole SAP environment, integrations, data architecture, infrastructure. I'm basically the guy who knows where all the data lives and, unfortunately, where it tends to get stuck."}

### Star Schema Architecture

| Component | Table Count | Description |
|---|---|---|
| Fact table | 1 | FinancialTransactions (167,136 rows: 64,756 actual + 102,380 budget) |
| GL Accounts group | 5 | GLAccounts (21), GLAccountType (5), GLAccountTypeTexts, GLAccountsTexts, GLAccountsHierarchy (21) |
| Customers group | 5 | Customers (53), CustomerType (4), CustomerTypeTexts, CustomerTexts (56), CustomersHierarchy (56) |
| Products group | 5 | Products (35), ProductCategories (8), ProductCategoryTexts (8), ProductTexts (41), ProductHierarchy (43) |
| Profit Centers group | 3 | ProfitCenter (37), ProfitCenterTexts, ProfitCenterHierarchy (60) |
| **Total** | **19** | 1 fact + 18 dimension/reference tables |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[125]
> {"speaker": "Marcus Weber", "timestamp": "20:39", "quote": "All right, I've been waiting for this. So the SAP data model follows a classic star schema architecture. We have one central fact table — FinancialTransactions — surrounded by 18 dimension and reference tables organized in four groups."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[127]
> {"speaker": "Marcus Weber", "timestamp": "21:00", "quote": "167,136. That's Actual plus Budget combined — 64,756 plus 102,380."}

### Data Conventions

#### Convention 1: European Comma Decimal Formatting

The VALUE column [MUST] be parsed as text with a comma decimal separator. Applies to all financial amounts.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[116]
> {"speaker": "Marcus Weber", "timestamp": "19:23", "quote": "Okay. The VALUE column in the FinancialTransactions table is stored as VARCHAR, not DECIMAL. And it uses European comma formatting. So \"12734,04\" means twelve thousand seven hundred thirty-four dollars and four cents. The comma is the decimal separator."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[120]
> {"speaker": "Marcus Weber", "timestamp": "20:01", "quote": "Minus sign prefix. \"-5432,10\" is negative five thousand four hundred thirty-two and ten cents."}

#### Convention 2: Dates as BIGINT YYYYMMDD

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[166]
> {"speaker": "Marcus Weber", "timestamp": "28:16", "quote": "Yes. The date field in FinancialTransactions is a BIGINT in YYYYMMDD format. January 1, 2021 is stored as 20210101. No separators, no time component. Just an eight-digit integer."}

#### Convention 3: Hash (#) as Unassigned

The hash character ('#') [MUST NOT] be filtered out of dimension foreign keys — it is a real dimension member with its own master-table entry, not a null.

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[89]
> {"speaker": "Marcus Weber", "timestamp": "21:36", "quote": "Ah, the infamous hash. So in SAP, when a dimension value is unassigned, it's represented by the hash character, the number sign. If a financial transaction doesn't have a customer assigned, the customer foreign key will just be the hash symbol. You'll see this across all dimensions. And this is important, you can't just filter those out because some of those unassigned records are perfectly legitimate financial postings. Things like overhead allocations, intercompany entries, they may not have a customer or product dimension, but the financial values are real and need to appear in the consolidated view."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[78]
> {"speaker": "Marcus Weber", "timestamp": "13:10", "quote": "And just to be clear — hash isn't a null. It's a real dimension member. It has an entry in the customer master, an entry in the product master. It has text, it has a hierarchy position. Don't filter it out."}

#### Convention 4: Multilingual Text Tables

Text tables [MUST] be filtered on LANGUAGE='EN' when retrieving English descriptions.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[137]
> {"speaker": "Marcus Weber", "timestamp": "22:57", "quote": "Multilingual entries. Some customers have both English and German text records. It's an SAP convention — the text tables have a LANGUAGE column, so you can store labels in multiple languages. Most of our customers are English-only, but a few have German entries too. When you join, filter on LANGUAGE equals EN for English."}

#### Convention 5: Z/Y Custom Namespace

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[148]
> {"speaker": "Marcus Weber", "timestamp": "24:39", "quote": "SAP custom namespace. Z means customer-defined, not SAP standard. All our custom hierarchies, custom types — they're all Z-prefixed."}

#### Convention 6: FPA1 Account ID Prefix

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[278]
> {"speaker": "Marcus Weber", "timestamp": "49:10", "quote": "A few more conventions. Account naming — FPA1 slash three digits. The FPA1 prefix stands for Financial Planning and Analysis module 1. It's a BPC convention. The three digits are the account number within that module."}

#### Convention 7: Profit Center ID Encoding

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[161]
> {"speaker": "Marcus Weber", "timestamp": "27:31", "quote": "The naming convention encodes the structure. US10_PCC1L: US is the country code, 10 is the company code, PCC is Cruise, 1 is the sub-line, L is Large. US10_PCM2S: US, company 10, Mountain, sub-line 2, Speciality."}

#### Convention 8: Hierarchy Level Numbering (Root = 1)

GL account hierarchy levels [MUST] be interpreted with Level 1 as the root (Net Income); higher level numbers represent more granular nodes.

#### Convention 9: Account Type Codes

Five account types classify every GL account: INC (Income/Revenue), EXP (Expense), AST (Assets), LEQ (Liabilities & Equity), NFIN (Non-financial — statistical accounts for headcount, square footage, capacity).

#### Convention 10: Product Category Codes

Eight categories: CR (Cruise), MT (Mountain), RC (Racing), YH (Youth), FG (Finished Goods), TM (Trade Materials), RB (Raw Materials), # (Unassigned).

## System 2: Excel (FP&A Reporting)

| Field | Value |
|---|---|
| **Source System ID** | excel_fpa |
| **System Type** | Excel |
| **Divisions Using** | All — company-wide FP&A |
| **Purpose** | Current-state P&L consolidation, variance analysis, budget modeling; being replaced by this project |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[19]
> {"speaker": "Karen Liu", "timestamp": "04:38", "quote": "Yes, so the month-end close is probably the biggest pain point for my team. The consolidation and reporting piece specifically. We're pulling data out of SAP, dumping it into Excel, and then manually consolidating across all our profit centers. Reconciling, checking for anomalies, formatting. That process alone takes about three days just for the P&L consolidation. Three days, every single month. And it's not like we have spare capacity, those are three days my analysts could be spending on actual strategic analysis instead of copy-pasting formulas."}

These conventions are inlined within every affected entity file's "Data Conventions for This Entity" section — see [FinancialTransaction](/entities/financial-transaction.md), [GLAccount](/entities/gl-account.md), [Customer](/entities/customer.md), [Product](/entities/product.md), and [ProfitCenter](/entities/profit-center.md).
