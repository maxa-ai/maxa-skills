---
type: financial_processes
title: Financial Processes
description: Financial operations including chart of accounts structure, P&L hierarchy, month-end close, P&L consolidation, budget vs actual, fiscal calendar, currency handling, and cash flow reporting for VeloGroup.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [financial-processes, chart-of-accounts, p-and-l, budget, fiscal-calendar, currency, cash-flow]
sources:
  - VeloGroup-Maxa-FPA-Workshop
  - VeloGroup-Maxa-Project-Kick-Off
---

# Financial Processes

## Chart of Accounts & P&L Hierarchy

VeloGroup has 21 GL accounts across 5 account types (INC, EXP, AST, LEQ, NFIN), organized in a parent-child P&L hierarchy. For full details, see [GLAccount](/entities/gl-account.md).

### P&L Hierarchy Structure

```
Level 1: Net Income (FPA1/08)
  └── Level 2: EBIT (FPA1/09)
        └── Level 3: Operating Income (FPA1/016)
              ├── Level 4: Gross Margin (FPA1/017)
              │     ├── Net Revenue (FPA1/021)
              │     │     ├── Gross Revenue (FPA1/022) ← LEAF
              │     │     └── Sales Deductions (FPA1/023) ← LEAF
              │     └── COGS (FPA1/020) ← LEAF
              └── Level 4: Operating Expense (FPA1/018)
                    ├── Building Expense (FPA1/024)
                    │     ├── Periodic (FPA1/028) ← LEAF
                    │     └── Utilities (FPA1/029) ← LEAF
                    ├── Employee Expense (FPA1/026)
                    │     ├── Office (FPA1/032) ← LEAF
                    │     ├── Payroll (FPA1/033) ← LEAF
                    │     ├── Travel (FPA1/034) ← LEAF
                    │     └── Employee Other (FPA1/035) ← LEAF
                    └── Other Operating Expense (FPA1/027) ← LEAF
```

**Cash Flow Accounts (outside P&L hierarchy):** CF_I, CF_CFO, CF_D.

### Key Hierarchy Rules

- **Transactions post only to leaf accounts.** Parent/rollup nodes are calculated by summing children.
- **The hierarchy defines the arithmetic.** Revenue accounts add, cost accounts subtract. Gross Margin = Net Revenue - COGS.
- **Dimensional grain varies by account type.** Revenue and COGS carry full grain (customer × product × profit center). Operating expenses carry profit center only.

### COGS Dominance

COGS (FPA1/020) accounts for ~75% of all transaction volume (~126,390 of ~167,136 total transactions) because COGS is tracked at the full product-customer-profit center grain.

## P&L Consolidation & Reporting

37 profit centers consolidated across individual profit center, product line, channel, division, and company-wide levels. Currently ~3 days of manual work; Priya builds ≥6 hours/month of P&L reports. See [ProfitCenter](/entities/profit-center.md) for the profit center structure.

## Budget vs Actual Process

Annual budget cycle: September through mid-November (~8 weeks), bottom-up at product-customer-profit-center grain. Both Actual and Budget versions share the same dimensional structure in [FinancialTransaction](/entities/financial-transaction.md). Budget validation [MUST] tie to approved totals to the penny.

## Fiscal Calendar

Calendar year (January 1 – December 31), 12 monthly periods, no exotic calendar structures. See [FiscalCalendar](/entities/fiscal-calendar.md) for full details.

| Field | Value |
|-------|-------|
| Fiscal year | Calendar year (Jan 1 – Dec 31) |
| Period type | Monthly (12 periods) |
| Data range | April 2018 – January 2021 |
| Reporting currency | USD |

## Currency & FX Handling

Primary currency is USD. All products priced in USD. Canadian customers transact in CAD, but all amounts are converted to USD at the SAP posting rate. No multi-currency work needed on the analytics side.

## Cash Flow Reporting (Indirect Method)

Three CF accounts exist (CF_I, CF_CFO, CF_D) outside the P&L hierarchy. Medium priority (UC-05). May represent a simplified or partial cash flow view.

## Financial Process Completeness

| Area | Status |
|------|--------|
| Chart of Accounts | ✅ Complete |
| P&L Structure | ✅ Complete |
| Fiscal Calendar | ✅ Complete |
| Month-End Close | ✅ Complete |
| Budget Process | ✅ Complete |
| FX Handling | ✅ Complete |
| Cash Flow | ⚠️ Partial (3 CF accounts) |
| Intercompany | ❌ Not documented |
| Revenue Recognition | ❌ Not documented |
| Cost Allocation | ⚠️ Mentioned but methodology undocumented |
