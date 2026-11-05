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

-- ============================= RESOURCES — session 10 round 2 (content depth + 5 new topics) =============================

insert into public.resources (title, category, description, tags, location, link, guest_name, status) values

-- New category: Animal Husbandry Basics
('Raising Backyard Chickens: A Real Beginner''s Guide',
 'Animal Husbandry Basics',
 'Chickens are usually the first animal people add to an off-grid property — they need less space and infrastructure than larger livestock, and give eggs within months. This covers coop basics, predator protection, feed, and the real day-to-day time commitment, from an established pet-care company''s education section.',
 array['animal-husbandry','chickens','starting-from-zero'],
 null,
 'https://www.chewy.com/education/farm-animal/chicken/how-to-raise-backyard-chickens-a-beginners-guide',
 'admin','approved'),

('Raising Goats for Beginners',
 'Animal Husbandry Basics',
 'Goats are a common next step after chickens for anyone wanting milk, meat, or land-clearing help — but they need secure fencing (goats are notorious escape artists), shelter, and a real understanding of their diet before you bring one home. A practical first-timer''s overview from an established homesteading blog.',
 array['animal-husbandry','goats','dairy','starting-from-zero'],
 null,
 'https://simplelivingcountrygal.com/?p=23478',
 'admin','approved'),

-- New category: Seed Starting & Climate-Appropriate Growing
('Find Your Climate Zone Before You Plant Anything',
 'Seed Starting & Climate-Appropriate Growing',
 'What grows well in one place can fail completely a few hundred kilometers away — the USDA Plant Hardiness Zone Map (and equivalents elsewhere) is the standard way to check what your climate can actually support before you buy seeds. From Ohio State University''s climate office; even outside the US, understanding how these zone systems work helps you find your own country''s equivalent.',
 array['growing-food','climate-zone','starting-from-zero'],
 null,
 'https://climate.osu.edu/news/plant-hardiness-zone-map',
 'admin','approved'),

('When to Actually Start Your Seeds',
 'Seed Starting & Climate-Appropriate Growing',
 'Starting seeds too early or too late is one of the most common first-year mistakes — this walks through counting back from your last expected frost date to find the right indoor start time for your specific zone, from a long-established general gardening reference.',
 array['growing-food','seed-starting','starting-from-zero'],
 null,
 'https://www.gardeningknowhow.com/garden-how-to/propagation/seeds/when-to-start-seeds.htm',
 'admin','approved'),

-- New category: Barter & Local Economy
('Starting a Community Currency or Barter System',
 'Barter & Local Economy',
 'If a community wants to trade skills and goods without everything running through official money, this covers how local currency and barter systems have actually been set up by other communities — the practical mechanics, not just the idea. From an established homesteading/self-reliance magazine.',
 array['local-economy','barter','community'],
 null,
 'https://www.motherearthnews.com/nature-and-environment/community-currency-system-zmaz93onztak',
 'admin','approved'),

('How to Launch a Time Bank',
 'Barter & Local Economy',
 'A time bank lets people trade hours of help (an hour of your labor equals an hour of anyone else''s, regardless of the task) instead of money — a real alternative-economy model several neighborhoods and communities already run. An official how-to toolkit from a US city government.',
 array['local-economy','time-banking','community'],
 null,
 'https://www.stlouis-mo.gov/government/departments/planning/sustainability/toolkit/time-bank.cfm',
 'admin','approved'),

-- New category: Legal & Zoning Basics (not legal advice — jurisdiction-dependent, see description)
('Is Off-Grid Living Actually Legal Where You Are? (It Depends Entirely on Location)',
 'Legal & Zoning Basics',
 'This is not legal advice, and there is no single answer — off-grid legality depends on your specific country, state/province, and even county: some places ban living with no septic/sewer connection outright, others welcome it, and most have rules buried in building codes that have nothing to do with "off-grid" by name. A real community discussion collecting what people have actually run into, county by county, as a starting point for your own research — not a substitute for checking your specific jurisdiction yourself.',
 array['legal','zoning','starting-from-zero'],
 null,
 'https://permies.com/t/152283/Information-resources-grid-legality-request',
 'admin','approved'),

('What "Off-Grid" Means Legally, in Plain Terms',
 'Legal & Zoning Basics',
 'A general-audience overview of the legal and practical distinctions that actually matter — off-grid utilities vs. off-grid land title vs. off-grid as a lifestyle choice — from a land-sales company''s educational content. Treat it as a starting vocabulary, then verify everything against your own local authority.',
 array['legal','zoning','overview'],
 null,
 'https://www.landhub.com/land-news/what-is-off-the-grid-living',
 'admin','approved'),

-- New category: Off-Grid Internet & Digital Access
('Starlink: The Real-World Review',
 'Off-Grid Internet & Digital Access',
 'Satellite internet (most commonly Starlink) is what makes genuine off-grid internet access realistic today, where a decade ago it was not. An independent tech publication''s hands-on review of real speeds, latency, and the honest limitations (weather sensitivity, line-of-sight to open sky needed).',
 array['communication','internet','starlink','starting-from-zero'],
 null,
 'https://www.techradar.com/pro/starlink-review',
 'admin','approved'),

('Cell Booster vs. Satellite Internet: Which Do You Actually Need?',
 'Off-Grid Internet & Digital Access',
 'If your land has even a weak cell signal, a cellular signal booster can be far cheaper and simpler than satellite internet — but if there is no signal at all, boosting zero signal gets you zero. A direct comparison from an established signal-booster manufacturer (vendor-published, but a fair side-by-side of when each option actually makes sense).',
 array['communication','internet','cell-booster'],
 null,
 'https://www.weboost.com/blog/cell-signal-booster-vs-satellite-internet-who-comes-out-on-top',
 'admin','approved'),

-- Depth additions to existing categories
('More Real Experiences Buying Land (permies.com)',
 'Land & Location',
 'A second long-running permies.com thread on finding and buying land, with a different set of real buyer experiences and pitfalls than the first — worth reading both since no two land searches run into the same problems.',
 array['land','community-knowledge','starting-from-zero'],
 null,
 'https://permies.com/t/138954/wannabe-finding-buying-land',
 'admin','approved'),

('How an Off-Grid Solar System Actually Works, Step by Step',
 'Solar Energy',
 'A visual, step-by-step walkthrough of what actually happens inside an off-grid solar system from sunrise to a device being charged — useful for understanding the wiring and sequence before getting into sizing math, from an established solar retailer''s technical blog.',
 array['solar','off-grid','how-it-works'],
 null,
 'https://thesolarstore.com/blogs/news/how-an-off-grid-solar-system-works',
 'admin','approved'),

('Off-Grid Water: A Broader Overview',
 'Off-Grid Water Systems',
 'A second, broader overview of off-grid water sourcing that covers some ground the Mother Earth News comparison does not — useful as a cross-check before settling on one approach for your land.',
 array['water-systems','off-grid','overview'],
 null,
 'https://insteading.com/blog/off-grid-water-system/',
 'admin','approved'),

('Earthbag Building in 8 Steps (From the Dedicated Earthbag Site)',
 'Natural Building',
 'The most specialized earthbag-building website on the internet, written by people who have built this way for decades, breaking the technique down into 8 concrete steps — a good primary-source complement to the Wikipedia overview and the Instructables build log.',
 array['natural-building','earthbag','how-to'],
 null,
 'https://earthbagbuilding.com/articles/8steps.htm',
 'admin','approved'),

('Beneficial Insects That Live in Your Soil, Not Just on Your Plants',
 'No-Pesticide Permaculture',
 'Most beginner pest-control advice focuses on the insects you can see on leaves — this USDA-funded SARE guide instead covers the beneficial insects that live and hunt in the soil itself, an easy-to-miss half of a genuinely pesticide-free system.',
 array['permaculture','pest-control','beneficial-insects','soil'],
 null,
 'https://projects.sare.org/information-product/beneficial-insects-for-natural-pest-control-soil-scouting-2/',
 'admin','approved'),

('How to Actually Create a Home Food Forest',
 'Food Forests',
 'A third, more execution-focused guide on building a food forest at home — useful once you understand the seven-layer concept and are ready for the practical sequence of what to plant first and how to space it, from an established vegetable-gardening reference site.',
 array['food-forest','permaculture','how-to'],
 null,
 'https://harvesttotable.com/how-to-create-home-garden-food-forest/',
 'admin','approved');

-- ============================= FORUM SEED POSTS — session 10 round 2 =============================

insert into public.forum_posts (content, guest_name, status) values

('STARTING FROM ZERO — Animal Husbandry: Chickens or goats first? If you keep either, what has the real day-to-day time cost been (not the Instagram version), and what would you tell someone who has never kept an animal before they bring one home?',
 'admin','approved'),

('STARTING FROM ZERO — What Actually Grows Where You Are: Climate zones are a starting point, not the full picture — microclimates, soil, and elevation all matter too. What has actually thrived (or failed) on your land, and what zone/region are you in? Real local results help far more than a generic chart.',
 'admin','approved'),

('Barter & Local Economy — Has anyone here actually run a time bank or barter system with their community, even informally? What broke down first — tracking fairness, people not following through, something else — and what would you set up differently next time?',
 'admin','approved'),

('Legal & Zoning Basics — This is exactly the kind of thing we want real, location-specific experience on rather than generic blog advice. If you have gone through the actual permitting/zoning process for off-grid systems (septic alternatives, solar, a well) in your specific county or country, what did you run into that no article warned you about?',
 'admin','approved'),

('STARTING FROM ZERO — Staying Online Off-Grid: Starlink, a cell booster, or nothing at all by choice? If you have real numbers (actual speeds, monthly cost, how often it drops in bad weather), share them — this is one area where the gap between marketing and reality seems largest.',
 'admin','approved');

-- ============================= LOCATIONS (Map page examples) =============================
-- Two real, verifiable example locations so the new Map page is not empty on launch.
-- Coordinates sourced from Wikipedia (Twin Oaks' own infobox; OSE's Factor e Farm from a
-- citation in its article) — not estimated or invented. See migration
-- 20261105164322_add_location_coordinates.sql for the latitude/longitude columns.

insert into public.locations (name, address, description, tags, guest_name, status, latitude, longitude) values

('Twin Oaks Community',
 'Louisa, Virginia, USA',
 'A real intentional community founded in 1967, inspired by B.F. Skinner''s novel Walden Two — income-sharing, consensus-based decision-making, and shared labor, still running today. Referenced in this site''s Community Models resources. Coordinates from the community''s own Wikipedia infobox.',
 array['intentional-community','walden-two','example-location'],
 'admin','approved', 37.932500, -77.991667),

('Open Source Ecology — Factor e Farm',
 'Near Maysville, Missouri, USA',
 'The working farm and fabrication site of Open Source Ecology, the project publishing free, open-source blueprints for the machines a self-sufficient village needs (the "Global Village Construction Set"). Referenced in this site''s Building a Village resources. Coordinates taken from a citation in the organization''s Wikipedia article (approximate — rural site, not a street address).',
 array['open-source','village-building','example-location'],
 'admin','approved', 39.863900, -94.375000);
