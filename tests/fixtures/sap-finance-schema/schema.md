# VeloGroup SAP Source Schema (DuckDB)

> Derived from the same dataset as the test bundle. See [NOTICE.md](../sap-finance-bundle/NOTICE.md) for provenance and disclaimer.

## Fact Table

### FinancialTransactions (167,136 rows)

| Column | Type | Sample |
|--------|------|--------|
| TRANSACTIONID | BIGINT | 5 |
| ACCOUNTID | VARCHAR | `FPA1/022` |
| ACCOUNTTYPEID | VARCHAR | `INC` or `EXP` |
| CUSTOMERID | VARCHAR | `LACU_S02` or `#` |
| CUSTOMERTYPEID | VARCHAR | `Z1` or `#` |
| PRODUCTID | VARCHAR | `M550` or `#` |
| PRODUCTCATEGORYID | VARCHAR | `MT` or `#` |
| PROFITCENTERID | VARCHAR | `US10_PCC1L` |
| VERSION | VARCHAR | `Actual` or `Budget` |
| DATE | BIGINT | `20181201` (YYYYMMDD as integer) |
| VALUE | VARCHAR | `12342,15` (European comma-decimal, not a number type) |

Sample rows:
```
5, FPA1/022, INC, #, #, #, #, US10_PCC3L, Actual, 20181201, 12342,15
8, FPA1/020, EXP, LACU_S02, Z1, C900, CR, US10_PCC1S, Actual, 20180401, 1936,02
12, FPA1/033, EXP, #, #, #, #, US10_PCM1L, Budget, 20190301, 0
```

## Dimension Tables

### "GL Accounts" (21 rows) — NOTE: table name has a space, requires quoting

| Column | Type |
|--------|------|
| ACCOUNTID | VARCHAR |
| ACCOUNTTYPEID | VARCHAR |
| LANGUAGE | VARCHAR |
| CREATEDBY | BIGINT |
| CREATEDAT | BIGINT |
| CHANGEDBY | BIGINT |
| CHANGEDAT | BIGINT |

### GLAccountsTexts (21 rows)

| Column | Type | Sample |
|--------|------|--------|
| ACCOUNTID | VARCHAR | `FPA1/022` |
| LANGUAGE | VARCHAR | `EN` |
| SHORT_DESCR | VARCHAR | (often NULL) |
| MEDIUM_DESCR | VARCHAR | `Gross Revenue` |
| LONG_DESCR | VARCHAR | (often NULL) |

### GLAccountType (5 rows)
INC, EXP, AST, LEQ, NFIN

### GLAccountTypeTexts (5 rows)
ACCOUNTTYPEID, LANGUAGE, SHORT_DESCR, MEDIUM_DESCR, LONG_DESCR

### GLAccountsHierarchy (21 rows)

| Column | Type | Sample |
|--------|------|--------|
| HIERARCHYID | VARCHAR | `FPA1/022` |
| DESCRIPTION | VARCHAR | `Gross Revenue` |
| LEVEL | VARCHAR | `FPA1/021` (= parent HIERARCHYID) |

Parent-pointer pattern: LEVEL column contains the parent's HIERARCHYID. Root has LEVEL=`<root>`.

### Customer (53 rows)

| Column | Type | Sample |
|--------|------|--------|
| CUSTOMERID | VARCHAR | `LACU_S02` |
| CUSTOMERTYPEID | VARCHAR | `Z1` |
| COUNTRY | VARCHAR | `US` |
| LANGUAGE | VARCHAR | `EN` |
| CREATEDBY, CREATEDAT, CHANGEDBY, CHANGEDAT | BIGINT | audit columns |

### CustomerTexts (56 rows — more than 53 due to multilingual EN+DE entries)

| Column | Type | Sample |
|--------|------|--------|
| CUSTOMERID | VARCHAR | `LACU_S02` |
| LANGUAGE | VARCHAR | `EN` |
| MEDIUM_DESCR | VARCHAR | `TechCycle` |

### CustomerType (4 rows): Z1, Z2, Z3, #
### CustomerTypeTexts (4 rows)
### CustomersHierarchy (56 rows)

### Products (35 rows)

| Column | Type | Sample |
|--------|------|--------|
| PRODUCTID | VARCHAR | `M550` |
| TYPECODE | VARCHAR | `PR` |
| PRODUCTCATEGORYID | VARCHAR | `MT` |
| CURRENCY | VARCHAR | `USD` |
| PRICE | DOUBLE | `4999.0` |
| LANGUAGE, CREATEDBY, CREATEDAT, etc. | various | |

### ProductTexts (41 rows — multilingual)
PRODUCTID, LANGUAGE, SHORT_DESCR, MEDIUM_DESCR, LONG_DESCR

### ProductCategories (8 rows) — NOTE: PK column is PRODCATEGORYID (not PRODUCTCATEGORYID)
PRODCATEGORYID, LANGUAGE, CREATEDBY, CREATEDAT, CHANGEDBY, CHANGEDAT

### ProductCategoryTexts (8 rows)
PRODCATEGORYID, LANGUAGE, SHORT_DESCR, MEDIUM_DESCR, LONG_DESCR

### ProductHierarchy (43 rows)
HIERARCHYID, DESCRIPTION, LEVEL

### ProfitCenter (37 rows)

| Column | Type | Sample |
|--------|------|--------|
| PROFITCENTERID | VARCHAR | `US10_PCC1L` |
| LANGUAGE | VARCHAR | `EN` |
| CREATEDBY, CREATEDAT, CHANGEDBY, CHANGEDAT | BIGINT | |

### ProfitCenterTexts (37 rows)
PROFITCENTERID, LANGUAGE, SHORT_DESCR, MEDIUM_DESCR (`Cruise Cycles`), LONG_DESCR (`Cruise Cycles - Large`)

### ProfitCenterHierarchy (60 rows)
HIERARCHYID, DESCRIPTION, LEVEL
