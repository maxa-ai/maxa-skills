# VeloGroup -- Maxa Project Kick-Off

**Meeting Date:** September 15, 2025 - 10:00 AM EST

---

**Amelie Theoret** *[00:00]*: Good morning everyone, thank you so much for joining. Really excited to get this kicked off today. I'm Amelie Theoret, I'll be the Delivery Manager on the Maxa side, so I'm your primary point of contact throughout the engagement. Before we jump into the agenda, let's do a quick round of introductions so everyone knows who they're working with. Stefan, would you like to start?

**Stefan Richter** *[00:24]*: Sure, happy to. Stefan Richter, I'm the CFO here at VeloGroup International. I've been with the company going on eight years now. Before VeloGroup I was at a manufacturing firm in Stuttgart, so I bring a bit of that German engineering mindset to the finance side. I've watched VeloGroup grow from what was really a mid-size domestic cycling company to what we are now, which is a multi-region operation spanning the US, Canada, and we've got some European presence starting to form. I'm the executive sponsor for this project, and honestly, this has been on my wish list for about three years. So the fact that we're finally here is... it's exciting.

**Amelie Theoret** *[01:02]*: Three years! Well, we better make it worth the wait.

**Stefan Richter** *[01:05]*: Ha, no pressure at all.

**Karen Liu** *[01:08]*: Hi everyone. Karen Liu, VP of Financial Planning and Analysis. I've been at VeloGroup about five years now. My team is responsible for all the financial planning, the annual budgeting process, monthly reporting, variance analysis, really the full FP&A lifecycle. We are, I would say, extremely motivated to see this project succeed. We'll leave it at that for now.

**Amelie Theoret** *[01:32]*: Ha, I sense a story there. We'll dig into that.

**Danny Le** *[01:36]*: Looking forward to hearing it. I'm Danny Le, Analytics Lead on the Maxa side. I'll be doing the hands-on work around data modeling, building out the analytics platform, working closely with Karen and Marcus on understanding the data and translating it into something actionable. Really looking forward to getting into the details.

**Marcus Weber** *[01:55]*: And I'm Marcus Weber. I run the SAP landscape and IT infrastructure here at VeloGroup. Twelve years with the company, so I've been around since before we were even on SAP, which tells you something. I manage the whole SAP environment, integrations, data architecture, infrastructure. I'm basically the guy who knows where all the data lives and, unfortunately, where it tends to get stuck.

**Amelie Theoret** *[02:20]*: Perfect, great to have everyone here. So the agenda for today is fairly straightforward. We want to understand the project background, what's driving this initiative. Then we'll align on objectives and deliverables. We'll spend some time defining scope, what's in for Phase 1, what we're deferring. Marcus, we'll want to get a good overview of the system landscape. And then we'll wrap up with methodology, timeline, and governance. Should take us about an hour, maybe a little over. Sound good to everyone?

**Stefan Richter** *[02:50]*: Sounds good.

**Karen Liu** *[02:51]*: Perfect.

**Marcus Weber** *[02:53]*: Ready when you are.

**Amelie Theoret** *[02:55]*: Great. So Stefan, let's start with you. Set the stage for us. What's really driving this project? Why now?

**Stefan Richter** *[03:02]*: Right. So the short version is that VeloGroup has been on a growth trajectory, which is wonderful, but our ability to understand and analyze that growth from a financial perspective has not kept up. We've completed three acquisitions in the last six years. We started as a US-focused company making cycling products, and through those acquisitions we expanded into Canada and picked up some European distribution. Every time we bring on a new entity, Marcus and his team do a great job integrating it into SAP. But on the reporting and analytics side, we're still very much in a manual world.

**Karen Liu** *[03:40]*: "Very manual" is generous, Stefan.

**Stefan Richter** *[03:43]*: Ha, okay, fair. The reality is, when the board asks me a question like "what's our profitability on the Mountain bike line across all regions," I cannot answer that in real time. I have to go to Karen's team, they pull data from SAP, they massage it in spreadsheets, and maybe two to three days later I have an answer. At our current scale, with the complexity we have now, that's just not acceptable anymore.

**Amelie Theoret** *[04:08]*: Two to three days for a single profitability question?

**Karen Liu** *[04:12]*: It depends on the question, to be fair. If it's something we've already built a standing report for, we can usually turn it around same day. But anything ad hoc, anything that requires a different cut of the data or a dimension we haven't pre-built, yeah, two to three days is realistic. And that's assuming we don't discover a data discrepancy along the way, which... happens more than I'd like.

**Stefan Richter** *[04:35]*: And tell them about the month-end close.

**Karen Liu** *[04:38]*: Yes, so the month-end close is probably the biggest pain point for my team. The consolidation and reporting piece specifically. We're pulling data out of SAP, dumping it into Excel, and then manually consolidating across all our profit centers. Reconciling, checking for anomalies, formatting. That process alone takes about three days just for the P&L consolidation. Three days, every single month. And it's not like we have spare capacity, those are three days my analysts could be spending on actual strategic analysis instead of copy-pasting formulas.

**Danny Le** *[05:12]*: When you say consolidating across profit centers, how many profit centers are we talking about?

**Karen Liu** *[05:17]*: Thirty-seven.

**Marcus Weber** *[05:19]*: Thirty-seven active profit centers. Twenty-eight under the US Division, three under what we call the Global group, that's ZG in SAP, and then four under Logistics, which is Z_LOG.

**Danny Le** *[05:32]*: And each of those essentially has its own P&L that needs to roll up?

**Karen Liu** *[05:36]*: Effectively, yes. And we need to see the data at multiple levels. Individual profit center, by product line, by division, consolidated total. The roll-up logic is in people's heads and in their Excel formulas, not in any kind of automated system.

**Stefan Richter** *[05:52]*: Which is exactly why we're here. One of the things that keeps me up at night, frankly, is key-person risk. If Karen or one of her senior analysts left tomorrow, so much of the institutional knowledge about how we report and consolidate would walk out the door with them.

**Karen Liu** *[06:05]*: Well that's a cheery thought.

**Stefan Richter** *[06:08]*: I'm just being honest! It's a real risk.

**Amelie Theoret** *[06:12]*: It is, and it's actually one of the most common drivers we see for projects like this. Getting that logic out of spreadsheets and people's heads and into a sustainable platform. Okay, this is really helpful context. Let's dig into what success actually looks like. Stefan, if we fast-forward to the end of this engagement and everything went perfectly, what do you see?

**Stefan Richter** *[06:35]*: The primary objective is straightforward. I want a unified FP&A analytics platform that connects to our SAP financial data and gives us a single source of truth. No more Excel consolidation. No more three-day turnaround on basic questions. I want the finance team to be able to self-serve. When a product line manager wants to see their numbers, they should be able to go look, without filing a request with Karen's team.

**Karen Liu** *[07:00]*: Self-service is massive for us. Right now everything funnels through my team. Every question from every business unit leader, every regional manager, it all comes to us. We build the report, we send it back, they have follow-up questions, we build another report. If we could get to a place where, you know, the head of Mountain bikes can just log in and see their profitability, their budget variance, their customer mix, that frees up my team to do real analysis. Actual value-add work instead of being a report factory.

**Amelie Theoret** *[07:30]*: That's a great way to frame it. Danny, do you want to walk through the specific deliverables?

**Danny Le** *[07:36]*: Sure. Based on our pre-call conversations, here's what we're envisioning for deliverables. First and probably most important, a consolidated P&L dashboard with drill-down capability. You'd be able to start at the company-wide view and drill down into divisions, product lines, individual profit centers, customer segments.

**Karen Liu** *[07:56]*: And by product line, you mean our four main lines? Cruise, Mountain, Racing, and Youth?

**Danny Le** *[08:02]*: Exactly. And by customer segment, we're talking about your three tiers?

**Karen Liu** *[08:07]*: Yes. Z1, Z2, Z3 in SAP terms. Speciality, Large, and Medium. Speciality is our independent bike shops, the enthusiast retailers. Large is the big accounts, your Skymart Corp, Bigmart, CostClub. And Medium is, well, everything in between. Mid-size regional chains, that sort of thing.

**Stefan Richter** *[08:28]*: The profitability by product line is critical. I want to stress that. We've been having an internal debate for, I don't know, two years now about whether the Youth bike line is actually profitable on its own or if it's essentially a loss leader that drives foot traffic and brand loyalty for our other lines. And the honest answer is, right now, we genuinely cannot answer that question with confidence. We can't isolate the costs properly.

**Danny Le** *[08:55]*: That's a perfect use case for what we're building. So beyond the P&L dashboard, the other deliverables we're targeting: a balance sheet summary view, cash flow analysis using the indirect method, budget versus actual comparison reports with variance drill-down, and then the profitability analysis sliceable by product line, profit center, and customer segment.

**Stefan Richter** *[09:18]*: The budget versus actual is important. We go through an annual budget process, it takes months, and then once we have the budget, comparing it to actuals is... Karen?

**Karen Liu** *[09:28]*: Painful. The word is painful. We have both actual and budget data in SAP, but pulling them side by side and doing meaningful variance analysis is entirely manual. Every month I'm rebuilding the same comparison in Excel. And I mean literally rebuilding, because the way the data comes out of SAP, it's not in a format where I can just append a new month. I'm copying formulas, re-linking cells, praying nothing breaks. And then when there's a variance, inevitably someone asks "why is Mountain bikes over budget by 8%?" and then I'm back in SAP trying to drill down to the GL account level to figure out what happened.

**Amelie Theoret** *[10:05]*: So variance analysis with built-in drill-down would be significant.

**Karen Liu** *[10:09]*: It would change my life. Only slightly exaggerating. If I could click on a variance and immediately see whether it's being driven by a specific product, a specific customer, a specific GL account, that would save me probably ten to fifteen hours a month.

**Danny Le** *[10:25]*: Let me ask about the P&L structure specifically. When you think about the key line items, what are the ones that matter most?

**Karen Liu** *[10:32]*: Sure. So our top line is Gross Revenue, which in SAP maps to the hierarchy node FPA1/022. Below that we have Sales Deductions, that's FPA1/023, so your discounts, returns, customer allowances. Then COGS under FPA1/020. We look at margins at several levels going down through the P&L, all the way down to EBIT, which is FPA1/09, and ultimately Net Income at FPA1/08. Those hierarchy nodes are important because they define how the GL accounts roll up.

**Danny Le** *[11:05]*: And the account types? Marcus, you mentioned five types in our pre-call?

**Marcus Weber** *[11:10]*: Correct, five account types. Income, abbreviated INC. Expense, EXP. Assets, AST. Liabilities and Equity, LEQ. And then there's a Non-financial Income category, NFIN, which is a bit of a miscellaneous bucket for certain non-operating items.

**Danny Le** *[11:30]*: And total GL accounts?

**Marcus Weber** *[11:33]*: Twenty-one. It's a compact chart of accounts. Stefan made the decision years ago to keep it lean, which was smart. Some companies in our industry have hundreds of accounts and it becomes unmanageable.

**Stefan Richter** *[11:46]*: German efficiency. Keep things simple, keep them structured.

**Karen Liu** *[11:50]*: The simplicity of the chart of accounts is actually one of the few things that doesn't give me headaches. The hierarchy structure handles the roll-ups, so we get the detail where we need it without having an unwieldy account list.

**Amelie Theoret** *[12:02]*: Good, this is all really valuable. Let's shift gears to scope definition. This is where we want to be very clear about what's in for Phase 1 and what we're deliberately deferring. Danny?

**Danny Le** *[12:15]*: Right. So for Phase 1, here's what we're proposing as in-scope. Data source: SAP FI financial data. The core data model is a star schema with FinancialTransactions as the central fact table surrounded by dimension tables. We'll cover both Actual and Budget data, so two versions. All four product lines: Cruise, Mountain, Racing, Youth. All three customer segments: Speciality, Large, Medium. All profit centers, US Division, Global, and Logistics. Date range: fiscal 2018 through 2021 data. Monthly reporting granularity.

**Stefan Richter** *[12:55]*: What's the total data volume we're looking at?

**Marcus Weber** *[12:58]*: The FinancialTransactions table has about 167,000 records total. Breaking that down, roughly 64,756 are actual transactions and about 102,380 are budget entries. Budget tends to have more records because we budget at a more granular level in certain areas, more line items, more monthly breakdowns.

**Danny Le** *[13:20]*: That's a very manageable volume from a processing standpoint. No concerns there at all. And the date range, April 2018 through January 2021, is that right?

**Marcus Weber** *[13:30]*: That's correct. Fiscal year runs on a calendar year basis, so December 31 year-end. The data starts in April 2018 because that's when we completed the SAP migration from the legacy system. Prior to that... the data is in the old system and it's, um...

**Stefan Richter** *[13:47]*: It's a mess. Let's not open that can of worms.

**Marcus Weber** *[13:50]*: I was going to say "not easily accessible," but yes, it's a mess.

**Karen Liu** *[13:54]*: I tried to pull some legacy data for a board comparison last year. Once. I will not be doing that again.

**Amelie Theoret** *[14:00]*: Noted. April 2018 is our starting boundary. Good. Now let's be explicit about what's out of scope for Phase 1 so there are no surprises. Danny?

**Danny Le** *[14:12]*: So the following are deferred to Phase 2 or beyond. First, forecast and rolling forecast versions. If you have forward-looking data beyond the annual budget, that's not Phase 1. Second, operational data, so supply chain, inventory, manufacturing data. Third, HR and workforce analytics. Fourth, detailed tax reporting. And fifth, real-time data feeds. For Phase 1, batch processing with scheduled refreshes is the approach. We're not doing live streaming from SAP.

**Stefan Richter** *[14:45]*: The forecast piece, I want to flag that for the record. We're in the middle of implementing a rolling forecast methodology here. It's not in SAP yet, we're still designing the process, but when it's ready, I'll want it integrated. So it's definitely a Phase 2 priority.

**Amelie Theoret** *[15:02]*: Absolutely, we'll document it as a Phase 2 priority item. Karen, anything else you'd want to flag for future phases?

**Karen Liu** *[15:10]*: Two things. First, I'd eventually love to get operational data in there. When I'm looking at a COGS variance, it would be incredible to drill down into what's actually happening at the manufacturing level, raw material cost fluctuations, labor costs, production yields. Right now I just see the aggregated COGS number and have to go hunting separately for the why.

**Danny Le** *[15:32]*: Yeah, that would require integrating SAP CO or MM modules, which is a whole different data domain. Good Phase 2 candidate.

**Karen Liu** *[15:40]*: And second, I know this is way down the road, but the ability to do some predictive analytics would be amazing. Like, based on current trends, where are we likely to end the year relative to budget. But that's probably Phase 3 territory.

**Amelie Theoret** *[15:55]*: It's great to think ahead like that, but yes, let's nail the foundation first. Phase 1 gives you the historical and current-state visibility, and then we build predictive on top of that later.

**Marcus Weber** *[16:05]*: I just want to add, from a technical standpoint, staying within SAP FI for Phase 1 is the right call. The FI data is clean, it's well-structured, the star schema is solid. Once you start pulling from other modules, CO, MM, SD, the data quality questions multiply significantly. There are more edge cases, more reconciliation issues. FI is our most reliable data.

**Amelie Theoret** *[16:28]*: That's good to hear. And it gives us a clean foundation to build on. Okay, so we're aligned on scope boundaries. Let's dig into the system landscape. Marcus, this is your moment. Walk us through what we're working with.

**Marcus Weber** *[16:45]*: Alright, so as Danny mentioned, we have a classic star schema design in SAP FI. The central fact table is FinancialTransactions. Each record represents a financial posting, essentially a line item. It carries foreign keys to the dimension tables, plus the amount value, the posting date, and a version indicator that tells you whether it's an actual or budget entry.

**Danny Le** *[17:08]*: How many dimension tables in total?

**Marcus Weber** *[17:11]*: Eighteen. They're organized into four logical groups. First group is GL Accounts, that's five tables: the main GL accounts dimension, the account types table, a text table for multilingual descriptions, an account hierarchy table, and a hierarchy node table. Second group is Customers, also five tables following the same pattern. Third is Products, five tables. And then Profit Centers, which has three tables, the main dimension, a text table, and a hierarchy table.

**Danny Le** *[17:45]*: Let me make sure I understand the pattern. For each dimension group, you have the base dimension, a type or category table, a text table for language-specific descriptions, and then hierarchy tables?

**Marcus Weber** *[17:58]*: Exactly. Well, the type table is only on GL Accounts. But otherwise yes, that's the pattern. It's standard SAP convention. The text tables are particularly important because they store descriptions in multiple languages. We maintain English and German, so language codes EN and DE. To get the English description of, say, a GL account, you join the text table filtering on language equals EN.

**Danny Le** *[18:22]*: The German descriptions, is that because of Stefan's heritage, or...?

**Stefan Richter** *[18:26]*: Ha, I wish I could take credit. No, it's because our original parent company was German. When we set up SAP, we maintained both languages. Honestly, we could probably drop the German at this point, but Marcus won't let me.

**Marcus Weber** *[18:38]*: It's a SAP best practice! You never know when you might need it. Plus, some of our European contacts actually do use the German descriptions.

**Amelie Theoret** *[18:47]*: For our purposes, we'll default to English descriptions in the analytics layer, but it's good to know both are there.

**Danny Le** *[18:55]*: Tell me about the hierarchy structures. Those seem central to the reporting requirements Karen described.

**Marcus Weber** *[19:02]*: They are, yes. We have hierarchies on three dimensions. The GL account hierarchy is probably the most important one, it defines the P&L structure. Individual GL accounts roll up through hierarchy nodes into subtotals like Gross Revenue, COGS, Operating Expenses, and ultimately to EBIT and Net Income. So when Karen says she wants to see the P&L, the structure of that P&L is defined by the GL account hierarchy.

**Karen Liu** *[19:30]*: Right, and the hierarchy nodes I mentioned earlier, FPA1/022 for Gross Revenue, FPA1/020 for COGS, those are nodes in that hierarchy. They're not actual GL accounts themselves, they're the roll-up points.

**Danny Le** *[19:45]*: Got it. So a leaf account posts actual transactions, and the hierarchy tells us how to aggregate.

**Marcus Weber** *[19:52]*: Precisely. Then we have the product hierarchy, which goes from individual products, we have thirty-five of those, up through eight product categories and into the four product lines. And the profit center hierarchy, which organizes profit centers under the US Division, then by product line and size designation.

**Karen Liu** *[20:10]*: Can you explain the profit center naming convention, Marcus? Because that one confuses even me sometimes.

**Marcus Weber** *[20:16]*: Sure. It's a bit technical. Under the US Division, profit centers are coded as US10 followed by the product line and size. So US10_PCC1L means US Division, Cruise Cycles, Large. PCC1 is Cruise, PCC2 is Mountain, PCC3 is Racing, PCC4 is Youth. And then L for Large, S for Small. So if you see US10_PCC2S, that's Mountain bikes, Small. Under the Global group, ZG, there are three profit centers. And under Logistics, Z_LOG, there are four.

**Danny Le** *[20:52]*: And the Large versus Small designation, what does that represent operationally?

**Marcus Weber** *[20:57]*: It's a volume classification. Large profit centers handle the higher-volume product variants, small handles the niche or specialty products. It determines cost allocation and resource planning.

**Stefan Richter** *[21:08]*: It also roughly correlates to our customer segmentation. The large profit centers tend to service our Large tier customers, your Skymarts and Bigmarts, while the small ones are more aligned with the Speciality tier, your TechCycles and independent shops.

**Danny Le** *[21:25]*: That's useful context. Okay, let me ask about some SAP-specific conventions because these are going to matter a lot in the data transformation layer. The hash symbol?

**Marcus Weber** *[21:36]*: Ah, the infamous hash. So in SAP, when a dimension value is unassigned, it's represented by the hash character, the number sign. If a financial transaction doesn't have a customer assigned, the customer foreign key will just be the hash symbol. You'll see this across all dimensions. And this is important, you can't just filter those out because some of those unassigned records are perfectly legitimate financial postings. Things like overhead allocations, intercompany entries, they may not have a customer or product dimension, but the financial values are real and need to appear in the consolidated view.

**Danny Le** *[22:12]*: Makes sense. We'll handle that in the Transform layer, probably map it to a descriptive label like "Unassigned" or "Not Applicable" in the reporting.

**Marcus Weber** *[22:22]*: Right. Now, the amount values, this is one that always trips people up. The amounts are stored as VARCHAR, not as a numeric type.

**Danny Le** *[22:32]*: Stored as strings?

**Marcus Weber** *[22:34]*: Yes. And they use European comma formatting. So what you'd write as twelve thousand seven hundred thirty-four dollars and four cents would be stored as the string "12734,04" with a comma as the decimal separator. No thousands separator.

**Danny Le** *[22:50]*: So we need a VARCHAR-to-numeric conversion with a comma-to-period swap. Classic ETL challenge but straightforward.

**Marcus Weber** *[22:58]*: Exactly. And dates, the date field is stored as BIGINT in YYYYMMDD format. So today, September 15, 2025, would be the integer 20250915.

**Danny Le** *[23:10]*: We've seen this pattern in other SAP implementations. It's consistent, which is what matters.

**Marcus Weber** *[23:16]*: That's what I always say. It may not be intuitive, but at least it's consistent. I'll take consistent over intuitive any day.

**Amelie Theoret** *[23:24]*: Danny, any other data questions before we move on?

**Danny Le** *[23:28]*: Actually yes, a few more. Marcus, can you give us the dimension cardinalities? Number of customers, products, that kind of thing. Helps me think about the data model.

**Marcus Weber** *[23:38]*: Sure. Fifty-three customers total, spread across the US and Canada. Karen mentioned the big ones, Skymart Corp, Bigmart, CostClub in the Large tier. Then you've got specialty retailers like TechCycle in the Speciality tier. And the medium accounts, regional chains, that sort of thing.

**Karen Liu** *[23:58]*: Oh, and this is something I've been wanting to analyze. The specialty shops have much higher margins per unit than the large retailers. We give the big box stores significant volume discounts through Sales Deductions, which is that FPA1/023 node. So the question is, what's actually more profitable, high volume at lower margin through Skymart, or lower volume at higher margin through the specialty channel? I've been trying to answer that question for two years.

**Stefan Richter** *[24:25]*: It's the question, really. And it has direct implications for our go-to-market strategy. If the specialty channel is significantly more profitable per unit, maybe we should be investing more there instead of chasing the next big box contract.

**Danny Le** *[24:40]*: That's a great analysis to build into the profitability dashboards. What about products?

**Marcus Weber** *[24:46]*: Thirty-five products across eight categories, rolling up into the four product lines. Cruise bikes, Mountain bikes, Racing bikes, Youth bikes. Within each line you've got various models and variants. And we've got the e-bike models too, E101 and E102, which have been gaining a lot of traction.

**Stefan Richter** *[25:05]*: The e-bikes are our fastest-growing segment, actually. Revenue on e-bikes grew, what was it Karen, around 40% last year?

**Karen Liu** *[25:14]*: Something like that, yeah. The challenge is, I can tell you the top-line revenue because I've manually tracked it, but I can't give you a proper margin analysis because the cost allocation across profit centers isn't something I can easily extract from my spreadsheets. That's exactly the kind of thing this project should solve.

**Danny Le** *[25:32]*: It will. GL accounts, Marcus, twenty-one total and five account types, right?

**Marcus Weber** *[25:38]*: Correct. Twenty-one GL accounts, five account types. It's compact. The hierarchy does all the heavy lifting for the P&L structure. You don't need hundreds of accounts when you have a well-designed hierarchy.

**Danny Le** *[25:52]*: Agreed, and from a modeling perspective, that's actually ideal. Smaller, well-structured dimensions mean cleaner joins, faster queries, and the hierarchy gives you all the analytical flexibility without bloating the base tables.

**Amelie Theoret** *[26:05]*: Okay, I want to make sure we have enough time for methodology and next steps. Let me walk through how we typically approach a project like this, and then we'll talk timeline and governance. Sound good?

**Stefan Richter** *[26:18]*: Yes, please. I need to brief the board on the approach and timeline.

**Amelie Theoret** *[26:24]*: So at Maxa, we follow a six-phase methodology: Discover, Design, Build, Test, Deploy, and Support. We're currently at the very beginning of the Discover phase. This kick-off is step one. The Discover phase is where we deeply understand your business, your data structures, your reporting requirements, your pain points. After today, we'll do a much more detailed FP&A workshop where we go deep on the financial structures, the exact P&L format you want, the calculations, the specific metrics.

**Danny Le** *[26:58]*: On the data architecture side, we use what we call the UBDM approach. It has three layers. First is the Raw layer, sometimes called R, where we land the data exactly as it comes out of SAP. No transformations, no cleaning, just a faithful copy. Second is the Transform layer, T, where we do all the data engineering work: converting those VARCHAR amounts to proper numeric types, parsing the BIGINT dates into real date fields, resolving the hash symbols, building out proper relational structures, standardizing naming conventions. And third is the Metrics layer, where we define the business calculations, KPIs, and measures that actually appear in dashboards.

**Karen Liu** *[27:42]*: So the Transform layer is where you'd handle the European comma formatting?

**Danny Le** *[27:46]*: Exactly. By the time data reaches the Metrics layer, everything is clean, properly typed, and ready for analysis. You should never have to think about SAP conventions when you're looking at a dashboard.

**Karen Liu** *[27:58]*: That sounds... honestly, that sounds like a dream. Right now I spend a non-trivial amount of time every month just dealing with data formatting issues in my spreadsheets. Commas versus periods, date parsing errors, missing dimension labels.

**Marcus Weber** *[28:12]*: I've offered multiple times to build views in SAP to handle some of that cleanup, but we've never had the bandwidth to properly spec out what Karen needs.

**Karen Liu** *[28:22]*: I know, Marcus. It's not a criticism. We've just always had more urgent fires to fight. And honestly, this approach is better because it keeps the transformation outside of SAP, so we're not adding complexity to the production system.

**Marcus Weber** *[28:34]*: Fair. I do prefer keeping SAP clean.

**Amelie Theoret** *[28:38]*: That's a core principle for us too, Marcus. We don't touch the source system. All transformation happens in our layer.

**Stefan Richter** *[28:46]*: Good. Now, what does the timeline look like? I need to set expectations with the board.

**Amelie Theoret** *[28:52]*: So the Discover and Design phases together typically run three to four weeks. That's where we do the detailed data analysis, build the conceptual data model, validate it with your team, and design the dashboard layouts and metrics. Then the Build phase is usually four to six weeks depending on complexity. In your case, with a clean star schema, well-defined hierarchies, and a manageable data volume of 167,000 records, I'd lean toward the shorter end of that range. Test and Deploy are another two to three weeks.

**Stefan Richter** *[29:25]*: So we could be looking at something live within, what, ten to twelve weeks? Two and a half to three months?

**Amelie Theoret** *[29:32]*: That's a reasonable expectation, yes. And importantly, we don't make you wait until the end to see anything. We'll have working prototypes early in the Build phase.

**Karen Liu** *[29:42]*: How early? Like, when would I first see an actual dashboard?

**Amelie Theoret** *[29:47]*: If we move through Discover and Design on schedule, you could see a working P&L dashboard prototype within five to six weeks from today.

**Karen Liu** *[29:55]*: Five to six weeks? I was genuinely bracing myself for six months. Are you serious?

**Amelie Theoret** *[30:00]*: Dead serious. It won't have every bell and whistle, but it'll be real data, real drill-down, real functionality.

**Stefan Richter** *[30:08]*: That's excellent. The sooner we get something tangible in front of the business unit leaders, the sooner we build buy-in. There's a certain amount of skepticism internally about analytics projects. People have been burned before by promises that took forever to deliver. If we can show something real in six weeks, that changes the conversation entirely.

**Danny Le** *[30:28]*: And just to set expectations properly, that first prototype will be the core P&L with basic drill-down by profit center and product line. We'll iterate from there. Budget versus actual comparison, cash flow analysis, the more advanced profitability views, those come in subsequent iterations within the Build phase.

**Karen Liu** *[30:48]*: Can I give input on the design? Like, I have very specific ideas about how I want the P&L laid out, what the column headers should be, how variances should be displayed.

**Amelie Theoret** *[30:58]*: Absolutely. That's exactly what the Design phase is for, and why we want you deeply involved. We'll do design review sessions where you see mockups before we build anything. This is collaborative, not a black box.

**Karen Liu** *[31:10]*: Good. Because I've seen analytics projects where the consultants disappear for three months and come back with something that looks nothing like what the business needs.

**Amelie Theoret** *[31:19]*: Not how we operate. You'll be sick of hearing from us by the end.

**Stefan Richter** *[31:24]*: Ha, I doubt that.

**Amelie Theoret** *[31:28]*: Alright, let's talk governance. How we're going to work together day to day, who talks to whom, how we escalate. We'd like to set up a weekly touchpoint meeting. This would be with Karen and Marcus primarily, and Danny and me from the Maxa side. Thirty to forty-five minutes, standing agenda: progress update, blockers, decisions needed, preview of upcoming work. What day works?

**Karen Liu** *[31:55]*: Wednesdays are consistently open for me. Marcus?

**Marcus Weber** *[31:58]*: Wednesdays work. Morning or afternoon?

**Amelie Theoret** *[32:02]*: Let's say 10 AM. Gives everyone time to get settled in the morning. Then separately, we'd do a monthly steering committee with Stefan. More strategic: are we on track overall, any scope decisions needed, risks or opportunities.

**Stefan Richter** *[32:18]*: Monthly is fine. But if something comes up that's truly urgent, a scope question, a major blocker, anything that could impact timeline, don't wait for the monthly meeting. Send me an email or grab me on Teams. I'd rather know about problems early.

**Amelie Theoret** *[32:34]*: Agreed, same philosophy on our side. For day-to-day communication, Teams is the primary channel. I'll set up a dedicated project channel. Karen and Marcus, you two would be the primary contacts on the VeloGroup side. Marcus, if we need data access, extracts, SAP-related questions, that goes through you?

**Marcus Weber** *[32:55]*: Yes, and I can loop in my database admin if needed for anything infrastructure-related. For the initial data extract, I should be able to get you the full dataset within a week. The star schema is well-defined, the exports are pretty straightforward.

**Danny Le** *[33:10]*: That would be great. I'd want the full FinancialTransactions fact table plus all eighteen dimension tables. That gives us everything we need to start the detailed data profiling and analysis.

**Marcus Weber** *[33:22]*: What format?

**Danny Le** *[33:24]*: CSV is fine for the initial load.

**Marcus Weber** *[33:27]*: Easy enough. I'll aim for Monday or Tuesday of next week.

**Danny Le** *[33:32]*: Perfect.

**Amelie Theoret** *[33:35]*: Okay, let me lay out the concrete next steps so everyone's clear. First, Marcus will prepare the data extract, targeting early next week. Second, I'll send out meeting notes from today by end of day tomorrow. Third, I'll also send a workshop preparation guide for the next session. Fourth, we need to schedule the next meeting, which will be a deeper Business Review and FP&A Workshop, the real deep-dive into the financial structure.

**Karen Liu** *[34:00]*: What should I prepare for that workshop?

**Amelie Theoret** *[34:04]*: Great question. If you could bring your current monthly P&L report, even the Excel version, that will help us understand how you think about the data and what the target layout should look like. Also, any recurring questions the board asks that you currently struggle to answer. Those become our design requirements. If you have any example variance analyses or profitability reports, even rough ones, bring those too.

**Karen Liu** *[34:30]*: I can definitely do that. I'll put together a package. Fair warning, the Excel file is a bit of a monster.

**Danny Le** *[34:38]*: Monsters are fine. We've seen worse, I promise.

**Karen Liu** *[34:42]*: Don't be so sure.

**Stefan Richter** *[34:44]*: When are we thinking for the next workshop?

**Amelie Theoret** *[34:47]*: If Marcus gets us the data early next week, Danny can do a preliminary analysis over a few days, and then we hold the FP&A deep-dive the following Wednesday. So tentatively September 24th.

**Danny Le** *[35:00]*: That works for me. Having the data beforehand means I can come in with informed questions rather than spending half the workshop just understanding the table structures.

**Marcus Weber** *[35:12]*: I'll make Monday my target for the extract.

**Stefan Richter** *[35:16]*: Should I be at the FP&A workshop?

**Amelie Theoret** *[35:19]*: It's optional for you, Stefan. It'll be fairly technical, we'll be getting into the weeds of account structures, hierarchy node mappings, specific calculation logic. Karen and Marcus can represent the business and technical perspectives.

**Stefan Richter** *[35:32]*: I'll skip it then and let them handle it. Just make sure I get the summary. And Karen, if anything comes up where we need to make a strategic call about scope or priority, pull me in.

**Karen Liu** *[35:43]*: Of course.

**Amelie Theoret** *[35:46]*: Oh, one more thing. For the workshop, it would be helpful if Marcus could prepare a simple data dictionary or at least a list of the dimension table names and their key columns. Nothing fancy, just enough so Danny and I can orient ourselves before the session.

**Marcus Weber** *[36:02]*: I can do that. I'll include it with the data extract. I'll also document the SAP naming conventions, the hash symbol handling, the VARCHAR amounts, the BIGINT dates, so your team doesn't have to rediscover all of that.

**Danny Le** *[36:16]*: That would be incredibly helpful. Thank you, Marcus.

**Karen Liu** *[36:20]*: Oh, I just remembered something I wanted to mention. When we're building out the P&L analytics, we have some derived metrics that are really important to us. Gross margin as a percentage, contribution margin by product line, COGS as a percentage of revenue compared across customer segments. Right now I calculate all of those manually in Excel, but having them built directly into the analytics platform would be a huge improvement.

**Danny Le** *[36:46]*: Absolutely, those are textbook Metrics layer calculations. We'll capture the full list and the exact formulas during the FP&A workshop and make sure they're built into the data model.

**Karen Liu** *[36:58]*: The formulas aren't complicated individually. It's the fact that I have to apply them across thirty-seven profit centers, four product lines, three customer segments, and two versions every single month. That's what kills us.

**Stefan Richter** *[37:12]*: And that's exactly why we need this platform. The math isn't hard. The scale of applying it consistently across every dimension, every month, that's the problem.

**Amelie Theoret** *[37:22]*: Well said. And that's exactly what we'll solve. Okay, let me do a final summary to make sure we're all aligned. The project objective is to build a unified FP&A analytics platform sourced from VeloGroup's SAP FI data. Phase 1 covers actual and budget data, fiscal 2018 through 2021, all four product lines, all three customer segments, all thirty-seven profit centers. Key deliverables: P&L dashboard with drill-down, balance sheet summary, cash flow analysis using indirect method, budget versus actual variance reports, and profitability analysis sliceable by product line, profit center, and customer segment. Timeline: initial prototype within five to six weeks, full Phase 1 delivery within approximately three months. Governance: weekly Wednesday touchpoints with Karen, Marcus, Danny, and me; monthly steering with Stefan. Next session: Business Review and FP&A Workshop, tentatively September 24th.

**Stefan Richter** *[38:15]*: That's a comprehensive summary. I'm feeling good about this. It's been a long time coming and it sounds like you have a solid approach.

**Karen Liu** *[38:24]*: Same. I'm genuinely excited, which I don't say lightly about analytics projects. I've been burned before. But this feels like the right approach with the right team.

**Marcus Weber** *[38:34]*: I'm looking forward to getting you the data. The SAP system has excellent data, it really does. The problem has always been accessibility. It's like we've built this beautiful library and then locked all the doors.

**Danny Le** *[38:48]*: Well, we're here to open those doors.

**Stefan Richter** *[38:52]*: Not just open them, build windows too. I don't just want access, I want visibility. I want to be able to see across the entire business from my desk.

**Amelie Theoret** *[39:00]*: We'll get you there. Alright everyone, thank you for a really productive kick-off. I'll have the meeting notes and workshop prep guide out by end of day tomorrow. Talk to you all soon.

**Stefan Richter** *[39:12]*: Thank you, Amelie. Thank you, Danny. Looking forward to the next session.

**Karen Liu** *[39:17]*: Thanks everyone. This was great.

**Marcus Weber** *[39:20]*: Thanks, I'll get started on those extracts this afternoon. Talk soon.

**Danny Le** *[39:25]*: Thanks all. Looking forward to seeing the data, Marcus. Don't hesitate to reach out if you have any questions about what to include.

**Marcus Weber** *[39:32]*: Will do.

**Amelie Theoret** *[39:34]*: Take care everyone. Bye for now.

---

*Meeting ended at 10:40 AM EST*
