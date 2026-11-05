-- Seed content: off-grid / regenerative-living Resources + Forum posts.
-- guest_name = 'admin' per owner's explicit instruction. status = 'approved' so entries
-- are immediately visible on the live site. Framing: someone starting completely from
-- zero (no land yet, no systems yet), building both a practical resource library and
-- open discussion threads so the community can add local knowledge, links and experience.

-- ============================= RESOURCES =============================

insert into public.resources (title, category, description, tags, location, link, guest_name, status) values

-- 1. Land & Location
('Buying Raw Land for an Off-Grid Start: What to Check Before You Sign',
 'Land & Location',
 'If you are starting with nothing but an idea, the land decision comes first and is the hardest to undo. Before you fall in love with a view, check: legal access (a real recorded road, not a handshake), water rights and whether there is a well, spring or year-round creek, soil quality, zoning and any building-permit restrictions, fire and flood risk, and how far you really are from a hospital and a hardware store. This magazine archive collects practical land-buying columns written by people who have actually done it.',
 array['land','off-grid','starting-from-zero','checklist'],
 null,
 'https://www.motherearthnews.com/tag/buying-land/',
 'admin','approved'),

('Real Stories From People Who Actually Bought Raw Land',
 'Land & Location',
 'A long-running discussion thread from the permies.com homesteading community, where people share what they wish they had known before buying their land: surprise easements, bad soil tests, neighbors who matter more than you think, and how long it actually took to get water and power sorted. Worth reading end to end before you go land-shopping.',
 array['land','community-knowledge','starting-from-zero'],
 null,
 'https://permies.com/t/60797/Top-Tips-Buying-Raw-Land',
 'admin','approved'),

-- 2. Building a Village From Scratch
('Open Source Ecology: Open-Source Blueprints for Building Civilization From Scratch',
 'Building a Village',
 'Open Source Ecology (OSE) is a real, ongoing project to design and publish free, open-source blueprints for the machines a self-sufficient village actually needs: tractors, compressed-earth brick presses, sawmills, and more — their "Global Village Construction Set." This is the closest thing that exists to a literal how-to-build-a-village-from-zero toolkit, documented in the open so anyone can build or improve on it.',
 array['village-building','open-source','carpentry','tools','starting-from-zero'],
 null,
 'https://en.wikipedia.org/wiki/Open_Source_Ecology',
 'admin','approved'),

('The Global Village Construction Set — Official Build Documentation',
 'Building a Village',
 'The OSE project''s own wiki page for the Global Village Construction Set (GVCS): the actual list of machines and structures in the set, with links out to their individual build documentation. This is the primary source, not a summary of it — start here if you want real specs rather than an overview.',
 array['village-building','open-source','construction'],
 null,
 'https://wiki.opensourceecology.org/wiki/50',
 'admin','approved'),

-- 3. Solar Installation
('Off-Grid Solar, Explained by a State Energy Office',
 'Solar Energy',
 'A plain, non-salesy explanation of how an off-grid solar system is put together — panels, charge controller, battery bank, inverter — and how it differs from a grid-tied system, published by a US state energy office rather than a company trying to sell you panels.',
 array['solar','off-grid','how-it-works','installation'],
 null,
 'https://solar.sc.gov/choosing-system/off-grid',
 'admin','approved'),

('How to Size Your Battery Bank (So You Do Not Overbuild or Underbuild)',
 'Solar Energy',
 'A practical walkthrough of the actual math behind sizing an off-grid battery bank: daily watt-hour load, days of autonomy you want, depth of discharge, and how those numbers turn into a battery-bank size. From an established off-grid solar retailer''s technical library — useful for a real first estimate before you buy anything.',
 array['solar','battery-sizing','DIY','installation'],
 null,
 'https://www.wholesalesolar.com/solar-information/battery-bank-sizing',
 'admin','approved'),

-- 4. Solar-Powered Bitcoin Mining
('A Real Proof-of-Concept: Bitcoin Mining Powered by Solar + Battery Storage',
 'Solar-Powered Bitcoin Mining',
 'Coverage from an energy-industry trade publication of an actual solar-plus-battery bitcoin-mining proof of concept. Useful as a sanity check on what is realistic today — mining with solar is possible but intermittent, and the economics depend heavily on your panel cost, battery cost, and local sun hours, not just the price of bitcoin.',
 array['bitcoin-mining','solar','case-study'],
 null,
 'https://www.energy-storage.news/green-bitcoin-mining-proof-of-concept-using-tesla-solar-and-battery-storage',
 'admin','approved'),

('Off-Grid / Solar-Direct Mining Calculator',
 'Solar-Powered Bitcoin Mining',
 'A calculator from a mining-hardware vendor for estimating what a solar-direct or off-grid mining setup could realistically produce, given your panel wattage and local conditions. It is a vendor tool, not neutral research, so treat its numbers as a starting estimate to sanity-check against your own panel and hash-rate figures, not a guarantee.',
 array['bitcoin-mining','solar','calculator','tool'],
 null,
 'https://d-central.tech/off-grid-solar-mining-calculator/',
 'admin','approved'),

-- 5. No-Pesticide Permaculture
('Beneficial Insects for Natural Pest Control (USDA-Funded SARE Program)',
 'No-Pesticide Permaculture',
 'A field guide, from the USDA-funded Sustainable Agriculture Research & Education (SARE) program, for identifying and attracting the beneficial insects that do your pest control for you — ladybugs, lacewings, parasitic wasps and more — instead of reaching for a pesticide. This is the kind of foundation knowledge a pesticide-free growing system is actually built on.',
 array['permaculture','pest-control','no-pesticide','beneficial-insects'],
 null,
 'https://projects.sare.org/information-product/beneficial-insects-for-natural-pest-control-foliage-scouting/',
 'admin','approved'),

('Ongoing Natural Pest Control Discussions (permies.com)',
 'No-Pesticide Permaculture',
 'The most-active natural pest-control threads from the permies.com permaculture forum — thousands of real growers troubleshooting specific pests (codling moth, leafcutter ants, aphids) without chemicals. Good for the specific problem you actually have, not just general theory.',
 array['permaculture','pest-control','community-knowledge'],
 null,
 'https://permies.com/forums/bestTopics/bestList/forum/ever/116',
 'admin','approved'),

-- 6. Natural Building
('Earthbag Construction — Overview',
 'Natural Building',
 'Earthbag building uses polypropylene or burlap bags filled with on-site soil, tamped in place, to build load-bearing walls and foundations cheaply and with very low embodied energy. This overview covers the technique, its history, and where it holds up well (and where it does not) compared to cob or straw bale.',
 array['natural-building','earthbag','low-cost'],
 null,
 'https://en.wikipedia.org/wiki/Earthbag_construction',
 'admin','approved'),

('Step-by-Step Earthbag Building (Instructables)',
 'Natural Building',
 'An actual walk-through build log, photographed step by step, from laying out the foundation trench to tamping the final courses. Good as a first real look at what the physical process involves before you commit to a design.',
 array['natural-building','earthbag','DIY','how-to'],
 null,
 'https://www.instructables.com/Step-by-Step-Earthbag-Building/',
 'admin','approved'),

-- 7. Food Forests
('Food Forests: A University Extension Guide',
 'Food Forests',
 'A practical guide from a university agricultural extension office on designing a food forest from an empty plot: the canopy/understory/shrub/groundcover layering concept, species selection by climate, and realistic timelines for when you actually start harvesting. More grounded than most blog content on the topic.',
 array['food-forest','permaculture','starting-from-zero'],
 null,
 'https://extension.sdstate.edu/sites/default/files/2026-06/MC-04302-v2.pdf',
 'admin','approved'),

('The Seven Layers of a Food Forest, Explained',
 'Food Forests',
 'A clear walkthrough of the seven-layer food-forest design concept (canopy, sub-canopy, shrub, herbaceous, groundcover, root, and vine) with examples of which plants typically fill each layer. Written by a plant nursery, so cross-check specific species against your own climate zone.',
 array['food-forest','permaculture','design'],
 null,
 'https://blog.teamgrow.us/blog/the-seven-layers-of-a-food-forest-create-a-thriving-backyard-ecosystem',
 'admin','approved'),

-- 8. Soil Health & Copper — Fact vs. Folklore
('The Real Science: Copper Fungicides, Soil Accumulation and Soil Life',
 'Soil Health & Copper',
 'Copper-based fungicides (like Bordeaux mixture) are genuinely widely used in organic farming because they work against fungal disease. The peer-reviewed research is also clear that copper accumulates in soil over repeated applications and can measurably harm soil microbial life and earthworms at high concentrations. This is the real, evidence-based copper-and-soil story — worth reading before treating copper as either a miracle or a myth.',
 array['soil-health','copper','fungicide','peer-reviewed'],
 null,
 'https://link.springer.com/content/pdf/10.1007%2Fs13593-018-0503-9.pdf',
 'admin','approved'),

('Copper Tools and "Energy": Checking the Biodynamic Claims',
 'Soil Health & Copper',
 'Separate from copper fungicide chemistry, there is a popular claim in biodynamic and some permaculture circles that copper garden tools themselves carry a beneficial "energy" that helps soil and plants. This is a fair, skeptical look at that specific claim — useful to read alongside the fungicide research above so the two very different copper claims (one chemical and measured, one energetic and unverified) do not get mixed up.',
 array['soil-health','copper','biodynamic','fact-check'],
 null,
 'https://www.irishtimes.com/life-and-style/homes-and-property/gardens/biodynamic-gardening-sound-sense-or-plain-silly-1.2715065',
 'admin','approved'),

-- 9. Community Models Inspired by Walden Two
('Walden Two: The Novel That Inspired Real Intentional Communities',
 'Community Models',
 'B.F. Skinner''s 1948 novel imagined a small community organized around shared labor, shared credit for work (not money), and group decision-making rather than hierarchy. It is fiction, but it directly inspired several real communities that still exist today — worth reading as the origin of the idea before looking at what the real versions actually became.',
 array['community-governance','walden-two','intentional-community'],
 null,
 'https://en.wikipedia.org/wiki/Walden_Two',
 'admin','approved'),

('Twin Oaks: A Real Walden-Two-Inspired Community, Running Since 1967',
 'Community Models',
 'Twin Oaks is a real, still-operating intentional community in rural Virginia founded in 1967 partly inspired by Walden Two, built on shared income, shared labor and consensus-style governance. Its official Fellowship for Intentional Community directory listing covers how it actually runs day to day, which is a useful reality check against the fictional version.',
 array['community-governance','intentional-community','case-study'],
 'Louisa County, Virginia, USA',
 'https://www.ic.org/directory/community/twin-oaks-community/',
 'admin','approved'),

-- 10. Academic Research on Ecovillages & Intentional Communities
('Quantifying the Environmental Impact of Ecovillages: A Systematic Literature Review',
 'Academic Research',
 'A peer-reviewed systematic literature review (published in the journal Local Environment) that pulls together the actual measured environmental-impact studies on ecovillages and co-housing communities, rather than relying on anecdote. Useful for separating what has genuinely been measured from what is just commonly claimed.',
 array['academic-research','ecovillage','peer-reviewed'],
 null,
 'https://www.tandfonline.com/doi/abs/10.1080/13549839.2017.1348342',
 'admin','approved'),

('Ecovillage — Background and Case Studies',
 'Academic Research',
 'The general reference overview of what an ecovillage is, its history (going back to the Global Ecovillage Network founded in the 1990s), and links out to specific documented ecovillages around the world. A good map of the field before diving into individual academic papers.',
 array['academic-research','ecovillage','overview'],
 null,
 'https://en.wikipedia.org/wiki/Ecovillage',
 'admin','approved'),

-- 11. Off-Grid Water Systems & Well Digging (Kuyu Kazma)
('Off-Grid Water: The Real Pros and Cons of Each Option',
 'Off-Grid Water Systems',
 'A grounded comparison of the actual off-grid water sources available — drilled well, dug well, spring, rainwater catchment, hauling — written by people living with each option rather than a sales page. Useful for deciding which option even makes sense for your specific land before you invest in any one of them.',
 array['water-systems','off-grid','starting-from-zero'],
 null,
 'https://www.motherearthnews.com/homesteading-and-livestock/pros-cons-of-our-off-grid-water-options-zbcz1604/',
 'admin','approved'),

('Wells: Construction, Hand-Dug and Hand-Drilled (Official Peace Corps Manual)',
 'Off-Grid Water Systems',
 'The real technical manual the US Peace Corps uses to train volunteers to dig or drill a well by hand ("kuyu kazma") in places with no heavy machinery — soil types, depth planning, casing, and safety. This is primary field-tested documentation, not a blog summary of the idea.',
 array['well-digging','kuyu-kazma','water-systems','manual'],
 null,
 'https://files.peacecorps.gov/documents/M0009_Wells-Construction-Hand-Dug-And-Hand-Drilled.pdf',
 'admin','approved'),

-- 12. Gravity-Fed Mountain Spring Systems (Dağın Tepesinde Su Kaynağından Su Çekme Sistemi)
('Building a Gravity-Fed Water System From a Hilltop Spring',
 'Gravity-Fed Spring Systems',
 'A detailed real-world discussion from the permies.com community on piping water from a spring at the top of a slope down to a house using nothing but elevation and gravity — exactly the "dağın tepesinde su kaynağından su çekme sistemi" (water system drawing from a spring at the top of a mountain) the owner asked about. Covers pipe sizing, pressure from elevation drop, and freeze protection in cold climates.',
 array['gravity-fed','spring-water','water-systems','DIY'],
 null,
 'https://permies.com/t/42380/Building-top-hill-gravity-fed',
 'admin','approved'),

('How to Build a Ram Pump: Moving Water Uphill With No Electricity',
 'Gravity-Fed Spring Systems',
 'A hydraulic ram pump uses the energy of falling water itself to push a smaller amount of that water further or higher — useful when your spring is not quite above your house, or when you want to push water further than gravity alone will carry it. A practical build guide from an established homesteading magazine.',
 array['gravity-fed','ram-pump','spring-water','DIY'],
 null,
 'https://www.motherearthnews.com/homesteading-and-livestock/how-to-build-a-water-pump-zmaz96amzgoe/',
 'admin','approved'),

-- 13. Food Preservation & Cold Storage (no fridge needed) — added session 10
('A Root Cellar: Cold Storage That Needs No Electricity',
 'Food Preservation & Cold Storage',
 'Before refrigerators, people kept food cold using the ground itself — the earth a few feet down stays naturally cool and humid year-round. A root cellar (a basement corner, a buried barrel, or a dug-out room) uses that fact to store potatoes, carrots, apples, and canned goods for months with zero power. If you are picturing off-grid life and wondering "how do I keep food cold without a fridge," this is the real, centuries-old answer, with practical build instructions.',
 array['food-preservation','cold-storage','root-cellar','no-fridge','starting-from-zero'],
 null,
 'https://www.motherearthnews.com/diy/build-a-basement-root-cellar-zmaz04djzsel/',
 'admin','approved'),

('Preserving Food Without a Freezer or Fridge: The Other Methods',
 'Food Preservation & Cold Storage',
 'A root cellar works for some foods, but not all of them — meat, dairy, and many vegetables need a different approach. This covers the other traditional preservation methods that do not need electricity: canning (water-bath and pressure), fermenting (sauerkraut, pickles), drying/dehydrating, and smoking. Between this and a root cellar, you can realistically eat well through a winter with no fridge at all.',
 array['food-preservation','canning','fermenting','no-fridge'],
 null,
 'https://insteading.com/blog/preserving-food-without-freezing-or-canning/',
 'admin','approved'),

-- 14. Off-Grid Heating & Cooking — added session 10
('The Rocket Mass Heater: Serious Heat From a Small Amount of Wood',
 'Off-Grid Heating & Cooking',
 'A rocket mass heater burns wood very efficiently in a small firebox, then runs the hot exhaust through a mass of earth or masonry (often a bench you can sit or lie on) that slowly radiates heat for hours after the fire is out. For someone who has never heated with anything but a thermostat, this is the off-grid answer to "how do I stay warm in winter without burning through a forest" — a fraction of the firewood of an open fireplace for the same warmth.',
 array['heating','rocket-mass-heater','wood-heat','starting-from-zero'],
 null,
 'https://naturalbuildingblog.com/rocket-mass-heater-builders-guide-kickstarter/',
 'admin','approved'),

('Solar Cooking: Cooking a Real Meal With Nothing but Sunlight',
 'Off-Grid Heating & Cooking',
 'A solar cooker (a simple box or parabolic reflector) concentrates sunlight enough to bake, boil, or slow-cook food without any fuel or electricity at all — genuinely useful on sunny days and a good backup for your main cooking method. Low Impact is a long-running UK sustainability education organization; this collects their practical solar-cooking guidance.',
 array['cooking','solar-cooker','off-grid','starting-from-zero'],
 null,
 'https://www.lowimpact.org/posts/tag/solar-cooking/',
 'admin','approved'),

-- 15. Waste Management & Composting Toilets — added session 10
('Composting Toilets: Where Your Waste Actually Goes When There Is No Sewer',
 'Waste Management',
 'If you have only ever used a flush toilet connected to a city sewer, "no sewer" sounds like a dealbreaker — it is not. A composting toilet separates liquid and solid waste and lets the solids break down aerobically (with the help of sawdust or coconut coir) into safe, usable compost, with no smell when run correctly and no water or septic system needed at all. This walks through how one actually works and how to build or install one.',
 array['waste-management','composting-toilet','sanitation','starting-from-zero'],
 null,
 'https://www.greenmatters.com/p/how-to-build-a-compost-toilet',
 'admin','approved'),

('Greywater: Reusing Your Sink and Shower Water Instead of Wasting It',
 'Waste Management',
 '"Greywater" is the relatively clean wastewater from sinks, showers, and laundry (as opposed to "blackwater" from toilets) — and off-grid, it is valuable rather than waste, since it can be filtered and redirected straight to irrigate fruit trees and gardens instead of going into a septic field or down a drain. A practical introduction from an established off-grid living publication.',
 array['waste-management','greywater','water-reuse','starting-from-zero'],
 null,
 'https://off-grid.net/going-grey-water-that-is',
 'admin','approved'),

-- 16. Off-Grid Health & First Aid — added session 10
('Wilderness & Remote First Aid: The Official Course Most People Have Never Heard Of',
 'Off-Grid Health & First Aid',
 'Regular first aid assumes an ambulance is 10 minutes away. Off-grid, it might not be — help could be hours away, which changes what you actually need to know (when to improvise a splint and keep going vs. when an injury means you need to get out immediately). The American Red Cross runs an official "Wilderness and Remote First Aid" course and reference guide built exactly for this gap; it is a paid course/manual, not a free page, but it is the real, standard curriculum, not improvised advice.',
 array['first-aid','health','emergency','starting-from-zero'],
 null,
 'https://www.redcross.org/store/wilderness-and-remote-first-aid-emergency-reference-guide-and-pocket-guide-rev-9-14/656237.html',
 'admin','approved'),

('What Wilderness First Aid Actually Covers (A Free Overview)',
 'Off-Grid Health & First Aid',
 'A readable, free overview of what a wilderness-first-aid course actually teaches — the kinds of injuries and situations it covers, and why it differs from a standard city first-aid class — useful for deciding whether (and when) to take the real course above.',
 array['first-aid','health','emergency','overview'],
 null,
 'https://greatdaysoutdoors.com/wilderness-first-aid/',
 'admin','approved'),

-- 17. Off-Grid Communication & Safety — added session 10
('Off-Grid Radio: How to Stay Reachable When There Is No Cell Signal',
 'Off-Grid Communication & Safety',
 'Many off-grid locations have no cell coverage at all. This is a clear starting point from a well-known independent off-grid/amateur-radio educator on what a basic radio setup for an off-grid property actually looks like, and the real difference between unlicensed options (GMRS) and amateur/"ham" radio (which needs a license but reaches much further).',
 array['communication','radio','safety','starting-from-zero'],
 null,
 'https://oh8stn.org/blog/2023/02/20/starting-point-off-grid-survival-radio/',
 'admin','approved'),

('Amateur (Ham) Radio for Beginners',
 'Off-Grid Communication & Safety',
 'A beginner-oriented walkthrough of how amateur radio licensing and equipment actually works, for anyone whose off-grid plan needs a reliable way to reach the outside world (or other community members) when there is no phone signal and the internet is not an option.',
 array['communication','ham-radio','safety'],
 null,
 'https://theprepperjournal.com/2021/06/04/amateur-radio-beginners-guide/',
 'admin','approved'),

-- 18. Everyday Off-Grid Skills — added session 10
('101 Basic Homesteading Skills',
 'Everyday Off-Grid Skills',
 'A long, genuinely practical list from an established homesteading magazine of the hands-on skills that off-grid life actually runs on day to day — sharpening a knife or axe properly, tying the handful of knots that matter, lighting a fire reliably in bad weather, basic tool maintenance, and more. If you are starting from literally zero practical experience, this is the realistic list of what to start learning first, in roughly the order it will matter.',
 array['basic-skills','tools','fire','starting-from-zero'],
 null,
 'https://www.motherearthnews.com/homesteading-and-livestock/basic-homesteading-skills-zb0z1302zpit/',
 'admin','approved'),

('More Basic Homesteading Skills, With Specifics',
 'Everyday Off-Grid Skills',
 'A second, complementary skills list that goes deeper on a few essentials the first list only touches on — knife and tool care, basic food-safe preservation habits, and simple repairs — from an established homesteading publication.',
 array['basic-skills','tools','homesteading'],
 null,
 'https://morningchores.com/basic-homesteading-skills/',
 'admin','approved');

-- ============================= FORUM SEED POSTS — session 10 additions =============================

insert into public.forum_posts (content, guest_name, status) values

('STARTING FROM ZERO — Food Storage Without a Fridge: A root cellar handles roots and canned goods; canning, fermenting, drying, and smoking handle the rest. If you live without a fridge (or part-time without one), what is actually in your rotation — what spoils fastest, and what keeps for months with no trouble at all?',
 'admin','approved'),

('STARTING FROM ZERO — Heating & Cooking: Rocket mass heaters and solar cookers both promise a lot on paper. If you have actually heated a home with one or cooked a full meal with sunlight alone, what is the real day-to-day experience — how much wood do you really burn per winter, and how many days a year is a solar cooker actually usable where you live?',
 'admin','approved'),

('STARTING FROM ZERO — Waste & Water Reuse: Composting toilets and greywater systems are the two things that scare city people most about going off-grid, and usually turn out to be the easiest part once you actually try them. If you run either one, what do you wish someone had told you on day one — the smell question, the maintenance routine, what actually goes wrong?',
 'admin','approved'),

('Off-Grid Health & First Aid — If help is genuinely hours away rather than minutes, what is actually in your first-aid kit and skill set? Wilderness-specific training (splinting, extraction decisions, treating in place vs. evacuating) is different from a standard city first-aid class — who here has taken a real wilderness-first-aid course, and was it worth it?',
 'admin','approved'),

('STARTING FROM ZERO — Communication When There Is No Signal: If your land has no cell coverage, what do you actually use to stay reachable — GMRS, ham radio, satellite messenger, something else? Real range and reliability numbers from your own setup would help a lot of people deciding what to buy first.',
 'admin','approved'),

('STARTING FROM ZERO — Everyday Skills: For someone who has genuinely never sharpened a knife, tied a real knot, or lit a fire in the rain, what is the realistic order to learn these in, and which ones turned out to matter far more in practice than you expected before you moved off-grid?',
 'admin','approved');

-- ============================= FORUM SEED POSTS =============================

insert into public.forum_posts (content, guest_name, status) values

('STARTING FROM ZERO — Land & Location: If you had no land yet, what would you actually look for first? Water source, legal road access, soil quality, zoning, and climate usually matter more than the view. Share what you checked (or wish you had checked) before buying, and if you already have land, tell us roughly where and why you picked it — real examples help more than general advice.',
 'admin','approved'),

('STARTING FROM ZERO — Building a Village: Open Source Ecology''s Global Village Construction Set gives free, open blueprints for the machines a self-sufficient village needs — but has anyone here actually built from them, or from other open-source plans? What worked, what needed local adaptation, and what tools or carpentry skills turned out to matter most in practice?',
 'admin','approved'),

('STARTING FROM ZERO — Solar Power: Before buying a single panel, what load did you actually plan for, and how far off was your estimate once you lived with the system? Share real numbers — panel wattage, battery bank size, and what you wish you had sized differently — so the next person starting from zero does not have to guess.',
 'admin','approved'),

('Solar-Powered Bitcoin Mining — Has anyone here actually tried it? The economics only work in specific conditions: enough sun hours, cheap enough panels and batteries, and a realistic view of intermittent uptime. If you have real numbers (panel size, hash rate, actual uptime), share them — we would rather have one honest data point than ten theoretical ones.',
 'admin','approved'),

('STARTING FROM ZERO — No Pesticides: What has actually worked for you to control pests without spraying anything — companion planting, beneficial insects, physical barriers, timing? Specific pest-and-solution pairs are more useful here than general permaculture theory, so tell us what pest you had and what actually stopped it.',
 'admin','approved'),

('STARTING FROM ZERO — Natural Building: Cob, earthbag, straw bale, or something else — if you have built or are planning to build with natural materials, what made you choose that method for your climate? Looking for real build logs, costs, and what you would do differently next time.',
 'admin','approved'),

('STARTING FROM ZERO — Food Forests: If you started a food forest from bare or degraded land, how long did it actually take before you saw a real harvest, and what did you plant first versus later? Species lists for specific climates are especially welcome here.',
 'admin','approved'),

('Soil Health & Copper — Let us keep this one evidence-based. Copper fungicides are real and effective against fungal disease, but they measurably accumulate in soil and can harm soil life over time — that part is backed by peer-reviewed research. Separately, there is a popular claim that copper garden tools themselves carry a beneficial "energy" for soil and plants — that part is folklore, not measured science. If you use copper in your growing system, which kind are you actually using, and have you tested your soil for buildup?',
 'admin','approved'),

('Community Models Inspired by Walden Two — Twin Oaks and a handful of other real communities took Skinner''s fictional idea (shared labor, shared credit instead of money, consensus governance) and actually built it. If we are forming a community here, which parts of that model seem worth borrowing, and which parts do you think would not survive contact with reality?',
 'admin','approved'),

('Academic Research on Off-Grid & Ecovillage Living — If you have read any of the peer-reviewed research on ecovillages or intentional communities (environmental impact studies, well-being studies, case studies of specific villages), share what you found and the link. We would rather build this community on what has actually been measured than on assumptions.',
 'admin','approved'),

('STARTING FROM ZERO — Water Systems & Well Digging (kuyu kazma): Drilled well, hand-dug well, spring, or rainwater catchment — what did you actually end up using, and why? If you have dug or drilled a well by hand, what depth and soil type did you hit, and how long did it take?',
 'admin','approved'),

('Dağın Tepesinde Su Kaynağından Su Çekme Sistemi / Gravity-Fed Spring Systems — If your land has a spring or stream above your house site, a gravity-fed system (or a ram pump if the drop is not quite enough) can give you running water with zero electricity. Has anyone here actually built one? Real numbers on elevation drop, pipe size, and winter freeze problems would help a lot of people planning the same thing.',
 'admin','approved');
