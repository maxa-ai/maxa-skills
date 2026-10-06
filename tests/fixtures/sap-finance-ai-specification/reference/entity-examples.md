---
type: entity_examples
title: Entity Examples
description: Concrete ID patterns, enumerations, and example records for all 13 ERE-confirmed VeloGroup entities, scoped from SAP FI data for data discovery.
confidence: high
timestamp: "2026-10-05T20:33:03Z"
tags: [entity-examples, discovery, reference]
sources:
  - VeloGroup-Maxa-FPA-Workshop.md
  - VeloGroup-Maxa-Project-Kick-Off.md
---

# Entity Examples

Concrete examples for each of the 13 entities confirmed in the data model. See the corresponding entity file in `/entities/` for full attribute and relationship definitions.

## Account Type

See [AccountType](/entities/account-type.md). Complete enumeration (5 values).

| ACCOUNTTYPEID | Description |
|---|---|
| INC | Income/Revenue accounts |
| EXP | Expense accounts (COGS, OpEx) |
| AST | Asset accounts |
| LEQ | Liabilities and Equity accounts |
| NFIN | Statistical accounts — headcount, square footage, capacity metrics; non-monetary |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[45]
> {"speaker": "Marcus Weber", "timestamp": "11:10", "quote": "Correct, five account types. Income, abbreviated INC. Expense, EXP. Assets, AST. Liabilities and Equity, LEQ. And then there's a Non-financial Income category, NFIN, which is a bit of a miscellaneous bucket for certain non-operating items."}

## Customer

See [Customer](/entities/customer.md). ID patterns: `LACU_S\d{2}`, `\d{7}`, `#` (unassigned).

| Example | CUSTOMERID | Segment | Notes |
|---|---|---|---|
| TechCycle | LACU_S02 | Z1 (Speciality) | Largest Speciality customer by transaction volume |
| Skymart Corp | NOT_MENTIONED | Z2 (Large) | One of the largest Large-tier accounts |
| Suburban Cycle | 1000153 | Z3 (Medium) | Most loyal Medium-tier account |
| Unassigned | # | # (Unassigned) | Legitimate dimension member for OpEx transactions with no customer |

**Other named customers by segment:**

| Segment | Named Customers |
|---|---|
| Speciality (Z1) | TechCycle, The Cycle Factor, Carefree Cycles, KeepCycling, YourCycleShop |
| Large (Z2) | Skymart Corp, Bigmart, CostClub, Toys4U, Viadox, Quotex, Bluestar Corp, Dexon, Interlude Inc, Veracity |
| Medium (Z3) | Suburban Cycle, G&M Bicycle, XYZ Cycles |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[188]
> {"speaker": "Karen Liu", "timestamp": "31:24", "quote": "Right. Our largest Speciality customer by transaction volume is TechCycle, LACU_S02. On the Large side, Skymart Corp is one of the biggest. And in Medium, Suburban Cycle — customer ID 1000153 — is our most loyal account even though they're small."}

**Known Gap:** CUSTOMERID values for Large-tier customers are not stated in evidence sources.

## Customer Hierarchy Node

See [CustomerHierarchyNode](/entities/customer-hierarchy-node.md).

| Field | Value |
|---|---|
| Table | CustomersHierarchy |
| Row Count | 56 |
| Grouping Dimensions | By customer type and geography |
| Specific Node IDs | NOT_MENTIONED |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[139]
> {"speaker": "Marcus Weber", "timestamp": "23:20", "quote": "CustomerTypeTexts for the type descriptions, yes. And CustomersHierarchy with 56 rows for customer groupings — grouping customers by type and geography."}

**Known Gap:** Specific hierarchy node IDs and parent-child relationships are not stated in any transcript. The 56 rows suggest a multi-level hierarchy (more nodes than the 53 customers, implying intermediate grouping nodes).

## Customer Segment

See [CustomerSegment](/entities/customer-segment.md). Complete enumeration (4 values).

| CUSTOMERTYPEID | Name | Transaction Share | Description |
|---|---|---|---|
| Z1 | Speciality | ~66% | Independent bike shops, premium dealers, enthusiast retailers |
| Z2 | Large | ~31% | Big box retailers, sporting goods chains |
| Z3 | Medium | <1% | Mid-size regional chains |
| # | Unassigned | ~2.5% | Non-customer-specific transactions (operating expenses) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[134]
> {"speaker": "Marcus Weber", "timestamp": "22:30", "quote": "Also five tables. The Customer master has 53 rows. Each customer has CUSTOMERID, CUSTOMERTYPEID, COUNTRY, and LANGUAGE. CustomerType has 4 rows — Z1 for Speciality, Z2 for Large, Z3 for Medium, and # for Unassigned."}

## Division

See [Division](/entities/division.md). Complete enumeration (4 divisions).

| Division | SAP Code | Profit Centers | Description |
|---|---|---|---|
| US Division | US10 | 28 | Primary operating division; profit centers by product line x channel |
| Global | ZG | 3 | Corporate overhead allocated to product lines |
| Logistics | Z_LOG | 4 | Warehouse and distribution costs |
| Year-end | YB | 1 | Holding center for year-end adjustments (YB_PC01) |

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[22]
> {"speaker": "Marcus Weber", "timestamp": "05:19", "quote": "Thirty-seven active profit centers. Twenty-eight under the US Division, three under what we call the Global group, that's ZG in SAP, and then four under Logistics, which is Z_LOG."}

## Financial Transaction

See [FinancialTransaction](/entities/financial-transaction.md). No natural business ID — surrogate key; grain is account x customer x product x profit_center x version x date.

### Example 1: Revenue Transaction (Actual)

| Field | Value |
|---|---|
| ACCOUNTID | FPA1/022 (Gross Revenue) |
| CUSTOMERID | LACU_S02 (TechCycle) |
| PRODUCTID | M550 |
| PROFITCENTERID | US10_PCM2S (inferred from Mountain + Speciality) |
| VERSION | Actual |
| VALUE | VARCHAR with European comma (e.g., "49990,00") |
| DATE | BIGINT YYYYMMDD (e.g., 20200315) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[182]
> {"speaker": "Karen Liu", "timestamp": "30:23", "quote": "One row in the fact table, assuming they're posted to the same GL account and profit center. The value would be the aggregated amount."}

### Example 2: Operating Expense Transaction (Actual)

| Field | Value |
|---|---|
| ACCOUNTID | FPA1/033 (Payroll) |
| CUSTOMERID | # (Unassigned — OpEx has no customer) |
| PRODUCTID | # (Unassigned — OpEx has no product) |
| PROFITCENTERID | (specific profit center) |
| VERSION | Actual |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[75]
> {"speaker": "Karen Liu", "timestamp": "12:37", "quote": "Meaning for an operating expense transaction, the CUSTOMERID is set to hash and the PRODUCTID is set to hash. Because a payroll expense isn't tied to a specific customer or a specific product. It's an organizational cost assigned to a profit center."}

### Example 3: Budget Transaction

Same grain as Actual; Budget has ~102,380 records vs ~64,756 for Actual.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[101]
> {"speaker": "Karen Liu", "timestamp": "16:54", "quote": "102,380 budget transactions versus 64,756 actual. The split is about 61% budget, 39% actual. Budget has more rows because we forecast at a very granular level. My team builds the budget at the individual product-customer-profit center level for every month. That creates a lot of line items."}

**Known Gap:** Actual raw CSV row examples with raw VARCHAR values and BIGINT dates were not provided — examples above are reconstructed from transcript descriptions.

## GL Account

See [GLAccount](/entities/gl-account.md). ID patterns: `FPA1/\d{2,3}`, `CF_[A-Z]+`.

### Leaf Accounts (Receive Postings)

| ACCOUNTID | Name | Account Type | Hierarchy Parent | Transactions |
|---|---|---|---|---|
| FPA1/022 | Gross Revenue | INC | FPA1/021 (Net Revenue) | ~30,724 |
| FPA1/023 | Sales Deductions | INC | FPA1/021 (Net Revenue) | ~8,835 |
| FPA1/020 | COGS | EXP | FPA1/017 (Gross Margin) | ~126,390 |
| FPA1/028 | Periodic (Building) | EXP | FPA1/024 (Building Expense) | — |
| FPA1/029 | Utilities | EXP | FPA1/024 (Building Expense) | — |
| FPA1/032 | Office | EXP | FPA1/026 (Employee Expense) | — |
| FPA1/033 | Payroll | EXP | FPA1/026 (Employee Expense) | — |
| FPA1/034 | Travel | EXP | FPA1/026 (Employee Expense) | — |
| FPA1/035 | Employee Other | EXP | FPA1/026 (Employee Expense) | — |

### Rollup Nodes (Calculated, Never Posted To)

| ACCOUNTID | Name | Children |
|---|---|---|
| FPA1/08 | Net Income | FPA1/09 (EBIT) |
| FPA1/09 | EBIT | FPA1/016 (Operating Income) |
| FPA1/016 | Operating Income | FPA1/017, FPA1/018 |
| FPA1/017 | Gross Margin | FPA1/021, FPA1/020 |
| FPA1/021 | Net Revenue | FPA1/022, FPA1/023 |
| FPA1/018 | Operating Expense | FPA1/024, FPA1/026, FPA1/027 |
| FPA1/024 | Building Expense | FPA1/028, FPA1/029 |
| FPA1/026 | Employee Expense | FPA1/032-035 |

### Cash Flow Accounts (outside main P&L hierarchy)

| ACCOUNTID | Name |
|---|---|
| CF_I | Cash Flow Statement (Indirect) |
| CF_CFO | Cash Flow from Operating Activities |
| CF_D | Depreciation |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[56]
> {"speaker": "Karen Liu", "timestamp": "09:57", "quote": "COGS is the big one. FPA1/020. About 126,390 transactions."}

**Known Gap:** Cash flow and balance sheet account hierarchy detail is largely undocumented — see [Known Gap G002](/known-gaps.md).

## GL Account Hierarchy Node

See [GLAccountHierarchyNode](/entities/gl-account-hierarchy-node.md). Parent-child adjacency list, 21 rows. Level 1 is root (Net Income); higher numbers are more granular.

| HIERARCHYID | DESCRIPTION | LEVEL | Type |
|---|---|---|---|
| FPA1/08 | Net Income | 1 (Root) | Rollup |
| FPA1/09 | EBIT | 2 | Rollup |
| FPA1/016 | Operating Income | 3 | Rollup |
| FPA1/017 | Gross Margin | 4 | Rollup (children: Net Revenue, COGS) |
| FPA1/018 | Operating Expense | 4 | Rollup (children: Building, Employee, Other) |
| FPA1/021 | Net Revenue | — | Rollup (children: Gross Revenue, Sales Deductions) |
| FPA1/022 | Gross Revenue | — | Leaf (~30,724 txn) |
| FPA1/020 | COGS | — | Leaf (~126,390 txn) |
| FPA1/023 | Sales Deductions | — | Leaf (~8,835 txn) |
| FPA1/033 | Payroll | — | Leaf |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[132]
> {"speaker": "Marcus Weber", "timestamp": "22:10", "quote": "Parent-child adjacency list. Each row has a HIERARCHYID, a DESCRIPTION, and a LEVEL field. Level 1 is the root — that's Net Income. Level 2 is EBIT. Level 3 is Operating Income. Higher numbers are more granular."}

## Product

See [Product](/entities/product.md). ID patterns: `C\d{3}`, `M\d{3}`, `R\d{3}`, `Y\d{3}`, `E\d{2,3}`, `CM-FL-V\d{2}`.

| PRODUCTID | Category | Price | Notes |
|---|---|---|---|
| C900 | CR (Cruise) | $799 | Standard Cruise bike |
| M550 | MT (Mountain) | $4,999 | Crown jewel; full carbon, full suspension |
| E101 | CR (Cruise) | $1,144 | Surprise hit; highest-volume Cruise product |
| Y120 | YH (Youth) | $179 | Entry-level, lowest price point |
| CM-FL-V00 | FG (Finished Goods) | $7,900 | Internal asset tracked as product for cost allocation |
| R100 | RC (Racing) | $1,250 | — |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[32]
> {"speaker": "Stefan Richter", "timestamp": "05:53", "quote": "The M550 is our crown jewel. Full carbon, full suspension. It goes head-to-head with Trek's Fuel EX and Specialized's Stumpjumper at that price point. We hold our own."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[38]
> {"speaker": "Marcus Weber", "timestamp": "06:47", "quote": "Yeah, I know. It's an internal asset tracked as a product in SAP for cost allocation purposes. It's a handful of transactions. Don't lose sleep over it."}

**Known Gap:** TYPECODE and CURRENCY field values are not stated in evidence sources.

## Product Category

See [ProductCategory](/entities/product-category.md). Complete enumeration (8 values).

| PRODUCTCATEGORYID | Product Line | Transaction Share |
|---|---|---|
| CR | Cruise | ~30% |
| MT | Mountain | ~30% |
| RC | Racing | ~29% |
| YH | Youth | ~9.5% |
| FG | Finished Goods | ~1.5% (combined) |
| TM | Trade Materials | Minimal |
| RB | Raw Materials | Minimal |
| # | Unassigned | Minimal |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[143]
> {"speaker": "Marcus Weber", "timestamp": "23:52", "quote": "ProductCategories table has 8 rows. CR for Cruise, MT for Mountain, RC for Racing, YH for Youth, FG for Finished Goods, TM for Trade Materials, RB for Raw Materials, and # for Unassigned."}

## Product Hierarchy Node

See [ProductHierarchyNode](/entities/product-hierarchy-node.md). 43-row hierarchy grouping products under Z-prefixed product line nodes.

| Node ID | Products Under |
|---|---|
| ZCRUISE | C900, C950, C990, E101, E102, E103 |
| ZMTN | M500, M525, M550 |
| ZRACING | R100, R200, R300 |
| ZYOUTH | Y120, Y200, Y240 |
| ZFGOODS | Includes internal assets like CM-FL-V00 forklift |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[146]
> {"speaker": "Marcus Weber", "timestamp": "24:19", "quote": "Then ProductTexts at 41 rows — again multilingual — ProductCategoryTexts at 8 rows, and ProductHierarchy at 43 rows. The product hierarchy groups products under nodes called ZCRUISE, ZMTN, ZRACING, ZYOUTH, and ZFGOODS."}

## Profit Center

See [ProfitCenter](/entities/profit-center.md). ID patterns: `US10_PC[CMRY]\d[LS]`, `ZG_PC[CMR]\d`, `Z_LOG_PC\d+`, `YB_PC\d+`.

### US Division Profit Centers (28 total)

Pattern: Cruise=PCC (6 PCs), Mountain=PCM (6 PCs), Racing=PCR (6 PCs), Youth=PCY (4 PCs, fewer due to smaller product line). Suffix L = Large channel, S = Speciality channel.

| PROFITCENTERID | Product Line | Channel |
|---|---|---|
| US10_PCC1L | Cruise | Large |
| US10_PCC1S | Cruise | Speciality |
| US10_PCM1L | Mountain | Large |
| US10_PCM2S | Mountain | Speciality |
| US10_PCR1L | Racing | Large |
| US10_PCY1L | Youth | Large |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[155]
> {"speaker": "Marcus Weber", "timestamp": "25:59", "quote": "Sure. At the top level is US Division, which contains 28 profit centers. Under US Division, it branches by product line. Cruise has six profit centers: PCC1L and PCC1S, PCC2L and PCC2S, PCC3L and PCC3S. The L suffix means Large channel, S means Speciality — or Small, in the system's terminology."}

### Global Profit Centers (3 total)

| PROFITCENTERID | Product Line |
|---|---|
| ZG_PCC1 | Cruise |
| ZG_PCM1 | Mountain |
| ZG_PCR1 | Racing |

### Logistics Profit Centers (4 total)

Z_LOG_PC7, Z_LOG_PC11, Z_LOG_PC12, Z_LOG_PC13 — warehouse and distribution costs.

### Other

YB_PC01 — year-end adjustments (low volume).

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[160]
> {"speaker": "Marcus Weber", "timestamp": "27:13", "quote": "Logistics — Z_LOG_PC7, Z_LOG_PC11, Z_LOG_PC12, Z_LOG_PC13. Those handle warehouse and distribution costs. And there's one special one, YB_PC01, which is a holding center for year-end adjustments. Low volume."}

**Known Gap:** ProfitCenterTexts descriptive names for Z_LOG and YB profit centers not stated.

## Profit Center Hierarchy Node

See [ProfitCenterHierarchyNode](/entities/profit-center-hierarchy-node.md). 60-row hierarchy organizing 37 profit centers under Division -> Product Line -> Channel.

```
Root
├── US Division (28 profit centers)
│   ├── Cruise (6 PCs)
│   ├── Mountain (6 PCs)
│   ├── Racing (6 PCs)
│   └── Youth (4 PCs)
├── Global/ZG (3 PCs)
├── Logistics/Z_LOG (4 PCs)
└── Year-end/YB (1 PC)
```

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[156]
> {"speaker": "Marcus Weber", "timestamp": "26:23", "quote": "Mountain follows the same pattern — PCM1L, PCM1S, PCM2L, PCM2S, PCM3L, PCM3S. Six profit centers. Racing: PCR1L, PCR1S, PCR2L, PCR2S, PCR3L, PCR3S. Also six. Youth is smaller — only four profit centers: PCY1L, PCY1S, PCY3L, PCY3S."}

**Known Gap:** Actual HIERARCHYID values for the hierarchy nodes are not stated — transcripts use descriptive names only (US Division, Cruise, Mountain, etc.), not system IDs.
