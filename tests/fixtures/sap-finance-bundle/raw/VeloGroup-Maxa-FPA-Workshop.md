# VeloGroup – Maxa Business Review & FP&A Workshop

**Meeting Date:** September 22, 2025 - 10:00 AM EST

---

**Amélie Théorêt** *[00:00]*: Good morning everyone. Thank you for joining us for Workshop Two. Before we dive in, let me do a quick round of introductions since we have two new faces today. On the Maxa side, I'm Amélie Théorêt, Delivery Manager. Danny Le is our Analytics Lead — you met him at the kick-off. And joining us today is Lamia Benali, our Analytics Engineer who'll be doing the hands-on data modeling.

**Lamia Benali** *[00:22]*: Hi everyone. I've been briefed on the kick-off notes and I'm excited to dig into the data model today.

**Amélie Théorêt** *[00:28]*: And from VeloGroup?

**Stefan Richter** *[00:30]*: Stefan Richter, CFO. Eight years at VeloGroup. You all know me.

**Karen Liu** *[00:35]*: Karen Liu, VP of FP&A. Five years here. I brought my notes.

**Marcus Weber** *[00:40]*: Marcus Weber, SAP and IT Director. Twelve years. I built this system, so I'll try not to get too defensive about it.

**Priya Sharma** *[00:47]*: And I'm Priya Sharma, Senior Financial Analyst. I'm the one who actually touches the data every day. First time in one of these workshops but I had to be here — I have opinions.

**Amélie Théorêt** *[00:58]*: Welcome, Priya. Okay, quick recap of where we left off at the kick-off two weeks ago. We established the project scope — replacing Excel-based FP&A reporting with an analytics platform. We identified the key stakeholders, agreed on the data sources, and outlined today's agenda. This session is our deep dive. We have about two hours and we're going to cover ten themes comprehensively. We'll go through the business domain, financial structure, source systems, entity review, operational processes, KPIs, use cases, and business rules. Any questions before we start?

**Stefan Richter** *[01:35]*: Just one — I have a hard stop at noon. Can we make sure we cover the most critical topics first?

**Amélie Théorêt** *[01:42]*: Absolutely. The financial structure and source system sections are the most critical and we're front-loading those. The business domain overview will be first since it sets context for everything else. Shall we?

**Stefan Richter** *[01:53]*: Let's go.

**Amélie Théorêt** *[01:55]*: Great. Stefan, can you walk us through VeloGroup's business model? We touched on it in the kick-off but I want the full picture for Lamia and Priya.

**Stefan Richter** *[02:05]*: Sure. VeloGroup International is a manufacturer and distributor of cycling products. We're a B2B company — we don't sell directly to consumers. We manufacture bikes at our facilities and sell them to retailers across North America. Primarily the United States, some Canadian customers as well.

**Danny Le** *[02:25]*: What's the US-Canada split?

**Karen Liu** *[02:28]*: Fifty-three customers total. Nine are in Canada, forty-four in the US. By revenue it's roughly 85-15, but I'd need to pull the exact number.

**Stefan Richter** *[02:38]*: So heavily US. Now, our customers fall into three segments, and this is important because it drives how we organize our P&L. The first segment is Large retail — the big box retailers and sporting goods chains. These are companies like Skymart Corp, Bigmart, CostClub, Toys4U. Also Viadox, Quotex, Bluestar Corp, Dexon, Interlude Inc, and Veracity.

**Danny Le** *[03:04]*: These are the whale accounts?

**Stefan Richter** *[03:07]*: Big order sizes, yes. But Karen will tell you they're not where most of our transaction volume comes from.

**Karen Liu** *[03:13]*: Right. The Large channel is about 31% of our financial transactions. Which is significant, but not dominant.

**Stefan Richter** *[03:21]*: The second segment is Speciality — independent bike shops and premium dealers. TechCycle is probably our best-known Speciality partner. Also The Cycle Factor, Carefree Cycles, KeepCycling, YourCycleShop. These are the shops where the staff actually knows what a derailleur hanger is.

**Priya Sharma** *[03:41]*: The Speciality channel is our bread and butter in terms of volume. About 66% of all transactions.

**Danny Le** *[03:48]*: Sixty-six percent? That's a lot more than Large despite having presumably fewer total customers in that segment.

**Karen Liu** *[03:55]*: It's because they order more frequently. A Speciality shop like TechCycle might place twenty orders a month for small quantities. Skymart places two or three big orders per quarter. So the transaction count is heavily skewed toward Speciality.

**Stefan Richter** *[04:09]*: And then the third segment is Medium — regional chains. Suburban Cycle, G&M Bicycle, XYZ Cycles. Honestly, it's a very small piece of the business.

**Karen Liu** *[04:20]*: Less than one percent of transactions. The remaining two and a half percent is unassigned — transactions that aren't customer-specific, like operating expenses.

**Amélie Théorêt** *[04:31]*: Let's talk about the product side. Stefan, walk us through the product lines.

**Stefan Richter** *[04:37]*: Four main product lines. First is Cruise — our comfort and leisure segment. Think weekend riders, boardwalk cruisers, people who want a pleasant ride, not a workout. Second is Mountain — performance bikes for trail riders and enthusiasts. This is our premium segment. Third is Racing — competitive cycling, road bikes. And fourth is Youth — entry-level kids' bikes.

**Danny Le** *[05:02]*: Can you give us the specific models and price points? That'll be important for understanding the revenue mix.

**Karen Liu** *[05:08]*: I can rattle those off. In Cruise, we have three standard bikes — the C900 at $799, C950 at $299, and C990 at $319. Then Cruise also has e-bike variants — E101 at $1,144, E102 at $1,200, and E103 at $1,361.

**Priya Sharma** *[05:30]*: The E101 has been a surprise hit, by the way. When I look at the transaction data, it's one of our highest-volume Cruise products.

**Stefan Richter** *[05:38]*: The e-bike market is exploding. We got in early on that with the E101 and it's paying off.

**Karen Liu** *[05:44]*: Mountain bikes — M500 at $1,999, M525 at $2,499, and the M550 at $4,999.

**Stefan Richter** *[05:53]*: The M550 is our crown jewel. Full carbon, full suspension. It goes head-to-head with Trek's Fuel EX and Specialized's Stumpjumper at that price point. We hold our own.

**Danny Le** *[06:05]*: And Racing?

**Karen Liu** *[06:07]*: R100 at $1,250, R200 at $1,199, and R300 at $1,399. And Youth — Y120 at $179, Y200 at $209, Y240 at $249. The Youth line is the lowest price point obviously.

**Lamia Benali** *[06:22]*: Are there products outside these four main lines?

**Karen Liu** *[06:26]*: Yes. We have a Finished Goods category with some higher-end e-bikes — E15 at $3,999, E16 and E17 both at $2,499, E108 at $649, and E202 at $799. There's also a forklift in there — CM-FL-V00 at $7,900.

**Lamia Benali** *[06:45]*: A forklift?

**Marcus Weber** *[06:47]*: Yeah, I know. It's an internal asset tracked as a product in SAP for cost allocation purposes. It's a handful of transactions. Don't lose sleep over it.

**Danny Le** *[06:57]*: What's the product mix in terms of transaction distribution?

**Karen Liu** *[07:01]*: Cruise accounts for about 30% of transactions, Mountain 30%, Racing 29%, Youth about 9.5%, and the remaining 1.5% is the other categories — Finished Goods, Trade Materials, and so on.

**Danny Le** *[07:16]*: Fairly even across the main three, with Youth as the smaller fourth.

**Stefan Richter** *[07:21]*: And competitively — in Mountain and Racing we're up against Trek, Specialized, and Giant. Those are the big three. In Cruise it's more fragmented — lifestyle brands, some direct-to-consumer startups. The e-bike space is getting crowded everywhere.

**Amélie Théorêt** *[07:36]*: Great context. Thank you, Stefan. Let's shift into the financial structure now. Karen, this is going to be a long section and it's the most critical one. Take your time.

**Karen Liu** *[07:47]*: Happy to. Okay, let me start with the GL account structure. We have five account types. Income, coded INC — this is where revenue lives. Expense, coded EXP — cost of goods sold and operating costs. Asset, coded AST. Liabilities and Equity, LEQ. And Non-financial Income, NFIN.

**Danny Le** *[08:10]*: What does Non-financial Income cover?

**Karen Liu** *[08:13]*: Statistical accounts. Headcount, square footage, capacity metrics. Things we track for allocation and reporting purposes that aren't monetary amounts.

**Danny Le** *[08:23]*: Got it. So for the FP&A analytics, we're primarily focused on INC and EXP?

**Karen Liu** *[08:28]*: Primarily, yes. Though AST and LEQ feed into the balance sheet view, and the cash flow accounts touch on those as well. But for the P&L — which is where ninety percent of the FP&A work happens — it's INC and EXP.

**Karen Liu** *[08:43]*: Now, the P&L hierarchy. This is critical, so I want to be really precise. At the top we have Net Income — that's account FPA1/08. It's the root of the tree.

**Priya Sharma** *[08:55]*: Should I bring up the hierarchy diagram, Karen?

**Karen Liu** *[08:58]*: No, I have it memorized. Twenty-one accounts, I could recite them in my sleep at this point. Under Net Income sits EBIT — FPA1/09. Under EBIT is Operating Income — FPA1/016.

**Karen Liu** *[09:11]*: Operating Income splits into two major branches. On the revenue side, Gross Margin — FPA1/017. And on the cost side, Operating Expense — FPA1/018.

**Danny Le** *[09:23]*: Let's go down the Gross Margin branch first.

**Karen Liu** *[09:26]*: Gross Margin has two children — Net Revenue at FPA1/021 and COGS at FPA1/020. Net Revenue is the difference between Gross Revenue and Sales Deductions. Gross Revenue is FPA1/022 — this is the top-line sales number. About 30,724 transactions. Sales Deductions is FPA1/023 — discounts, returns, rebates. About 8,835 transactions.

**Danny Le** *[09:55]*: And COGS?

**Karen Liu** *[09:57]*: COGS is the big one. FPA1/020. About 126,390 transactions.

**Lamia Benali** *[10:03]*: A hundred and twenty-six thousand?

**Priya Sharma** *[10:05]*: Yeah. Seventy-five percent of everything in the system. It's because COGS is tracked at the full product-customer-profit center grain. Every sale generates a revenue posting and a corresponding cost posting, and the cost side tends to be more granular.

**Danny Le** *[10:20]*: So COGS alone is three quarters of your transaction volume. That's going to be the heaviest table partition by far.

**Karen Liu** *[10:27]*: Yes. And it's why Priya's Excel file crashes. That volume of COGS data in a pivot table is... not great.

**Priya Sharma** *[10:35]*: It's terrible. Last month it crashed twice. The second time I lost four hours of work because I hadn't saved. Four hours, just gone.

**Stefan Richter** *[10:44]*: The spreadsheet that ate the finance team. That's what I call Priya's monthly reporting workbook.

**Priya Sharma** *[10:50]*: It's not funny when you're the one rebuilding the pivot tables at 8 PM, Stefan.

**Stefan Richter** *[10:55]*: I know, I know. Which is why we're here.

**Amélie Théorêt** *[10:59]*: Karen, let's continue with the Operating Expense branch.

**Karen Liu** *[11:02]*: Right. Operating Expense — FPA1/018 — splits into Building Expense at FPA1/024, Employee Expense at FPA1/026, and Other Operating Expense at FPA1/027.

**Karen Liu** *[11:15]*: Under Building, there's Periodic at FPA1/028 — that's rent, insurance, property-related costs — and Utilities at FPA1/029. Under Employee, we have Office at FPA1/032, Payroll at FPA1/033, Travel at FPA1/034, and Employee Other at FPA1/035.

**Danny Le** *[11:36]*: And these are the leaf accounts for OpEx? Meaning FPA1/028, FPA1/029, FPA1/032 through FPA1/035 are where transactions actually post?

**Karen Liu** *[11:46]*: Exactly. The parent nodes — Operating Expense, Building, Employee — those are calculated by summing the children. You'll never see a transaction posted to FPA1/018 directly.

**Lamia Benali** *[11:57]*: Same principle as the Gross Margin branch? Transactions only post to leaf nodes?

**Karen Liu** *[12:01]*: Same principle. Across the entire hierarchy, transactions only post to leaf-level accounts. Everything else is a rollup.

**Danny Le** *[12:10]*: That's clean. Makes the aggregation logic straightforward.

**Karen Liu** *[12:14]*: Now, there's a really important distinction I want to make sure we capture. Revenue — Gross Revenue and Sales Deductions — is tracked at the full grain. Product, customer, profit center. COGS is also at the full grain. But operating expenses — Payroll, Building, Utilities — those are mostly at the profit center level only.

**Amélie Théorêt** *[12:35]*: Meaning?

**Karen Liu** *[12:37]*: Meaning for an operating expense transaction, the CUSTOMERID is set to hash and the PRODUCTID is set to hash. Because a payroll expense isn't tied to a specific customer or a specific product. It's an organizational cost assigned to a profit center.

**Lamia Benali** *[12:54]*: So the dimensionality varies by account type. Revenue and COGS: full grain with customer, product, and profit center. OpEx: profit center only with hash for customer and product.

**Karen Liu** *[13:05]*: Exactly right. That's a fundamental characteristic of the data.

**Marcus Weber** *[13:10]*: And just to be clear — hash isn't a null. It's a real dimension member. It has an entry in the customer master, an entry in the product master. It has text, it has a hierarchy position. Don't filter it out.

**Danny Le** *[13:24]*: Noted. We'll treat hash as a first-class dimension member with an "Unassigned" label.

**Karen Liu** *[13:31]*: Good. And I should mention the Cash Flow accounts. We have CF_I — Cash Flow Statement using the indirect method. Under that, CF_CFO for Cash Flow from Operating Activities, and CF_D for Depreciation. These sit outside the main P&L hierarchy but they're in the same GL account master.

**Danny Le** *[13:50]*: Twenty-one accounts total, five types, organized in a parent-child hierarchy. I think I have the full picture. Let me move to the fiscal calendar.

**Amélie Théorêt** *[13:59]*: Go ahead.

**Danny Le** *[14:01]*: Karen, what's VeloGroup's fiscal year?

**Karen Liu** *[14:04]*: Calendar year. January 1 through December 31. Monthly reporting periods. We don't do anything exotic — no 4-4-5 calendar, no offset fiscal year. Plain vanilla.

**Danny Le** *[14:16]*: And the data range we're working with?

**Karen Liu** *[14:19]*: April 2018 through January 2021. So we have a partial 2018, two full calendar years — 2019 and 2020 — and just January of 2021.

**Priya Sharma** *[14:31]*: The year-by-year breakdown is roughly 39,750 transactions in 2018, 66,740 in 2019, 57,130 in 2020, and about 3,513 in January 2021.

**Stefan Richter** *[14:45]*: 2020 is the COVID year. We saw a significant dip in Q2 when everything shut down, but then a huge surge in Q3 and Q4. Everyone suddenly wanted a bike. The annual total doesn't tell the full story — you'd need to see the monthly trend to understand what really happened.

**Danny Le** *[15:02]*: We'll definitely build monthly trending into the analytics. Year-over-year comparison is one of the standard views.

**Amélie Théorêt** *[15:10]*: Karen, tell us about the month-end close timeline. You mentioned five days at the kick-off.

**Karen Liu** *[15:16]*: Five business days, yes. Here's how it breaks down. Days one through three are the actual close activities — finalizing accruals, posting adjusting entries, running cost allocations in SAP. Day four, Marcus runs the data extraction. Day five — sometimes day six if it's a bad month — Priya and I build the reporting package.

**Stefan Richter** *[15:38]*: Five days is too long. My board expects numbers within a week of month-end and I barely make it. In my previous role at a company of similar size, we closed in three days.

**Karen Liu** *[15:50]*: Stefan, your previous company had a BI team of twelve people.

**Stefan Richter** *[15:54]*: Fair. But that's exactly the point — we need tooling to make up for not having a twelve-person team.

**Karen Liu** *[16:00]*: If we can automate the reporting layer, the extraction and report-building step — days four and five — could be same-day. The close itself takes three days of accounting work regardless. So three-day close is absolutely achievable if we eliminate the manual reporting bottleneck.

**Amélie Théorêt** *[16:18]*: That's a concrete, measurable outcome we can target. Let's talk about Budget vs Actual.

**Karen Liu** *[16:25]*: Two versions in the system — Actual and Budget. Every single transaction in the FinancialTransactions table is tagged with one or the other. Same dimensional structure for both — account, customer, product, profit center, date, value.

**Danny Le** *[16:40]*: Same grain?

**Karen Liu** *[16:42]*: Same grain, same dimensions. But here's what's interesting — Budget has significantly more transactions than Actual.

**Lamia Benali** *[16:50]*: More budget transactions than actual? That's not typical.

**Karen Liu** *[16:54]*: 102,380 budget transactions versus 64,756 actual. The split is about 61% budget, 39% actual. Budget has more rows because we forecast at a very granular level. My team builds the budget at the individual product-customer-profit center level for every month. That creates a lot of line items.

**Priya Sharma** *[17:12]*: Building the budget is a two-month exercise. We start in September, get volume projections from sales, apply pricing, layer in COGS assumptions, estimate every OpEx line item. It's incredibly detailed.

**Karen Liu** *[17:25]*: We usually finalize in mid-November, and then Marcus loads it into SAP BPC.

**Marcus Weber** *[17:31]*: The load itself takes about a day. Karen fills out BPC import templates and I run the jobs. We do validation checks afterward — totals have to tie to Karen's approved numbers before I sign off.

**Stefan Richter** *[17:44]*: Budget vs Actual variance analysis is probably my most requested report. Every month I want to see where we're off plan, by how much, and more importantly, why.

**Danny Le** *[17:55]*: Is the variance analysis done at every level of the P&L?

**Karen Liu** *[17:59]*: From Net Income all the way down to individual leaf accounts. But the most actionable variances tend to be at the Gross Margin level — is it a revenue problem or a cost problem? — and within Operating Expense — are we overspending on payroll, travel?

**Danny Le** *[18:16]*: And you analyze variance across the other dimensions too? By customer, product, profit center?

**Karen Liu** *[18:22]*: In theory, yes. In practice, cross-dimensional variance analysis in Excel is painful. I can do it for one dimension at a time. If Stefan asks "why is Gross Margin off budget in the Cruise line?" I have to go back to the raw data, filter for Cruise profit centers, compare budget to actual for each account, and try to find the story. That takes an hour.

**Amélie Théorêt** *[18:44]*: That's exactly the kind of workflow we want to make instant. Let's cover currency before we move to the source system.

**Karen Liu** *[18:52]*: Simple story. Primary currency is USD. All products priced in USD. Our Canadian customers transact in CAD, but in the dataset the amounts are converted to USD equivalent at the posting rate.

**Marcus Weber** *[19:04]*: The SAP extract handles the FX conversion. Everything in the VALUE column is in USD. No multi-currency work needed on the analytics side.

**Danny Le** *[19:13]*: That's one less complication. Though I do need to flag something about the VALUE column —

**Marcus Weber** *[19:19]*: The VARCHAR thing?

**Danny Le** *[19:21]*: Yeah, let's get into that now.

**Marcus Weber** *[19:23]*: Okay. The VALUE column in the FinancialTransactions table is stored as VARCHAR, not DECIMAL. And it uses European comma formatting. So "12734,04" means twelve thousand seven hundred thirty-four dollars and four cents. The comma is the decimal separator.

**Lamia Benali** *[19:42]*: VARCHAR for financial amounts. Why?

**Marcus Weber** *[19:45]*: It's how SAP BPC exports data. The extraction process writes everything as delimited text. This format has been in place since we set up the system. I know it's not ideal, but it's consistent. Every single value follows the same format.

**Lamia Benali** *[19:59]*: Negative values?

**Marcus Weber** *[20:01]*: Minus sign prefix. "-5432,10" is negative five thousand four hundred thirty-two and ten cents.

**Lamia Benali** *[20:09]*: Nulls? Empty strings?

**Marcus Weber** *[20:11]*: I'm not aware of any, but I'd recommend validating. The data is generally very clean — SAP enforces referential integrity at the source — but it's always worth checking.

**Danny Le** *[20:22]*: We'll handle the conversion in the transformation layer. Replace comma with period, cast to numeric. Straightforward but critical to get right.

**Amélie Théorêt** *[20:32]*: Good. Let's transition to the source system details. Marcus, this is your section.

**Marcus Weber** *[20:39]*: All right, I've been waiting for this. So the SAP data model follows a classic star schema architecture. We have one central fact table — FinancialTransactions — surrounded by 18 dimension and reference tables organized in four groups.

**Danny Le** *[20:57]*: How many rows in the fact table?

**Marcus Weber** *[21:00]*: 167,136. That's Actual plus Budget combined — 64,756 plus 102,380.

**Danny Le** *[21:08]*: And the four groups of dimension tables?

**Marcus Weber** *[21:11]*: GL Accounts, Customers, Products, and Profit Centers. Each group follows the SAP convention — a master data table, a type or category classification table, a text table for multilingual labels, and a hierarchy table. Let me walk through each group.

**Marcus Weber** *[21:29]*: GL Accounts group — five tables. The GL Accounts master table has 21 rows. Each row has an ACCOUNTID — like FPA1/022 — and an ACCOUNTTYPEID that links to the GLAccountType table. The GLAccountType table has 5 rows — INC, EXP, AST, LEQ, NFIN. Then we have GLAccountTypeTexts with the type descriptions and GLAccountsTexts with the account names — "Gross Revenue," "COGS," "Payroll," and so on. Finally, GLAccountsHierarchy — 21 rows — which defines the parent-child P&L tree Karen described.

**Lamia Benali** *[22:06]*: The hierarchy table — is it an adjacency list? Nested sets?

**Marcus Weber** *[22:10]*: Parent-child adjacency list. Each row has a HIERARCHYID, a DESCRIPTION, and a LEVEL field. Level 1 is the root — that's Net Income. Level 2 is EBIT. Level 3 is Operating Income. Higher numbers are more granular.

**Lamia Benali** *[22:27]*: Okay. And the Customer group?

**Marcus Weber** *[22:30]*: Also five tables. The Customer master has 53 rows. Each customer has CUSTOMERID, CUSTOMERTYPEID, COUNTRY, and LANGUAGE. CustomerType has 4 rows — Z1 for Speciality, Z2 for Large, Z3 for Medium, and # for Unassigned.

**Marcus Weber** *[22:48]*: Then CustomerTexts — this one has 56 rows, which is three more than the number of customers.

**Lamia Benali** *[22:55]*: Why the mismatch?

**Marcus Weber** *[22:57]*: Multilingual entries. Some customers have both English and German text records. It's an SAP convention — the text tables have a LANGUAGE column, so you can store labels in multiple languages. Most of our customers are English-only, but a few have German entries too. When you join, filter on LANGUAGE equals EN for English.

**Lamia Benali** *[23:15]*: Good to know. And there's a CustomerTypeTexts and CustomersHierarchy?

**Marcus Weber** *[23:20]*: CustomerTypeTexts for the type descriptions, yes. And CustomersHierarchy with 56 rows for customer groupings — grouping customers by type and geography.

**Danny Le** *[23:31]*: Products next?

**Marcus Weber** *[23:33]*: Products group — five tables again. The Products master has 35 rows. Each product has PRODUCTID, TYPECODE, PRODUCTCATEGORYID, CURRENCY, PRICE, and some physical dimension fields — weight, length, that sort of thing.

**Lamia Benali** *[23:49]*: What are the product categories?

**Marcus Weber** *[23:52]*: ProductCategories table has 8 rows. CR for Cruise, MT for Mountain, RC for Racing, YH for Youth, FG for Finished Goods, TM for Trade Materials, RB for Raw Materials, and # for Unassigned.

**Danny Le** *[24:06]*: TM and RB — are those relevant for FP&A?

**Marcus Weber** *[24:09]*: Not really. Those are minor categories for internal tracking. For the FP&A model, you'll care about CR, MT, RC, YH, and maybe FG.

**Marcus Weber** *[24:19]*: Then ProductTexts at 41 rows — again multilingual — ProductCategoryTexts at 8 rows, and ProductHierarchy at 43 rows. The product hierarchy groups products under nodes called ZCRUISE, ZMTN, ZRACING, ZYOUTH, and ZFGOODS.

**Lamia Benali** *[24:37]*: The Z prefix again?

**Marcus Weber** *[24:39]*: SAP custom namespace. Z means customer-defined, not SAP standard. All our custom hierarchies, custom types — they're all Z-prefixed.

**Danny Le** *[24:49]*: And the Profit Center group?

**Marcus Weber** *[24:52]*: Three tables — slightly simpler than the other groups. ProfitCenter master with 37 rows. Each has a PROFITCENTERID and LANGUAGE. ProfitCenterTexts with descriptive names like "Cruise Cycles - Large" or "Mountain Bikes - Small." And ProfitCenterHierarchy with 60 rows.

**Karen Liu** *[25:10]*: The profit center is our primary management reporting dimension. I can't stress this enough. When Stefan asks "how is Cruise doing?" we don't look at the product category — we look at the profit centers under Cruise. Because the profit center captures not just the product line but also the channel — Large versus Speciality.

**Stefan Richter** *[25:30]*: Exactly. I want to see P&L by product line — meaning by profit center group — and I want to compare Cruise vs Mountain vs Racing, side by side. And then I want to drill into a product line and see Large vs Speciality within it.

**Danny Le** *[25:45]*: So the profit center hierarchy is your primary slicing dimension for management reporting. That's key for the data model design.

**Amélie Théorêt** *[25:54]*: Marcus, can you walk through the profit center hierarchy in detail? The full tree?

**Marcus Weber** *[25:59]*: Sure. At the top level is US Division, which contains 28 profit centers. Under US Division, it branches by product line. Cruise has six profit centers: PCC1L and PCC1S, PCC2L and PCC2S, PCC3L and PCC3S. The L suffix means Large channel, S means Speciality — or Small, in the system's terminology.

**Marcus Weber** *[26:23]*: Mountain follows the same pattern — PCM1L, PCM1S, PCM2L, PCM2S, PCM3L, PCM3S. Six profit centers. Racing: PCR1L, PCR1S, PCR2L, PCR2S, PCR3L, PCR3S. Also six. Youth is smaller — only four profit centers: PCY1L, PCY1S, PCY3L, PCY3S.

**Karen Liu** *[26:47]*: Youth doesn't have the full matrix because it's our smallest line. We consolidated some profit centers there.

**Marcus Weber** *[26:54]*: Outside of US Division, there are Global profit centers — ZG_PCC1 for Global Cruise, ZG_PCM1 for Global Mountain, ZG_PCR1 for Global Racing. These capture costs that aren't US-specific. Corporate overhead allocated to product lines, that sort of thing.

**Danny Le** *[27:10]*: Any other profit centers?

**Marcus Weber** *[27:13]*: Logistics — Z_LOG_PC7, Z_LOG_PC11, Z_LOG_PC12, Z_LOG_PC13. Those handle warehouse and distribution costs. And there's one special one, YB_PC01, which is a holding center for year-end adjustments. Low volume.

**Marcus Weber** *[27:31]*: The naming convention encodes the structure. US10_PCC1L: US is the country code, 10 is the company code, PCC is Cruise, 1 is the sub-line, L is Large. US10_PCM2S: US, company 10, Mountain, sub-line 2, Speciality.

**Lamia Benali** *[27:49]*: Can we parse the profit center ID to derive the product line and channel?

**Karen Liu** *[27:54]*: In theory, yes. PCC is always Cruise, PCM is Mountain, PCR is Racing, PCY is Youth. And L vs S gives you the channel. But I'd suggest using the hierarchy for grouping instead of parsing strings — it's more reliable.

**Lamia Benali** *[28:07]*: Agreed. The hierarchy is the source of truth.

**Danny Le** *[28:11]*: Marcus, one more thing — dates. You mentioned BIGINT format?

**Marcus Weber** *[28:16]*: Yes. The date field in FinancialTransactions is a BIGINT in YYYYMMDD format. January 1, 2021 is stored as 20210101. No separators, no time component. Just an eight-digit integer.

**Lamia Benali** *[28:30]*: Any invalid dates? Zeroes, sentinel values?

**Marcus Weber** *[28:34]*: Not that I've seen. SAP validates dates at the posting level. But run a check during profiling just to be thorough.

**Danny Le** *[28:42]*: What about the data refresh cadence?

**Marcus Weber** *[28:45]*: Currently it's a monthly batch extract. After the close process completes — about five business days after month-end — I run the SAP extraction and produce CSV files. One file per table. Those CSVs are what Karen and Priya use for their Excel work.

**Priya Sharma** *[29:01]*: "Use" is generous. "Struggle with" is more accurate. The FinancialTransactions CSV alone is 167,000 rows. Excel handles it, barely, but the pivot tables built on top of it are where things fall apart.

**Lamia Benali** *[29:15]*: Those CSV files — are those the source files we'll be ingesting?

**Marcus Weber** *[29:19]*: That's what we have today, yes. One CSV per table. I can provide the full set.

**Lamia Benali** *[29:25]*: I'll need those as soon as possible. I want to profile every table — validate row counts, check the value formatting, test all the foreign key relationships.

**Marcus Weber** *[29:34]*: I'll have them to you by Wednesday.

**Amélie Théorêt** *[29:38]*: Let's move into the entity review now. Lamia, I know you want to walk through each entity systematically for the data model.

**Lamia Benali** *[29:46]*: Yes. Let me start with the fact table. Marcus, the FinancialTransactions table — what exactly is the grain? What makes a row unique?

**Marcus Weber** *[29:56]*: The grain is the unique combination of account, customer, product, profit center, version, and date. Each row represents a financial posting for that specific combination. It's important to note — these aren't individual journal entries. They're aggregated at the dimensional grain.

**Danny Le** *[30:13]*: So if TechCycle — what's their ID?

**Karen Liu** *[30:16]*: LACU_S02.

**Danny Le** *[30:18]*: If TechCycle bought ten M550 bikes on the same day, that's one row?

**Karen Liu** *[30:23]*: One row in the fact table, assuming they're posted to the same GL account and profit center. The value would be the aggregated amount.

**Lamia Benali** *[30:32]*: And the value is the VARCHAR column with European formatting?

**Marcus Weber** *[30:36]*: Correct. Single column, always in USD.

**Lamia Benali** *[30:40]*: Let's talk about the master data entities. GL Accounts — 21 accounts, each with an account type, each positioned in the P&L hierarchy. These are leaf accounts where transactions post, plus rollup nodes that are calculated.

**Karen Liu** *[30:56]*: Correct. Leaf accounts are the ones with actual postings. FPA1/022 for Gross Revenue, FPA1/020 for COGS, FPA1/033 for Payroll — those are leaves. FPA1/017 for Gross Margin, FPA1/018 for Operating Expense — those are rollup nodes. Calculated, never posted to.

**Lamia Benali** *[31:15]*: Customers — 53 rows. Each has country, language, customer type. These represent the companies VeloGroup sells to.

**Karen Liu** *[31:24]*: Right. Our largest Speciality customer by transaction volume is TechCycle, LACU_S02. On the Large side, Skymart Corp is one of the biggest. And in Medium, Suburban Cycle — customer ID 1000153 — is our most loyal account even though they're small.

**Lamia Benali** *[31:42]*: Products — 35 rows. Category, price, currency.

**Karen Liu** *[31:47]*: Physical goods we manufacture and sell. The 35 includes the four product lines plus the Finished Goods category and the minor categories.

**Lamia Benali** *[31:56]*: And Profit Centers — 37 rows.

**Karen Liu** *[31:59]*: Organizational units responsible for P&L. Named by product line and channel size. US10_PCC1L is Cruise, Large. Each profit center is essentially a mini P&L.

**Stefan Richter** *[32:11]*: That's how I manage the business. I can see how Cruise Large is performing versus Cruise Speciality. Or compare all of Mountain against all of Racing. The profit center structure gives me the management view I need.

**Danny Le** *[32:25]*: Now the reference entities. CustomerType — four values. Z1 Speciality, Z2 Large, Z3 Medium, # Unassigned. GLAccountType — INC, EXP, AST, LEQ, NFIN. ProductCategories — CR, MT, RC, YH, FG, TM, RB, #.

**Lamia Benali** *[32:42]*: And the hierarchy entities. GLAccountsHierarchy is the P&L tree. CustomersHierarchy groups customers by type and geography. ProductHierarchy organizes products under ZCRUISE, ZMTN, ZRACING, ZYOUTH, ZFGOODS. ProfitCenterHierarchy goes from US Division through product lines to Large and Small.

**Marcus Weber** *[33:02]*: Exactly. And the text entities — GLAccountsTexts, CustomerTexts, ProductTexts, ProfitCenterTexts, and the type/category text tables — those are just lookup tables for display labels. Multilingual, joined on ID and filtered by language.

**Lamia Benali** *[33:19]*: Are these hierarchies static?

**Marcus Weber** *[33:22]*: Mostly. I update them quarterly or when there's an org change. For the data set you're looking at — 2018 through 2021 — they've been stable. No restructuring during that period.

**Danny Le** *[33:35]*: Good. That means we can treat them as slowly changing dimensions — probably Type 1 for this scope.

**Amélie Théorêt** *[33:43]*: Let's shift to operational processes. Karen, walk us through the financial transaction flow from start to finish.

**Karen Liu** *[33:52]*: Okay. It starts with business transactions throughout the month. Sales orders come in from customers — the sales team processes them in SAP. When a sale is fulfilled, SAP generates journal entries — a debit to COGS, a credit to inventory, a debit to accounts receivable, a credit to revenue. Those postings accumulate throughout the month.

**Karen Liu** *[34:14]*: On the expense side, invoices come in for rent, utilities, supplies. Payroll runs biweekly. Travel expenses get submitted and approved. All of these flow through as journal entries and land in the FinancialTransactions table — each one at the appropriate account, profit center, and date.

**Marcus Weber** *[34:34]*: And SAP maintains the dimensional integrity at every step. You can't post a transaction without a valid GL account, a valid profit center. The system enforces it.

**Amélie Théorêt** *[34:45]*: Then month-end happens.

**Karen Liu** *[34:47]*: Right. Month-end close starts on the first business day after the month ends. Days one through three are accounting activities — finalizing accruals for any revenue or expense that was earned or incurred but not yet posted. Adjusting entries for things like depreciation. Cost allocations — we allocate some shared costs across profit centers.

**Karen Liu** *[35:08]*: Once the books are closed — meaning all journal entries are finalized and the trial balance is balanced — Marcus runs the extraction on day four.

**Marcus Weber** *[35:18]*: I run a set of BPC reports that export the full data set to CSV. One file per table. The extraction process takes about two hours. I check the row counts against the prior month — if the FinancialTransactions table grew by roughly the expected number of rows, I know the extraction worked. Then I hand the files to Karen's team.

**Karen Liu** *[35:39]*: And then Priya and I spend day five — sometimes day six — building the reporting package. Pivot tables, variance calculations, charts, formatting for Stefan's review.

**Priya Sharma** *[35:51]*: The worst part is rebuilding the pivot tables from scratch each month. The structure is always the same, but I can't just refresh because the source data changed shape. So I delete the old pivots, reimport the new CSV, and rebuild. Every single month.

**Danny Le** *[36:08]*: That's exactly what the analytics platform will eliminate. The data model stays persistent — new data flows in, reports refresh automatically.

**Priya Sharma** *[36:17]*: That sounds like a dream, honestly.

**Amélie Théorêt** *[36:21]*: What about master data governance? How do new customers or products get added to the system?

**Marcus Weber** *[36:28]*: New customers are requested by the sales team. Karen reviews and approves. Then I create the customer in SAP — set up the master record, assign the customer type, link them to the appropriate hierarchy nodes. Same for products — once a new product is approved for production, I set it up in the master data with category, pricing, hierarchy placement.

**Karen Liu** *[36:48]*: For hierarchy changes — like if we need to reorganize the profit center structure because a product line has grown — Marcus and I collaborate. He handles the SAP side, I update my reporting templates. But it's rare. Maybe once or twice a year.

**Amélie Théorêt** *[37:03]*: And the budget loading process — we touched on this but let me make sure we have it fully documented.

**Karen Liu** *[37:10]*: Annual exercise. My team starts building the budget in September. We work bottom-up — the sales team provides volume projections by customer and product. We apply pricing to get revenue. We estimate COGS based on current costs and expected changes. We layer in operating expenses — headcount plans for payroll, lease agreements for building, historical patterns for travel and utilities.

**Karen Liu** *[37:36]*: It's about eight weeks of work. Multiple iterations, reviews with business unit leaders. Stefan signs off on the final version, usually mid-November. Then Marcus loads it.

**Marcus Weber** *[37:48]*: I have BPC import templates that Karen fills out. The templates mirror the fact table structure — account, customer, product, profit center, period, value. I run the import jobs, then we validate. The loaded budget totals have to match Karen's approved totals to the penny before I sign off.

**Stefan Richter** *[38:06]*: The budget process is painful but critical. It's our plan for the year. Every variance I see during the year is measured against that budget.

**Amélie Théorêt** *[38:16]*: Understood. Let's move to KPIs and metrics. This is what drives the analytics platform design. Stefan, what are the three metrics you care about most?

**Stefan Richter** *[38:27]*: Number one — Gross Margin percentage. Net Revenue minus COGS, divided by Net Revenue. That tells me how efficiently we're converting sales into profit before operating costs. If Gross Margin is slipping, I have a cost problem or a pricing problem, and I need to know immediately.

**Stefan Richter** *[38:47]*: Number two — Budget vs Actual variance. Both dollar variance and percentage variance. I want to see it at the P&L line level and I want to be able to drill into the dimensions to understand why we're off plan.

**Stefan Richter** *[39:01]*: Number three — Revenue by product line. Which lines are growing, which are flat, which are declining. Cruise, Mountain, Racing, Youth — I need to see the trend.

**Danny Le** *[39:13]*: Karen, what's the full list of KPIs you track?

**Karen Liu** *[39:17]*: I currently track about fifteen in my Excel dashboard. Let me go through them. Financial KPIs first. Gross Revenue — top-line number from FPA1/022. Net Revenue — Gross Revenue minus Sales Deductions. COGS from FPA1/020. Gross Margin — Net Revenue minus COGS. Gross Margin percent.

**Karen Liu** *[39:40]*: Operating Expense total, broken down into Building and Employee. EBIT — Operating Income after all expenses. Net Income. Budget vs Actual variance in both dollars and percentage for all of those line items. Revenue by product line. And COGS ratio — COGS divided by Net Revenue — which is basically the inverse of Gross Margin but some analysts prefer to see cost as a percentage of revenue.

**Danny Le** *[40:07]*: That's the financial set. Operational metrics?

**Karen Liu** *[40:10]*: Transaction volumes by account type — I track those to spot anomalies. If COGS transactions suddenly spike or drop, something changed in the business and I want to investigate. Product mix — what percentage of revenue comes from each product line. Customer concentration — top ten customers as a percentage of total revenue. Profit center contribution — each profit center's share of total revenue. And monthly trends with year-over-year comparison.

**Stefan Richter** *[40:40]*: Customer concentration is one I watch closely. If Skymart Corp represents more than, say, fifteen percent of our revenue, I get nervous. We can't be over-dependent on any single customer.

**Danny Le** *[40:53]*: All of these are buildable from the data we've discussed. The dimensional model with the hierarchies gives us the drill-down naturally.

**Karen Liu** *[41:02]*: I want all fifteen in the new platform, plus the ability to drill down. That's the big upgrade. Right now, if I see Gross Margin is down, I have to go back to the raw data, manually filter by product line, by customer type, by profit center, to figure out where the issue is. It takes an hour. I want to click on the number and drill into it instantly.

**Priya Sharma** *[41:24]*: The drill-down is everything. Right now, an ad-hoc analysis that should take thirty seconds takes me an hour of pivot table gymnastics.

**Danny Le** *[41:34]*: We'll build the model so that every metric is drill-through enabled across all dimensions. Click Gross Margin, see it by product line. Click a product line, see it by customer type. Click a customer type, see individual customers. Full dimensional navigation.

**Karen Liu** *[41:51]*: That's exactly what I need.

**Amélie Théorêt** *[41:55]*: Good. Let's move to use cases now. Karen, I want to formalize the list we discussed informally during the kick-off and get explicit prioritization.

**Karen Liu** *[42:05]*: Ready.

**Amélie Théorêt** *[42:07]*: Use Case 1 — Monthly P&L by profit center. Generate a standard income statement for any profit center or group of profit centers, for any month or date range.

**Stefan Richter** *[42:19]*: High priority. That's the first thing I ask for every month-end.

**Karen Liu** *[42:23]*: High priority, no question. This is the report that takes Priya the longest to build.

**Priya Sharma** *[42:28]*: At least six hours per month for the full set. I build one P&L per product line group — Cruise, Mountain, Racing, Youth — plus the consolidated company-wide P&L. It's all manual. Copy the data, filter, pivot, format, repeat.

**Amélie Théorêt** *[42:45]*: Use Case 2 — Budget vs Actual variance analysis with drill-down. Compare actual results to budget at every level of the P&L and across all dimensions.

**Stefan Richter** *[42:57]*: High priority. This is how I hold the business accountable. Where are we off plan and why?

**Karen Liu** *[43:03]*: High. And I want both dollar variance and percentage variance side by side. A $50,000 variance in Gross Revenue means something different than a $50,000 variance in Travel expense.

**Amélie Théorêt** *[43:16]*: Use Case 3 — Revenue breakdown by product line and customer segment. Visualize how revenue distributes across Cruise, Mountain, Racing, Youth, and across Large, Speciality, Medium.

**Karen Liu** *[43:30]*: High priority. Relatively straightforward with the right data model — you're cross-referencing the product hierarchy with the customer type. But today it takes me an hour because I have to do the cross-tabulation manually.

**Amélie Théorêt** *[43:44]*: Use Case 4 — Gross margin analysis by product. Product-level profitability — which products have the highest and lowest margins.

**Danny Le** *[43:54]*: This is where having COGS at the product grain really pays off. We can match revenue and COGS at the individual product level.

**Karen Liu** *[44:02]*: Medium priority. Important for strategic product decisions, but I can live without it in Phase 1 if we get the top three working.

**Amélie Théorêt** *[44:11]*: Use Case 5 — Cash flow trending using the indirect method.

**Karen Liu** *[44:16]*: Medium priority. We have the CF accounts — CF_I, CF_CFO, CF_D — so the data supports it. But it's not the most frequently requested analysis.

**Amélie Théorêt** *[44:27]*: Use Case 6 — Operating expense analysis by category. Building vs Employee breakdown, trends in Payroll, Travel, Utilities.

**Stefan Richter** *[44:37]*: Medium. I look at this quarterly, not monthly. Important but not urgent.

**Karen Liu** *[44:42]*: Agreed, medium.

**Amélie Théorêt** *[44:44]*: And Use Case 7 — Customer profitability ranking. Rank customers by their contribution to gross margin.

**Karen Liu** *[44:52]*: Low priority. Phase 2 candidate. The data supports it — we track revenue and COGS at the customer level — but computing true customer profitability requires some allocation of shared costs, which is a whole separate exercise.

**Stefan Richter** *[45:06]*: Agreed, Phase 2. Let's walk before we run.

**Karen Liu** *[45:10]*: Honestly, if I could get UC1 and UC2 working first, that alone would save me two days a month. That's the ROI case right there — twenty-four analyst days per year returned to higher-value work.

**Danny Le** *[45:24]*: That's compelling. And the data model we build for UC1 and UC2 naturally supports UC3 as well — it's the same dimensional structure, just different slicing.

**Karen Liu** *[45:34]*: Exactly.

**Amélie Théorêt** *[45:37]*: Danny, any questions on the use cases?

**Danny Le** *[45:40]*: One clarification on UC2. Karen, when you say drill-down, do you mean within the P&L hierarchy only, or also across the other dimensions?

**Karen Liu** *[45:50]*: All dimensions. I want to start at Net Income, see the budget vs actual variance. Then drill into Gross Margin, see the variance there. Then slice by product line — is the variance coming from Cruise or Mountain? Then by customer type — is it a Speciality problem or a Large problem? Then by individual profit center. Full cross-dimensional navigation.

**Danny Le** *[46:11]*: That's what I expected. The data model supports it because every budget transaction carries the same dimensions as every actual transaction. We just need to make sure the UI handles the cross-filtering elegantly.

**Amélie Théorêt** *[46:25]*: Good. Let's cover business rules. This is the last major section before we wrap. Marcus, Karen — I want to document every data convention that could trip up the modeling or the analytics.

**Marcus Weber** *[46:38]*: Let me start with the hash convention since it's the most fundamental. The # symbol appears across all dimensions as the "Unassigned" member. When a transaction doesn't apply to a specific dimension, that field is set to #.

**Marcus Weber** *[46:54]*: The classic example is operating expenses. Payroll — FPA1/033 — has CUSTOMERID set to # and PRODUCTID set to #. Because payroll isn't customer-specific or product-specific. It's an organizational cost assigned to a profit center. The profit center dimension is always populated — even OpEx goes to a specific profit center.

**Lamia Benali** *[47:14]*: Should the analytics model display # as "Unassigned" in the UI?

**Karen Liu** *[47:19]*: Yes. Don't filter it out. If you remove hash transactions, your entire Operating Expense section disappears. It's meaningful data.

**Danny Le** *[47:28]*: We'll map # to a clean "Unassigned" label in the presentation layer, but keep it as a full dimension member.

**Marcus Weber** *[47:36]*: Next — the European number formatting in the VALUE column. I've covered this, but let me be completely explicit for documentation purposes. The decimal separator is a comma. "12734,04" is twelve thousand seven hundred thirty-four dollars and four cents. There's no thousands separator — just the decimal comma. Negative values have a minus prefix. "-5432,10" is negative.

**Danny Le** *[47:58]*: Replace comma with period, cast to numeric. We'll handle it in the ingestion layer.

**Marcus Weber** *[48:04]*: Third — dates as YYYYMMDD integers. 20210101 is January 1, 2021. 20200315 is March 15, 2020. Straightforward conversion to a date type.

**Marcus Weber** *[48:17]*: Fourth — hierarchy level numbering. Level 1 is the root, higher numbers are more granular. So in the GL hierarchy, Net Income at FPA1/08 is Level 1. EBIT at FPA1/09 is Level 2. Operating Income at FPA1/016 is Level 3. Down to the leaf accounts at the highest level numbers.

**Karen Liu** *[48:38]*: Let me add the profit center naming convention. The format is CountryCode underscore PC plus ProductLineCode plus SizeCode. US10_PCC1L breaks down as US for country, 10 for company code, PCC for the Cruise product line code, 1 is a sub-identifier, and L means Large channel. S means Small, which maps to Speciality in our business terminology.

**Danny Le** *[49:02]*: Is that documented anywhere formal?

**Karen Liu** *[49:05]*: In my head and now in your recording. We'll fix that.

**Marcus Weber** *[49:10]*: A few more conventions. Account naming — FPA1 slash three digits. The FPA1 prefix stands for Financial Planning and Analysis module 1. It's a BPC convention. The three digits are the account number within that module.

**Marcus Weber** *[49:25]*: Customer type codes — Z1, Z2, Z3. The Z prefix indicates SAP custom namespace. SAP reserves the Z and Y namespaces for customer-defined objects. So Z1, Z2, Z3 are VeloGroup's custom definitions, not SAP standard codes.

**Lamia Benali** *[49:40]*: Same for the product hierarchy nodes? ZCRUISE, ZMTN, ZRACING?

**Marcus Weber** *[49:45]*: Same principle. Z prefix means it's our custom hierarchy, not delivered by SAP.

**Lamia Benali** *[49:51]*: One last question on business rules. Are there any sign conventions I should know about? For example, are revenue amounts positive and expense amounts negative? Or are they all positive and the sign is determined by the account type?

**Karen Liu** *[50:03]*: Great question. In our extract, revenue is positive and COGS is positive. When you calculate Gross Margin, you subtract COGS from Net Revenue. The sign isn't embedded in the value — you apply it based on the P&L hierarchy structure. Revenue accounts add, cost accounts subtract.

**Danny Le** *[50:22]*: So the hierarchy implicitly defines the arithmetic. Gross Margin equals the sum of Net Revenue children minus the sum of COGS children.

**Karen Liu** *[50:30]*: Exactly. The hierarchy is both the display structure and the calculation structure.

**Amélie Théorêt** *[50:37]*: Perfect. Let's start wrapping up. We've covered a tremendous amount of ground today. Let me summarize the key takeaways.

**Amélie Théorêt** *[50:46]*: First — VeloGroup is a B2B cycling manufacturer with 53 customers across three segments. Speciality accounts for 66% of transactions, Large 31%, Medium under 1%. Four product lines — Cruise, Mountain, Racing, Youth — plus Finished Goods. Primarily US-based with some Canadian presence.

**Amélie Théorêt** *[51:06]*: Second — the financial structure is built around 21 GL accounts organized in a parent-child P&L hierarchy, from Net Income down through EBIT, Operating Income, Gross Margin, and Operating Expense. COGS dominates at 75% of all transactions. Revenue and COGS are at the full product-customer-profit center grain; Operating Expenses are at the profit center level with hash for customer and product.

**Amélie Théorêt** *[51:34]*: Third — the source data is a clean star schema. One fact table with 167,136 transactions — 61% budget, 39% actual. Eighteen dimension tables across four groups. Key data quirks: VARCHAR values with European comma formatting, dates as BIGINT, and hash as the universal unassigned marker.

**Amélie Théorêt** *[51:58]*: Fourth — the three high-priority use cases are monthly P&L by profit center, budget vs actual variance with drill-down, and revenue breakdown by product line and customer segment. Getting these working would save Karen's team two days per month and enable a three-day close.

**Amélie Théorêt** *[52:17]*: Fifth — profit center is the primary management reporting dimension. The hierarchy — US Division to product line to channel — is how Stefan manages the business.

**Stefan Richter** *[52:28]*: That's a good summary. I'll add — I see this project as an investment in how we run finance. If we automate the reporting, Karen and Priya can spend their time on analysis instead of spreadsheet mechanics. That's where the real value is.

**Karen Liu** *[52:44]*: And we won't lose work to Excel crashes anymore.

**Priya Sharma** *[52:48]*: That June incident still haunts me. Four hours of variance analysis, gone. I had to explain to Karen why the report was a day late.

**Karen Liu** *[52:56]*: You don't have to explain anymore after today, hopefully.

**Danny Le** *[53:01]*: From our side, I'm confident we have enough to start the data modeling. The entity structure is clean, the hierarchies are well-defined, the business rules are documented. Lamia and I will start with the FinancialTransactions fact table and build out the dimensional model around it.

**Lamia Benali** *[53:18]*: Marcus, can you get me the SAP extract files this week? I want to start data profiling immediately — validate row counts, check the value formatting, verify every foreign key relationship across all 18 dimension tables.

**Marcus Weber** *[53:32]*: I'll have them to you by Wednesday. I'll include a README with file names and table descriptions so you can orient yourself quickly.

**Lamia Benali** *[53:40]*: Perfect. I'll probably have follow-up questions once I dig into the data. Edge cases, join patterns, things like that.

**Marcus Weber** *[53:48]*: My door is open. Or my Slack, I should say.

**Amélie Théorêt** *[53:53]*: Next steps from the Maxa side — Danny and Lamia will begin data modeling and profiling. I'll produce the formal business discovery deliverables based on everything we covered today. We'll schedule a follow-up in about two weeks to review the initial data model and confirm the KPI definitions.

**Stefan Richter** *[54:10]*: Sounds good. I'm looking forward to seeing the first dashboard. This Excel situation has gone on long enough.

**Karen Liu** *[54:18]*: Amen to that.

**Amélie Théorêt** *[54:21]*: Thank you everyone. Excellent session. We covered all ten themes and we're in great shape to move forward. We'll be in touch this week with the discovery documents.

**Stefan Richter** *[54:31]*: Thanks, Amélie. Thanks, Danny and Lamia. Good to have you on board.

**Marcus Weber** *[54:36]*: Thanks all. Lamia, those files will be in your inbox Wednesday.

**Priya Sharma** *[54:41]*: Thank you. I cannot wait to stop being the VLOOKUP queen.

**Danny Le** *[54:45]*: We'll make it happen. Talk soon, everyone.

---

*[End of Workshop — 54:45]*
