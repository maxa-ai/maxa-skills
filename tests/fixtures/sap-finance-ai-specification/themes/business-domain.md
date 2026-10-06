---
type: business_domain
title: Business Domain
description: VeloGroup International is a B2B cycling manufacturer/distributor selling to retailers across North America via three customer segments (Speciality, Large, Medium) across four product lines (Cruise, Mountain, Racing, Youth).
confidence: high
timestamp: "2026-10-05T20:02:35Z"
tags: [business-domain, industry, customer-segments, product-lines]
sources:
  - VeloGroup-Maxa-Project-Kick-Off.md
  - VeloGroup-Maxa-FPA-Workshop.md
---

# Business Domain

## Industry Context

VeloGroup International is a manufacturer and distributor of cycling products operating in a B2B model. The company does not sell directly to consumers — it manufactures bikes at its facilities and sells them to retailers across North America.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[12]
> {"speaker": "Stefan Richter", "timestamp": "02:05", "quote": "Sure. VeloGroup International is a manufacturer and distributor of cycling products. We're a B2B company — we don't sell directly to consumers. We manufacture bikes at our facilities and sell them to retailers across North America. Primarily the United States, some Canadian customers as well."}

### Competitive Landscape

In Mountain and Racing, VeloGroup competes against Trek, Specialized, and Giant. In Cruise, the market is more fragmented with lifestyle brands and D2C startups. The e-bike space is increasingly competitive.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[42]
> {"speaker": "Stefan Richter", "timestamp": "07:21", "quote": "And competitively — in Mountain and Racing we're up against Trek, Specialized, and Giant. Those are the big three. In Cruise it's more fragmented — lifestyle brands, some direct-to-consumer startups. The e-bike space is getting crowded everywhere."}

## Geographic Scope

| Region | Revenue Share | Customer Count | Notes |
|---|---|---|---|
| United States | ~85% | 44 | Primary market |
| Canada | ~15% | 9 | Secondary market; transactions in CAD converted to USD |
| Europe | Emerging | NOT_MENTIONED | European distribution forming through acquisitions |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[14]
> {"speaker": "Karen Liu", "timestamp": "02:28", "quote": "Fifty-three customers total. Nine are in Canada, forty-four in the US. By revenue it's roughly 85-15, but I'd need to pull the exact number."}

**Known Gap:** How many European customers/entities exist, and whether they are in scope for analytics, has not been established. This determines whether EUR currency and European legal entities need to be modeled in future phases.

## Customer Segments

| Segment Code | Segment Name | Transaction Share | Description | Example Customers |
|---|---|---|---|---|
| Z1 | Speciality | ~66% | Independent bike shops, premium dealers, enthusiast retailers | TechCycle, The Cycle Factor, Carefree Cycles, KeepCycling, YourCycleShop |
| Z2 | Large | ~31% | Big box retailers, sporting goods chains | Skymart Corp, Bigmart, CostClub, Toys4U, Viadox, Quotex, Bluestar Corp, Dexon, Interlude Inc, Veracity |
| Z3 | Medium | <1% | Mid-size regional chains | Suburban Cycle, G&M Bicycle, XYZ Cycles |
| # | Unassigned | ~2.5% | Non-customer-specific transactions (operating expenses) | N/A |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[20]
> {"speaker": "Priya Sharma", "timestamp": "03:41", "quote": "The Speciality channel is our bread and butter in terms of volume. About 66% of all transactions."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[18]
> {"speaker": "Karen Liu", "timestamp": "03:13", "quote": "Right. The Large channel is about 31% of our financial transactions. Which is significant, but not dominant."}

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[35]
> {"speaker": "Karen Liu", "timestamp": "08:07", "quote": "Yes. Z1, Z2, Z3 in SAP terms. Speciality, Large, and Medium. Speciality is our independent bike shops, the enthusiast retailers. Large is the big accounts, your Skymart Corp, Bigmart, CostClub. And Medium is, well, everything in between. Mid-size regional chains, that sort of thing."}

**Key insight:** Speciality shops order more frequently (e.g., ~20 orders/month) but smaller quantities; Large retailers order 2-3 big orders per quarter. Transaction count is heavily skewed toward Speciality despite fewer total customers.

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[22]
> {"speaker": "Karen Liu", "timestamp": "03:55", "quote": "It's because they order more frequently. A Speciality shop like TechCycle might place twenty orders a month for small quantities. Skymart places two or three big orders per quarter. So the transaction count is heavily skewed toward Speciality."}

## Product Lines

| Product Line | Category Code | Key Models | Price Range | Transaction Share |
|---|---|---|---|---|
| Cruise | CR | C900 ($799), C950 ($299), C990 ($319), E101 ($1,144), E102 ($1,200), E103 ($1,361) | $299-$1,361 | ~30% |
| Mountain | MT | M500 ($1,999), M525 ($2,499), M550 ($4,999) | $1,999-$4,999 | ~30% |
| Racing | RC | R100 ($1,250), R200 ($1,199), R300 ($1,399) | $1,199-$1,399 | ~29% |
| Youth | YH | Y120 ($179), Y200 ($209), Y240 ($249) | $179-$249 | ~9.5% |
| Finished Goods | FG | E15 ($3,999), E16 ($2,499), E17 ($2,499), E108 ($649), E202 ($799), CM-FL-V00 ($7,900) | $649-$7,900 | ~1.5% (combined with TM, RB) |

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[26]
> {"speaker": "Stefan Richter", "timestamp": "04:37", "quote": "Four main product lines. First is Cruise — our comfort and leisure segment. Think weekend riders, boardwalk cruisers, people who want a pleasant ride, not a workout. Second is Mountain — performance bikes for trail riders and enthusiasts. This is our premium segment. Third is Racing — competitive cycling, road bikes. And fourth is Youth — entry-level kids' bikes."}

Source: VeloGroup-Maxa-FPA-Workshop.md, Location: $.values.messages[40]
> {"speaker": "Karen Liu", "timestamp": "07:01", "quote": "Cruise accounts for about 30% of transactions, Mountain 30%, Racing 29%, Youth about 9.5%, and the remaining 1.5% is the other categories — Finished Goods, Trade Materials, and so on."}

## Organizational Structure

| Division | SAP Code | Profit Centers | Description |
|---|---|---|---|
| US Division | US10 | 28 | Primary operating division; contains profit centers by product line x channel |
| Global | ZG | 3 | Corporate overhead allocated to product lines (ZG_PCC1, ZG_PCM1, ZG_PCR1) |
| Logistics | Z_LOG | 4 | Warehouse and distribution costs (Z_LOG_PC7, Z_LOG_PC11, Z_LOG_PC12, Z_LOG_PC13) |
| Year-end | YB | 1 | Holding center for year-end adjustments (YB_PC01) |

**Total:** 37 active profit centers (corroborated across both evidence sources).

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[22]
> {"speaker": "Marcus Weber", "timestamp": "05:19", "quote": "Thirty-seven active profit centers. Twenty-eight under the US Division, three under what we call the Global group, that's ZG in SAP, and then four under Logistics, which is Z_LOG."}

## Company Growth Context

VeloGroup started as a US-focused cycling company and completed three acquisitions in the last six years, expanding into Canada and gaining European distribution. The original parent company was German, which explains the German SAP language configuration.

Source: VeloGroup-Maxa-Project-Kick-Off.md, Location: $.values.messages[13]
> {"speaker": "Stefan Richter", "timestamp": "03:02", "quote": "Right. So the short version is that VeloGroup has been on a growth trajectory, which is wonderful, but our ability to understand and analyze that growth from a financial perspective has not kept up. We've completed three acquisitions in the last six years. We started as a US-focused company making cycling products, and through those acquisitions we expanded into Canada and picked up some European distribution. Every time we bring on a new entity, Marcus and his team do a great job integrating it into SAP. But on the reporting and analytics side, we're still very much in a manual world."}

See [Customer](/entities/customer.md), [Product](/entities/product.md), [CustomerSegment](/entities/customer-segment.md), and [ProductCategory](/entities/product-category.md) for the corresponding data model entities.
