---
type: business_domain
title: Business Domain
description: Industry context, business model, geographic scope, customer segments, product lines, and competitive landscape for VeloGroup International — a B2B cycling manufacturer and distributor.
confidence: high
timestamp: 2026-07-15T16:00:00Z
tags: [business-domain, cycling, b2b, customer-segments, product-lines, competitive-landscape]
sources:
  - VeloGroup-Maxa-Project-Kick-Off
  - VeloGroup-Maxa-FPA-Workshop
---

# Business Domain

## Company Overview

VeloGroup International is a manufacturer and distributor of cycling products operating as a B2B company — they do not sell directly to consumers. They manufacture bikes at their facilities and sell to retailers across North America.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: Workshop, Stefan Richter, 02:05
> "VeloGroup International is a manufacturer and distributor of cycling products. We're a B2B company — we don't sell directly to consumers. We manufacture bikes at our facilities and sell them to retailers across North America."

VeloGroup has grown from a mid-size domestic cycling company through three acquisitions in six years, expanding into Canada and beginning European distribution.

## Geographic Scope

| Region | Customers | Revenue Share |
|--------|-----------|---------------|
| United States | 44 | ~85% |
| Canada | 9 | ~15% |
| Europe | — | Emerging distribution |

**Note:** The 85-15 revenue split is approximate — Karen indicated she'd need to pull the exact number.

## Customer Segments

VeloGroup organizes customers into three segments (SAP customer types):

| Segment | SAP Code | Description | Transaction Share |
|---------|----------|-------------|-------------------|
| Speciality | Z1 | Independent bike shops, premium dealers | ~66% |
| Large | Z2 | Big box retailers, sporting goods chains | ~31% |
| Medium | Z3 | Regional chains | <1% |
| Unassigned | # | Non-customer-specific transactions (OpEx) | ~2.5% |

Speciality shops dominate transaction volume (66%) despite smaller individual orders because they order more frequently. Large retailers receive significant volume discounts through Sales Deductions (FPA1/023), creating a key strategic question about channel profitability.

For customer entity details, see [Customer](/entities/customer.md).

## Product Lines

Four main product lines plus ancillary categories:

| Product Line | SAP Code | Segment | Transaction Share |
|-------------|----------|---------|-------------------|
| Cruise | CR | Comfort/leisure, weekend riders | ~30% |
| Mountain | MT | Performance trail/enthusiast (premium) | ~30% |
| Racing | RC | Competitive cycling, road bikes | ~29% |
| Youth | YH | Entry-level kids' bikes | ~9.5% |
| Other (FG, TM, RB) | — | Higher-end e-bikes, internal assets | ~1.5% |

### E-Bike Growth

E-bikes are VeloGroup's fastest-growing segment with ~40% revenue growth (approximate — medium confidence).

### Youth Line Profitability Question

A key unresolved strategic question is whether the Youth bike line is profitable on its own or serves as a loss leader. This has been debated internally for 2 years without resolution.

For product entity details, see [Product](/entities/product.md).

## Competitive Landscape

| Segment | Key Competitors |
|---------|----------------|
| Mountain & Racing | Trek, Specialized, Giant |
| Cruise | Fragmented — lifestyle brands, DTC startups |
| E-Bikes | Crowded across all segments |

## Total Dimensions

| Dimension | Count |
|-----------|-------|
| Customers | 53 |
| Products | 35 |
| Product Categories | 8 |
| Main Product Lines | 4 |
| Profit Centers | 37 |
| Customer Segments | 3 (+1 Unassigned) |
