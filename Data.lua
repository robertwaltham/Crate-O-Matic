local _, addon = ...

-- Waylaid Crate bundles and profession recipes from Forever 1.60.1.70938 with hotfixes.
-- Each bundle is an independent way to fill one crate.
-- Apprentice through Expert payouts: https://www.wowhead.com/forever/currency=3402/merchants-favor
-- Artisan base payouts reported by Waylaid Auction Helper 1.2.1 (quests 91902 and 91907).
-- https://www.curseforge.com/wow/addons/waylaid-auction-helper/files/9580959
addon.crates = {
  { id = 248682, name = "Apprentice Herbs", favor = 5, bundles = { { 2447, 20 }, { 765, 20 }, { 2449, 10 }, { 785, 10 }, { 2450, 10 } } },
  { id = 248683, name = "Apprentice Ore", favor = 5, bundles = { { 2770, 20 }, { 2771, 20 } } },
  { id = 248684, name = "Apprentice Textiles", favor = 5, bundles = { { 2589, 40 }, { 2318, 20 } } },
  { id = 248685, name = "Apprentice Curiosities", favor = 5, bundles = { { 10940, 20 }, { 10939, 4 }, { 10978, 6 }, { 11084, 2 } } },
  { id = 248686, name = "Journeyman Herbs", favor = 10, bundles = { { 3820, 10 }, { 2453, 10 }, { 3355, 10 }, { 3369, 10 }, { 3356, 10 } } },
  { id = 248687, name = "Journeyman Ore", favor = 10, bundles = { { 2775, 10 }, { 2772, 20 } } },
  { id = 248688, name = "Journeyman Textiles", favor = 10, bundles = { { 2592, 20 }, { 4306, 40 }, { 2319, 20 } } },
  { id = 248689, name = "Journeyman Curiosities", favor = 10, bundles = { { 11083, 20 }, { 11082, 4 }, { 11138, 6 }, { 11139, 2 } } },
  { id = 248690, name = "Earthly Expert Herbs", favor = 15, bundles = { { 3357, 20 }, { 3818, 10 }, { 3821, 10 }, { 3358, 10 } } },
  { id = 248691, name = "Flowering Expert Herbs", favor = 15, bundles = { { 3819, 10 }, { 4625, 10 }, { 8831, 20 }, { 8836, 10 } } },
  { id = 248692, name = "Expert Ore", favor = 15, bundles = { { 2776, 10 }, { 3858, 20 } } },
  { id = 248693, name = "Expert Textiles", favor = 15, bundles = { { 4338, 40 }, { 4234, 20 } } },
  { id = 248694, name = "Expert Curiosities", favor = 15, bundles = { { 11137, 20 }, { 11135, 4 }, { 11177, 6 }, { 11178, 2 } } },
  { id = 248695, name = "Earthly Artisan Herbs", favor = 20, bundles = { { 13464, 10 }, { 8838, 20 }, { 8839, 10 }, { 8845, 10 }, { 8846, 10 } } },
  { id = 248696, name = "Flowering Artisan Herbs", favor = 20, bundles = { { 13463, 20 }, { 13465, 20 }, { 13466, 20 }, { 13467, 20 } } },
  { id = 248697, name = "Artisan Ore", favor = 20, bundles = { { 7911, 10 }, { 10620, 20 }, { 11370, 20 } } },
  { id = 248698, name = "Artisan Textiles", favor = 20, bundles = { { 14047, 40 }, { 4304, 20 }, { 8170, 20 } } },
  { id = 248699, name = "Artisan Curiosities", favor = 20, bundles = { { 11176, 20 }, { 11175, 4 }, { 14343, 6 }, { 14344, 2 } } },
  { id = 248702, name = "Apprentice Fabrics", favor = 10, bundles = { { 4231, 2 }, { 2996, 20 } } },
  { id = 248703, name = "Apprentice Ingots", favor = 10, bundles = { { 2840, 20 }, { 3576, 20 }, { 2841, 10 } } },
  { id = 248704, name = "Apprentice Parts", favor = 10, bundles = { { 4359, 16 }, { 4361, 16 }, { 4363, 4 } } },
  { id = 248705, name = "Journeyman Fabrics", favor = 20, bundles = { { 2997, 6 }, { 4305, 10 }, { 4233, 2 } } },
  { id = 248706, name = "Journeyman Ingots", favor = 20, bundles = { { 2842, 10 }, { 3575, 20 } } },
  { id = 248707, name = "Journeyman Parts", favor = 20, bundles = { { 4371, 8 }, { 4375, 7 }, { 4382, 4 }, { 10558, 45 } } },
  { id = 248708, name = "Expert Fabrics", favor = 30, bundles = { { 4339, 8 }, { 4236, 2 } } },
  { id = 248709, name = "Expert Ingots", favor = 30, bundles = { { 3860, 20 }, { 3859, 15 }, { 3577, 10 } } },
  { id = 248710, name = "Expert Parts", favor = 30, bundles = { { 4387, 8 }, { 10559, 5 }, { 10560, 12 }, { 10561, 5 } } },
  { id = 248711, name = "Artisan Fabrics", favor = 40, bundles = { { 14048, 8 }, { 8172, 2 } } },
  { id = 248712, name = "Artisan Ingots", favor = 40, bundles = { { 11371, 2 }, { 6037, 10 }, { 12359, 20 } } },
  { id = 248713, name = "Artisan Parts", favor = 40, bundles = { { 15994, 5 }, { 18631, 5 }, { 16000, 2 } } },
}

-- Writ objectives and reputation from Crate Expectations 0.2 (MIT),
-- based on the 1.60.1.70888 client and quest cache. IDs and recipes checked in 70938.
-- https://www.curseforge.com/wow/addons/crate-expectations-waylaid-crate-and-craftsmans/files/9583779
addon.writs = {
  { id = 264011, questID = 94004, name = "Elixir of Ogre's Strength", reputation = 75, bundles = { { 3391, 1 } } },
  { id = 264012, questID = 94212, name = "Elixir of Wisdom", reputation = 75, bundles = { { 3383, 1 } } },
  { id = 264013, questID = 94213, name = "Lesser Mana Potion", reputation = 75, bundles = { { 3385, 1 } } },
  { id = 264014, questID = 94214, name = "Shadow Protection Potion", reputation = 75, bundles = { { 6048, 1 } } },
  { id = 264015, questID = 94215, name = "Free Action Potion", reputation = 75, bundles = { { 5634, 1 } } },
  { id = 264016, questID = 94216, name = "Elixir of Lesser Agility", reputation = 75, bundles = { { 3390, 1 } } },
  { id = 264017, questID = 94217, name = "Lesser Troll's Blood Elixir", reputation = 75, bundles = { { 3388, 1 } } },
  { id = 264018, questID = 94218, name = "Elixir of Defense", reputation = 75, bundles = { { 8951, 1 } } },
  { id = 264019, questID = 94219, name = "Draught of Water Breathing", reputation = 75, bundles = { { 5996, 1 } } },
  { id = 264020, questID = 94220, name = "Pearl-Handled Dagger", reputation = 75, bundles = { { 5540, 1 } } },
  { id = 264021, questID = 94221, name = "Golden Rod", reputation = 75, bundles = { { 11128, 1 } } },
  { id = 264022, questID = 94222, name = "Iridescent Hammer", reputation = 75, bundles = { { 5541, 1 } } },
  { id = 264023, questID = 94223, name = "Silver Skeleton Key", reputation = 75, bundles = { { 15869, 1 } } },
  { id = 264024, questID = 94224, name = "Heavy Bronze Mace", reputation = 75, bundles = { { 3491, 1 } } },
  { id = 264025, questID = 94225, name = "Rough Bronze Leggings", reputation = 75, bundles = { { 2865, 1 } } },
  { id = 264026, questID = 94226, name = "Green Iron Gauntlets", reputation = 75, bundles = { { 3485, 1 } } },
  { id = 264027, questID = 94227, name = "Big Bronze Knife", reputation = 75, bundles = { { 3848, 1 } } },
  { id = 264028, questID = 94228, name = "Green Iron Boots", reputation = 75, bundles = { { 3484, 1 } } },
  { id = 264029, questID = 94229, name = "Ornate Spyglass", reputation = 75, bundles = { { 5507, 1 } } },
  { id = 264030, questID = 94230, name = "Explosive Sheep", reputation = 75, bundles = { { 4384, 1 } } },
  { id = 264031, questID = 94231, name = "Moonsight Rifle", reputation = 75, bundles = { { 4383, 1 } } },
  { id = 264032, questID = 94232, name = "Minor Recombobulator", reputation = 75, bundles = { { 4381, 1 } } },
  { id = 264033, questID = 94233, name = "Practice Lock", reputation = 75, bundles = { { 6712, 1 } } },
  { id = 264034, questID = 94234, name = "Shadow Goggles", reputation = 75, bundles = { { 4373, 1 } } },
  { id = 264035, questID = 94235, name = "Gnomish Universal Remote", reputation = 75, bundles = { { 7506, 1 } } },
  { id = 264036, questID = 94236, name = "Big Bronze Bomb", reputation = 75, bundles = { { 4380, 1 } } },
  { id = 264037, questID = 94237, name = "Crafted Solid Shot", reputation = 75, bundles = { { 8069, 200 } } },
  { id = 264038, questID = 94238, name = "Heavy Leather Ball", reputation = 75, bundles = { { 18662, 1 } } },
  { id = 264039, questID = 94239, name = "Fine Leather Pants", reputation = 75, bundles = { { 5958, 1 } } },
  { id = 264040, questID = 94240, name = "Herbalist's Gloves", reputation = 75, bundles = { { 7349, 1 } } },
  { id = 264041, questID = 94241, name = "Dark Leather Tunic", reputation = 75, bundles = { { 2317, 1 } } },
  { id = 264042, questID = 94242, name = "Pilferer's Gloves", reputation = 75, bundles = { { 7358, 1 } } },
  { id = 264043, questID = 94243, name = "Heavy Quiver", reputation = 75, bundles = { { 7371, 1 } } },
  { id = 264044, questID = 94244, name = "Dark Leather Shoulders", reputation = 75, bundles = { { 4252, 1 } } },
  { id = 264045, questID = 94245, name = "Barbaric Gloves", reputation = 75, bundles = { { 4254, 1 } } },
  { id = 264046, questID = 94246, name = "Red Whelp Gloves", reputation = 75, bundles = { { 7284, 1 } } },
  { id = 264047, questID = 94247, name = "Lesser Wizard's Robe", reputation = 75, bundles = { { 5766, 1 } } },
  { id = 264048, questID = 94248, name = "Blue Overalls", reputation = 75, bundles = { { 6263, 1 } } },
  { id = 264049, questID = 94249, name = "Azure Silk Hood", reputation = 75, bundles = { { 7048, 1 } } },
  { id = 264050, questID = 94250, name = "Small Silk Pack", reputation = 75, bundles = { { 4245, 1 } } },
  { id = 264051, questID = 94251, name = "Phoenix Pants", reputation = 75, bundles = { { 4317, 1 } } },
  { id = 264052, questID = 94252, name = "Red Woolen Boots", reputation = 75, bundles = { { 4313, 1 } } },
  { id = 264053, questID = 94253, name = "Colorful Kilt", reputation = 75, bundles = { { 10048, 1 } } },
  { id = 264054, questID = 94254, name = "Greater Adept's Robe", reputation = 75, bundles = { { 6264, 1 } } },
  { id = 264055, questID = 94255, name = "Spider Silk Slippers", reputation = 75, bundles = { { 4321, 1 } } },
  { id = 264056, questID = 94256, name = "Frost Protection Potion", reputation = 125, bundles = { { 6050, 1 } } },
  { id = 264057, questID = 94257, name = "Lesser Invisibility Potion", reputation = 125, bundles = { { 3823, 1 } } },
  { id = 264058, questID = 94258, name = "Lesser Stoneshield Potion", reputation = 125, bundles = { { 4623, 1 } } },
  { id = 264059, questID = 94259, name = "Nature Protection Potion", reputation = 125, bundles = { { 6052, 1 } } },
  { id = 264060, questID = 94260, name = "Catseye Draught", reputation = 125, bundles = { { 10592, 1 } } },
  { id = 264061, questID = 94261, name = "Great Rage Potion", reputation = 125, bundles = { { 5633, 1 } } },
  { id = 264062, questID = 94262, name = "Mana Potion", reputation = 125, bundles = { { 3827, 1 } } },
  { id = 264063, questID = 94263, name = "Fire Protection Potion", reputation = 125, bundles = { { 6049, 1 } } },
  { id = 264064, questID = 94264, name = "Shadow Oil", reputation = 125, bundles = { { 3824, 1 } } },
  { id = 264065, questID = 94265, name = "Goblin Rocket Fuel", reputation = 125, bundles = { { 9061, 1 } } },
  { id = 264066, questID = 94266, name = "Elixir of Agility", reputation = 125, bundles = { { 8949, 1 } } },
  { id = 264067, questID = 94267, name = "Wildvine Potion", reputation = 125, bundles = { { 9144, 1 } } },
  { id = 264068, questID = 94268, name = "Steel Plate Helm", reputation = 125, bundles = { { 7922, 1 } } },
  { id = 264069, questID = 94269, name = "Inlaid Mithril Cylinder", reputation = 125, bundles = { { 9060, 1 } } },
  { id = 264070, questID = 94270, name = "Steel Weapon Chain", reputation = 125, bundles = { { 6041, 1 } } },
  { id = 264071, questID = 94271, name = "Ornate Mithril Shoulders", reputation = 125, bundles = { { 7928, 1 } } },
  { id = 264072, questID = 94272, name = "Blue Glittering Axe", reputation = 125, bundles = { { 7942, 1 } } },
  { id = 264073, questID = 94273, name = "Moonsteel Broadsword", reputation = 125, bundles = { { 3853, 1 } } },
  { id = 264074, questID = 94274, name = "Golden Scale Coif", reputation = 125, bundles = { { 3837, 1 } } },
  { id = 264075, questID = 94275, name = "Solid Sharpening Stone", reputation = 125, bundles = { { 7964, 1 } } },
  { id = 264076, questID = 94276, name = "Wicked Mithril Blade", reputation = 125, bundles = { { 7943, 1 } } },
  { id = 264077, questID = 94277, name = "Truesilver Rod", reputation = 125, bundles = { { 11144, 1 } } },
  { id = 264078, questID = 94278, name = "Golden Scale Gauntlets", reputation = 125, bundles = { { 9366, 1 } } },
  { id = 264079, questID = 94279, name = "Heavy Mithril Axe", reputation = 125, bundles = { { 7941, 1 } } },
  { id = 264080, questID = 94280, name = "Mechanical Dragonling", reputation = 125, bundles = { { 4396, 1 } } },
  { id = 264081, questID = 94281, name = "Advanced Target Dummy", reputation = 125, bundles = { { 4392, 1 } } },
  { id = 264082, questID = 94282, name = "Craftsman's Monocle", reputation = 125, bundles = { { 4393, 1 } } },
  { id = 264083, questID = 94283, name = "Goblin Land Mine", reputation = 125, bundles = { { 4395, 1 } } },
  { id = 264084, questID = 94284, name = "Catseye Ultra Goggles", reputation = 125, bundles = { { 10501, 1 } } },
  { id = 264085, questID = 94285, name = "Unstable Trigger", reputation = 125, bundles = { { 10560, 1 } } },
  { id = 264086, questID = 94286, name = "Flash Bomb", reputation = 125, bundles = { { 4852, 1 } } },
  { id = 264087, questID = 94287, name = "Fire Goggles", reputation = 125, bundles = { { 10500, 1 } } },
  { id = 264088, questID = 94288, name = "Mithril Frag Bomb", reputation = 125, bundles = { { 10514, 1 } } },
  { id = 264089, questID = 94289, name = "Gyromatic Micro-Adjuster", reputation = 125, bundles = { { 10498, 1 } } },
  { id = 264090, questID = 94290, name = "Mechanical Repair Kit", reputation = 125, bundles = { { 11590, 1 } } },
  { id = 264091, questID = 94291, name = "Dark Iron Bomb", reputation = 125, bundles = { { 16005, 1 } } },
  { id = 264092, questID = 94292, name = "Comfortable Leather Hat", reputation = 125, bundles = { { 8174, 1 } } },
  { id = 264093, questID = 94293, name = "Guardian Cloak", reputation = 125, bundles = { { 5965, 1 } } },
  { id = 264094, questID = 94294, name = "Dusky Bracers", reputation = 125, bundles = { { 7378, 1 } } },
  { id = 264095, questID = 94295, name = "Wild Leather Helmet", reputation = 125, bundles = { { 8214, 1 } } },
  { id = 264096, questID = 94296, name = "Wild Leather Shoulders", reputation = 125, bundles = { { 8210, 1 } } },
  { id = 264097, questID = 94297, name = "Quickdraw Quiver", reputation = 125, bundles = { { 8217, 1 } } },
  { id = 264098, questID = 94298, name = "Swift Boots", reputation = 125, bundles = { { 7391, 1 } } },
  { id = 264099, questID = 94299, name = "Nightscape Shoulders", reputation = 125, bundles = { { 8192, 1 } } },
  { id = 264100, questID = 94300, name = "Big Voodoo Mask", reputation = 125, bundles = { { 8201, 1 } } },
  { id = 264101, questID = 94301, name = "Big Voodoo Robe", reputation = 125, bundles = { { 8200, 1 } } },
  { id = 264102, questID = 94302, name = "Turtle Scale Breastplate", reputation = 125, bundles = { { 8189, 1 } } },
  { id = 264103, questID = 94303, name = "Thick Leather Ammo Pouch", reputation = 125, bundles = { { 8218, 1 } } },
  { id = 264104, questID = 94304, name = "Mageweave Bag", reputation = 125, bundles = { { 10050, 1 } } },
  { id = 264105, questID = 94305, name = "Shadoweave Gloves", reputation = 125, bundles = { { 10023, 1 } } },
  { id = 264106, questID = 94306, name = "Crimson Silk Robe", reputation = 125, bundles = { { 7063, 1 } } },
  { id = 264107, questID = 94307, name = "Shadoweave Robe", reputation = 125, bundles = { { 10004, 1 } } },
  { id = 264108, questID = 94308, name = "Enchanted Mageweave Pouch", reputation = 125, bundles = { { 22246, 1 } } },
  { id = 264109, questID = 94309, name = "Star Belt", reputation = 125, bundles = { { 4329, 1 } } },
  { id = 264110, questID = 94310, name = "Black Mageweave Vest", reputation = 125, bundles = { { 9998, 1 } } },
  { id = 264111, questID = 94311, name = "Red Mageweave Pants", reputation = 125, bundles = { { 10009, 1 } } },
  { id = 264112, questID = 94312, name = "Orange Martial Shirt", reputation = 125, bundles = { { 10052, 1 } } },
  { id = 264113, questID = 94313, name = "White Bandit Mask", reputation = 125, bundles = { { 10008, 1 } } },
  { id = 264114, questID = 94314, name = "Cindercloth Robe", reputation = 125, bundles = { { 10042, 1 } } },
  { id = 264115, questID = 94315, name = "Earthen Silk Belt", reputation = 125, bundles = { { 7061, 1 } } },
  { id = 264116, questID = 94316, name = "Potion of Demonslaying", reputation = 200, bundles = { { 9224, 1 } } },
  { id = 264117, questID = 94317, name = "Dreamless Sleep Potion", reputation = 200, bundles = { { 12190, 1 } } },
  { id = 264118, questID = 94318, name = "Greater Fire Protection Potion", reputation = 200, bundles = { { 13457, 1 } } },
  { id = 264119, questID = 94319, name = "Draught of Detect Demon", reputation = 200, bundles = { { 9233, 1 } } },
  { id = 264120, questID = 94320, name = "Gift of Arthas", reputation = 200, bundles = { { 9088, 1 } } },
  { id = 264121, questID = 94321, name = "Flask of Chromatic Resistance", reputation = 200, bundles = { { 13513, 1 } } },
  { id = 264122, questID = 94322, name = "Limited Invulnerability Potion", reputation = 200, bundles = { { 3387, 1 } } },
  { id = 264123, questID = 94323, name = "Major Rejuvenation Potion", reputation = 200, bundles = { { 18253, 1 } } },
  { id = 264124, questID = 94324, name = "Distilled Firewater", reputation = 200, bundles = { { 246948, 1 } } },
  { id = 264125, questID = 94325, name = "Radiant Circlet", reputation = 200, bundles = { { 12417, 1 } } },
  { id = 264126, questID = 94326, name = "Radiant Belt", reputation = 200, bundles = { { 12416, 1 } } },
  { id = 264127, questID = 94327, name = "Orcish War Leggings", reputation = 200, bundles = { { 7929, 1 } } },
  { id = 264128, questID = 94328, name = "Mithril Spurs", reputation = 200, bundles = { { 7969, 1 } } },
  { id = 264129, questID = 94329, name = "Imperial Plate Chest", reputation = 200, bundles = { { 12422, 1 } } },
  { id = 264130, questID = 94330, name = "Darkrune Gauntlets", reputation = 200, bundles = { { 20549, 1 } } },
  { id = 264131, questID = 94331, name = "Huge Thorium Battleaxe", reputation = 200, bundles = { { 12775, 1 } } },
  { id = 264132, questID = 94332, name = "Arcanite Skeleton Key", reputation = 200, bundles = { { 15872, 1 } } },
  { id = 264133, questID = 94333, name = "Ebon Shiv", reputation = 200, bundles = { { 7947, 1 } } },
  { id = 264134, questID = 94334, name = "Masterwork Target Dummy", reputation = 200, bundles = { { 16023, 1 } } },
  { id = 264135, questID = 94335, name = "Green Lens", reputation = 200, bundles = { { 10504, 1 } } },
  { id = 264136, questID = 94336, name = "Lifelike Mechanical Toad", reputation = 200, bundles = { { 15996, 1 } } },
  { id = 264137, questID = 94337, name = "Gnomish Alarm-O-Bot", reputation = 200, bundles = { { 18645, 1 } } },
  { id = 264138, questID = 94338, name = "Goblin Jumper Cables XL", reputation = 200, bundles = { { 18587, 1 } } },
  { id = 264139, questID = 94339, name = "Field Repair Bot 74A", reputation = 200, bundles = { { 18232, 1 } } },
  { id = 264140, questID = 94340, name = "Truesilver Transformer", reputation = 200, bundles = { { 18631, 1 } } },
  { id = 264141, questID = 94341, name = "Sniper Scope", reputation = 200, bundles = { { 10548, 1 } } },
  { id = 264142, questID = 94342, name = "Tranquil Mechanical Yeti", reputation = 200, bundles = { { 21277, 1 } } },
  { id = 264143, questID = 94343, name = "Wicked Leather Pants", reputation = 200, bundles = { { 15087, 1 } } },
  { id = 264144, questID = 94344, name = "Gordok Ogre Suit", reputation = 200, bundles = { { 18258, 1 } } },
  { id = 264145, questID = 94345, name = "Volcanic Breastplate", reputation = 200, bundles = { { 15053, 1 } } },
  { id = 264146, questID = 94346, name = "Runic Leather Headband", reputation = 200, bundles = { { 15094, 1 } } },
  { id = 264147, questID = 94347, name = "Wicked Leather Bracers", reputation = 200, bundles = { { 15084, 1 } } },
  { id = 264148, questID = 94348, name = "Chimeric Vest", reputation = 200, bundles = { { 15075, 1 } } },
  { id = 264149, questID = 94349, name = "Heavy Scorpid Helm", reputation = 200, bundles = { { 15080, 1 } } },
  { id = 264150, questID = 94350, name = "Runic Leather Bracers", reputation = 200, bundles = { { 15092, 1 } } },
  { id = 264151, questID = 94351, name = "Frostsaber Boots", reputation = 200, bundles = { { 15071, 1 } } },
  { id = 264152, questID = 94352, name = "Wizardweave Turban", reputation = 200, bundles = { { 14130, 1 } } },
  { id = 264153, questID = 94353, name = "Runecloth Bag", reputation = 200, bundles = { { 14046, 1 } } },
  { id = 264154, questID = 94354, name = "Runecloth Boots", reputation = 200, bundles = { { 13864, 1 } } },
  { id = 264155, questID = 94355, name = "Tuxedo Jacket", reputation = 200, bundles = { { 10036, 1 } } },
  { id = 264156, questID = 94356, name = "Felcloth Boots", reputation = 200, bundles = { { 14108, 1 } } },
  { id = 264157, questID = 94357, name = "Cenarion Herb Bag", reputation = 200, bundles = { { 22251, 1 } } },
  { id = 264158, questID = 94358, name = "Shadoweave Mask", reputation = 200, bundles = { { 10025, 1 } } },
  { id = 264159, questID = 94359, name = "Ghostweave Vest", reputation = 200, bundles = { { 14141, 1 } } },
  { id = 264160, questID = 94360, name = "Soul Pouch", reputation = 200, bundles = { { 21340, 1 } } },
}

-- Estimated copper looted per Coin Pouch, keyed by base writ reputation.
-- Wowhead's pouch values for 284584 and 284586, rounded to whole silver.
-- Expert (284585) is a rough estimate from reported live payouts around 60–99s.
local purseByReputation = { [75] = 3500, [125] = 8000, [200] = 15200 }
for _, writ in ipairs(addon.writs) do
  writ.estimatedPurse = purseByReputation[writ.reputation]
end

addon.itemNames = {
  [765] = "Silverleaf",
  [774] = "Malachite",
  [783] = "Light Hide",
  [785] = "Mageroyal",
  [814] = "Flask of Oil",
  [818] = "Tigerseye",
  [1206] = "Moss Agate",
  [1210] = "Shadowgem",
  [1529] = "Jade",
  [1705] = "Lesser Moonstone",
  [2317] = "Dark Leather Tunic",
  [2318] = "Light Leather",
  [2319] = "Medium Leather",
  [2321] = "Fine Thread",
  [2324] = "Bleach",
  [2325] = "Black Dye",
  [2447] = "Peacebloom",
  [2449] = "Earthroot",
  [2450] = "Briarthorn",
  [2452] = "Swiftthistle",
  [2453] = "Bruiseweed",
  [2459] = "Swiftness Potion",
  [2589] = "Linen Cloth",
  [2592] = "Wool Cloth",
  [2604] = "Red Dye",
  [2605] = "Green Dye",
  [2770] = "Copper Ore",
  [2771] = "Tin Ore",
  [2772] = "Iron Ore",
  [2775] = "Silver Ore",
  [2776] = "Gold Ore",
  [2835] = "Rough Stone",
  [2836] = "Coarse Stone",
  [2838] = "Heavy Stone",
  [2840] = "Copper Bar",
  [2841] = "Bronze Bar",
  [2842] = "Silver Bar",
  [2865] = "Rough Bronze Leggings",
  [2880] = "Weak Flux",
  [2996] = "Bolt of Linen Cloth",
  [2997] = "Bolt of Woolen Cloth",
  [3182] = "Spider's Silk",
  [3355] = "Wild Steelbloom",
  [3356] = "Kingsblood",
  [3357] = "Liferoot",
  [3358] = "Khadgar's Whisker",
  [3369] = "Grave Moss",
  [3371] = "Empty Vial",
  [3372] = "Leaded Vial",
  [3383] = "Elixir of Wisdom",
  [3385] = "Lesser Mana Potion",
  [3387] = "Limited Invulnerability Potion",
  [3388] = "Lesser Troll's Blood Elixir",
  [3390] = "Elixir of Lesser Agility",
  [3391] = "Elixir of Ogre Strength",
  [3466] = "Strong Flux",
  [3470] = "Rough Grinding Stone",
  [3478] = "Coarse Grinding Stone",
  [3484] = "Green Iron Boots",
  [3485] = "Green Iron Gauntlets",
  [3486] = "Heavy Grinding Stone",
  [3491] = "Heavy Bronze Mace",
  [3575] = "Iron Bar",
  [3576] = "Tin Bar",
  [3577] = "Gold Bar",
  [3818] = "Fadeleaf",
  [3819] = "Wintersbite",
  [3820] = "Stranglekelp",
  [3821] = "Goldthorn",
  [3823] = "Lesser Invisibility Potion",
  [3824] = "Shadow Oil",
  [3827] = "Mana Potion",
  [3837] = "Golden Scale Coif",
  [3848] = "Big Bronze Knife",
  [3853] = "Moonsteel Broadsword",
  [3857] = "Coal",
  [3858] = "Mithril Ore",
  [3859] = "Steel Bar",
  [3860] = "Mithril Bar",
  [3864] = "Citrine",
  [4231] = "Cured Light Hide",
  [4232] = "Medium Hide",
  [4233] = "Cured Medium Hide",
  [4234] = "Heavy Leather",
  [4235] = "Heavy Hide",
  [4236] = "Cured Heavy Hide",
  [4245] = "Small Silk Pack",
  [4252] = "Dark Leather Shoulders",
  [4254] = "Barbaric Gloves",
  [4289] = "Salt",
  [4291] = "Silken Thread",
  [4304] = "Thick Leather",
  [4305] = "Bolt of Silk Cloth",
  [4306] = "Silk Cloth",
  [4313] = "Red Woolen Boots",
  [4317] = "Phoenix Pants",
  [4321] = "Spider Silk Slippers",
  [4329] = "Star Belt",
  [4337] = "Thick Spider's Silk",
  [4338] = "Mageweave Cloth",
  [4339] = "Bolt of Mageweave",
  [4340] = "Gray Dye",
  [4342] = "Purple Dye",
  [4359] = "Handful of Copper Bolts",
  [4361] = "Copper Tube",
  [4363] = "Copper Modulator",
  [4368] = "Flying Tiger Goggles",
  [4371] = "Bronze Tube",
  [4373] = "Shadow Goggles",
  [4375] = "Whirring Bronze Gizmo",
  [4377] = "Heavy Blasting Powder",
  [4380] = "Big Bronze Bomb",
  [4381] = "Minor Recombobulator",
  [4382] = "Bronze Framework",
  [4383] = "Moonsight Rifle",
  [4384] = "Explosive Sheep",
  [4385] = "Green Tinted Goggles",
  [4387] = "Iron Strut",
  [4389] = "Gyrochronatom",
  [4392] = "Advanced Target Dummy",
  [4393] = "Craftsman's Monocle",
  [4395] = "Goblin Land Mine",
  [4396] = "Mechanical Dragonling",
  [4400] = "Heavy Stock",
  [4402] = "Small Flame Sac",
  [4404] = "Silver Contact",
  [4611] = "Blue Pearl",
  [4623] = "Lesser Stoneshield Potion",
  [4625] = "Firebloom",
  [4852] = "Flash Bomb",
  [5373] = "Lucky Charm",
  [5498] = "Small Lustrous Pearl",
  [5500] = "Iridescent Pearl",
  [5507] = "Ornate Spyglass",
  [5540] = "Pearl-handled Dagger",
  [5541] = "Iridescent Hammer",
  [5633] = "Great Rage Potion",
  [5634] = "Free Action Potion",
  [5637] = "Large Fang",
  [5766] = "Lesser Wizard's Robe",
  [5958] = "Fine Leather Pants",
  [5965] = "Guardian Cloak",
  [5996] = "Draught of Water Breathing",
  [6037] = "Truesilver Bar",
  [6041] = "Steel Weapon Chain",
  [6048] = "Shadow Protection Potion",
  [6049] = "Fire Protection Potion",
  [6050] = "Frost Protection Potion",
  [6052] = "Nature Protection Potion",
  [6260] = "Blue Dye",
  [6261] = "Orange Dye",
  [6263] = "Blue Overalls",
  [6264] = "Greater Adept's Robe",
  [6358] = "Oily Blackmouth",
  [6359] = "Firefin Snapper",
  [6370] = "Blackmouth Oil",
  [6371] = "Fire Oil",
  [6712] = "Practice Lock",
  [7048] = "Azure Silk Hood",
  [7061] = "Earthen Silk Belt",
  [7063] = "Crimson Silk Robe",
  [7067] = "Elemental Earth",
  [7068] = "Elemental Fire",
  [7069] = "Elemental Air",
  [7071] = "Iron Buckle",
  [7076] = "Essence of Earth",
  [7077] = "Heart of Fire",
  [7078] = "Essence of Fire",
  [7079] = "Globe of Water",
  [7191] = "Fused Wiring",
  [7284] = "Red Whelp Gloves",
  [7287] = "Red Whelp Scale",
  [7349] = "Herbalist's Gloves",
  [7358] = "Pilferer's Gloves",
  [7371] = "Heavy Quiver",
  [7378] = "Dusky Bracers",
  [7391] = "Swift Boots",
  [7506] = "Gnomish Universal Remote",
  [7909] = "Aquamarine",
  [7910] = "Star Ruby",
  [7911] = "Truesilver Ore",
  [7912] = "Solid Stone",
  [7922] = "Steel Plate Helm",
  [7928] = "Ornate Mithril Shoulders",
  [7929] = "Orcish War Leggings",
  [7941] = "Heavy Mithril Axe",
  [7942] = "Blue Glittering Axe",
  [7943] = "Wicked Mithril Blade",
  [7947] = "Ebon Shiv",
  [7964] = "Solid Sharpening Stone",
  [7966] = "Solid Grinding Stone",
  [7969] = "Mithril Spurs",
  [7971] = "Black Pearl",
  [7972] = "Ichor of Undeath",
  [8069] = "Crafted Solid Shot",
  [8150] = "Deeprock Salt",
  [8151] = "Flask of Mojo",
  [8153] = "Wildvine",
  [8167] = "Turtle Scale",
  [8169] = "Thick Hide",
  [8170] = "Rugged Leather",
  [8171] = "Rugged Hide",
  [8172] = "Cured Thick Hide",
  [8174] = "Comfortable Leather Hat",
  [8189] = "Turtle Scale Breastplate",
  [8192] = "Nightscape Shoulders",
  [8200] = "Big Voodoo Robe",
  [8201] = "Big Voodoo Mask",
  [8210] = "Wild Leather Shoulders",
  [8214] = "Wild Leather Helmet",
  [8217] = "Quickdraw Quiver",
  [8218] = "Thick Leather Ammo Pouch",
  [8343] = "Heavy Silken Thread",
  [8831] = "Purple Lotus",
  [8836] = "Arthas' Tears",
  [8838] = "Sungrass",
  [8839] = "Blindweed",
  [8845] = "Ghost Mushroom",
  [8846] = "Gromsblood",
  [8925] = "Crystal Vial",
  [8949] = "Elixir of Agility",
  [8951] = "Elixir of Defense",
  [9060] = "Inlaid Mithril Cylinder",
  [9061] = "Goblin Rocket Fuel",
  [9088] = "Gift of Arthas",
  [9144] = "Wildvine Potion",
  [9210] = "Ghost Dye",
  [9224] = "Potion of Demon Slaying",
  [9233] = "Draught of Detect Demon",
  [9260] = "Volatile Rum",
  [9366] = "Golden Scale Gauntlets",
  [9998] = "Black Mageweave Vest",
  [10004] = "Shadoweave Robe",
  [10008] = "White Bandit Mask",
  [10009] = "Red Mageweave Pants",
  [10023] = "Shadoweave Gloves",
  [10025] = "Shadoweave Mask",
  [10036] = "Tuxedo Jacket",
  [10042] = "Cindercloth Robe",
  [10048] = "Colorful Kilt",
  [10050] = "Mageweave Bag",
  [10052] = "Orange Martial Shirt",
  [10285] = "Shadow Silk",
  [10286] = "Heart of the Wild",
  [10498] = "Gyromatic Micro-Adjustor",
  [10500] = "Fire Goggles",
  [10501] = "Catseye Ultra Goggles",
  [10504] = "Green Lens",
  [10505] = "Solid Blasting Powder",
  [10514] = "Mithril Frag Bomb",
  [10548] = "Sniper Scope",
  [10558] = "Gold Power Core",
  [10559] = "Mithril Tube",
  [10560] = "Unstable Trigger",
  [10561] = "Mithril Casing",
  [10592] = "Catseye Draught",
  [10620] = "Thorium Ore",
  [10939] = "Greater Magic Essence",
  [10940] = "Strange Dust",
  [10978] = "Small Glimmering Shard",
  [11040] = "Morrowgrain",
  [11082] = "Greater Astral Essence",
  [11083] = "Soul Dust",
  [11084] = "Large Glimmering Shard",
  [11128] = "Golden Rod",
  [11135] = "Greater Mystic Essence",
  [11137] = "Vision Dust",
  [11138] = "Small Glowing Shard",
  [11139] = "Large Glowing Shard",
  [11144] = "Truesilver Rod",
  [11175] = "Greater Nether Essence",
  [11176] = "Dream Dust",
  [11177] = "Small Radiant Shard",
  [11178] = "Large Radiant Shard",
  [11370] = "Dark Iron Ore",
  [11371] = "Dark Iron Bar",
  [11590] = "Mechanical Repair Kit",
  [12190] = "Dreamless Sleep Potion",
  [12359] = "Thorium Bar",
  [12360] = "Arcanite Bar",
  [12365] = "Dense Stone",
  [12416] = "Radiant Belt",
  [12417] = "Radiant Circlet",
  [12422] = "Imperial Plate Chest",
  [12644] = "Dense Grinding Stone",
  [12775] = "Huge Thorium Battleaxe",
  [12803] = "Living Essence",
  [12810] = "Enchanted Leather",
  [13457] = "Greater Fire Protection Potion",
  [13463] = "Dreamfoil",
  [13464] = "Golden Sansam",
  [13465] = "Mountain Silversage",
  [13466] = "Plaguebloom",
  [13467] = "Icecap",
  [13468] = "Black Lotus",
  [13513] = "Flask of Chromatic Resistance",
  [13864] = "Runecloth Boots",
  [14046] = "Runecloth Bag",
  [14047] = "Runecloth",
  [14048] = "Bolt of Runecloth",
  [14108] = "Felcloth Boots",
  [14130] = "Wizardweave Turban",
  [14141] = "Ghostweave Vest",
  [14227] = "Ironweb Spider Silk",
  [14256] = "Felcloth",
  [14341] = "Rune Thread",
  [14343] = "Small Brilliant Shard",
  [14344] = "Large Brilliant Shard",
  [15053] = "Volcanic Breastplate",
  [15071] = "Frostsaber Boots",
  [15075] = "Chimeric Vest",
  [15080] = "Heavy Scorpid Helm",
  [15084] = "Wicked Leather Bracers",
  [15087] = "Wicked Leather Pants",
  [15092] = "Runic Leather Bracers",
  [15094] = "Runic Leather Headband",
  [15407] = "Cured Rugged Hide",
  [15408] = "Heavy Scorpid Scale",
  [15409] = "Refined Deeprock Salt",
  [15422] = "Frostsaber Leather",
  [15423] = "Chimera Leather",
  [15869] = "Silver Skeleton Key",
  [15872] = "Arcanite Skeleton Key",
  [15992] = "Dense Blasting Powder",
  [15994] = "Thorium Widget",
  [15996] = "Lifelike Mechanical Toad",
  [16000] = "Thorium Tube",
  [16005] = "Dark Iron Bomb",
  [16023] = "Masterwork Target Dummy",
  [16202] = "Lesser Eternal Essence",
  [18232] = "Field Repair Bot 74A",
  [18240] = "Ogre Tannin",
  [18253] = "Major Rejuvenation Potion",
  [18256] = "Imbued Vial",
  [18258] = "Gordok Ogre Suit",
  [18587] = "Goblin Jumper Cables XL",
  [18631] = "Truesilver Transformer",
  [18645] = "Gnomish Alarm-O-Bot",
  [18662] = "Heavy Leather Ball",
  [20520] = "Dark Rune",
  [20549] = "Darkrune Gauntlets",
  [21277] = "Tranquil Mechanical Yeti",
  [21340] = "Soul Pouch",
  [22246] = "Enchanted Mageweave Pouch",
  [22251] = "Cenarion Herb Bag",
  [246948] = "Distilled Firewater",
  [249399] = "Frilled Lichen",
  [249409] = "Cerulean Dye",
  [249424] = "Rosecap",
  [249430] = "Magenta Dye",
}

-- Standard copper shop prices per unit. Prefer Auctionator’s cached merchant price when present.
addon.vendorPrices = {
  [159] = 5, -- Refreshing Spring Water
  [2320] = 10, -- Coarse Thread
  [2321] = 100, -- Fine Thread
  [2324] = 25, -- Bleach
  [2325] = 1000, -- Black Dye
  [2604] = 50, -- Red Dye
  [2605] = 100, -- Green Dye
  [2880] = 100, -- Weak Flux
  [3371] = 4, -- Empty Vial
  [3372] = 40, -- Leaded Vial
  [3466] = 2000, -- Strong Flux
  [3857] = 500, -- Coal
  [4289] = 50, -- Salt
  [4291] = 500, -- Silken Thread
  [4340] = 350, -- Gray Dye
  [4341] = 500, -- Yellow Dye
  [4342] = 2500, -- Purple Dye
  [4399] = 200, -- Wooden Stock
  [4400] = 2000, -- Heavy Stock
  [4470] = 38, -- Simple Wood
  [6260] = 50, -- Blue Dye
  [6261] = 1000, -- Orange Dye
  [8343] = 2000, -- Heavy Silken Thread
  [8925] = 500, -- Crystal Vial
  [10290] = 2500, -- Pink Dye
  [14341] = 5000, -- Rune Thread
  [18256] = 6000, -- Imbued Vial
  [18567] = 150000, -- Elemental Flux
}

-- Raw leather uses its own auction price. Leather trade-up spells are excluded.
-- Cooldown-limited transmutes are excluded from repeatable crafts.
addon.recipes = {
  [2317] = { -- Dark Leather Tunic
    { spellID = 2169, name = "Dark Leather Tunic", yield = 1, reagents = { { 2319, 6 }, { 2321, 1 }, { 4340, 1 } } },
  },
  [2459] = { -- Swiftness Potion
    { spellID = 2335, name = "Swiftness Potion", yield = 1, reagents = { { 2452, 1 }, { 2450, 1 }, { 3371, 1 } } },
  },
  [2840] = { -- Copper Bar
    { spellID = 2657, name = "Smelt Copper", yield = 1, reagents = { { 2770, 1 } } },
  },
  [2841] = { -- Bronze Bar
    { spellID = 2659, name = "Smelt Bronze", yield = 2, reagents = { { 2840, 1 }, { 3576, 1 } } },
  },
  [2842] = { -- Silver Bar
    { spellID = 2658, name = "Smelt Silver", yield = 1, reagents = { { 2775, 1 } } },
  },
  [2865] = { -- Rough Bronze Leggings
    { spellID = 2668, name = "Rough Bronze Leggings", yield = 1, reagents = { { 2841, 6 } } },
  },
  [2996] = { -- Bolt of Linen Cloth
    { spellID = 2963, name = "Bolt of Linen Cloth", yield = 1, reagents = { { 2589, 2 } } },
  },
  [2997] = { -- Bolt of Woolen Cloth
    { spellID = 2964, name = "Bolt of Woolen Cloth", yield = 1, reagents = { { 2592, 3 } } },
  },
  [3383] = { -- Elixir of Wisdom
    { spellID = 3171, name = "Elixir of Wisdom", yield = 1, reagents = { { 785, 1 }, { 2450, 2 }, { 3371, 1 } } },
  },
  [3385] = { -- Lesser Mana Potion
    { spellID = 3173, name = "Lesser Mana Potion", yield = 1, reagents = { { 785, 1 }, { 3820, 1 }, { 3371, 1 } } },
  },
  [3387] = { -- Limited Invulnerability Potion
    { spellID = 3175, name = "Limited Invulnerability Potion", yield = 1, reagents = { { 8839, 2 }, { 8845, 1 }, { 8925, 1 } } },
  },
  [3388] = { -- Lesser Troll's Blood Elixir
    { spellID = 3176, name = "Lesser Troll's Blood Elixir", yield = 1, reagents = { { 2453, 2 }, { 2450, 2 }, { 3372, 1 } } },
  },
  [3390] = { -- Elixir of Lesser Agility
    { spellID = 2333, name = "Elixir of Lesser Agility", yield = 1, reagents = { { 3355, 1 }, { 2452, 1 }, { 3372, 1 } } },
  },
  [3391] = { -- Elixir of Ogre Strength
    { spellID = 3188, name = "Elixir of Ogre Strength", yield = 1, reagents = { { 2449, 1 }, { 3356, 1 }, { 3372, 1 } } },
  },
  [3470] = { -- Rough Grinding Stone
    { spellID = 3320, name = "Rough Grinding Stone", yield = 1, reagents = { { 2835, 2 } } },
  },
  [3478] = { -- Coarse Grinding Stone
    { spellID = 3326, name = "Coarse Grinding Stone", yield = 1, reagents = { { 2836, 2 } } },
  },
  [3484] = { -- Green Iron Boots
    { spellID = 3334, name = "Green Iron Boots", yield = 1, reagents = { { 3575, 4 }, { 1705, 2 }, { 3478, 2 }, { 2605, 1 } } },
  },
  [3485] = { -- Green Iron Gauntlets
    { spellID = 3336, name = "Green Iron Gauntlets", yield = 1, reagents = { { 3575, 4 }, { 5498, 2 }, { 3478, 2 }, { 2605, 1 } } },
  },
  [3486] = { -- Heavy Grinding Stone
    { spellID = 3337, name = "Heavy Grinding Stone", yield = 1, reagents = { { 2838, 3 } } },
  },
  [3491] = { -- Heavy Bronze Mace
    { spellID = 3296, name = "Heavy Bronze Mace", yield = 1, reagents = { { 2841, 8 }, { 3466, 1 }, { 1206, 1 }, { 1210, 1 }, { 3478, 2 }, { 2319, 2 } } },
  },
  [3575] = { -- Iron Bar
    { spellID = 3307, name = "Smelt Iron", yield = 1, reagents = { { 2772, 1 } } },
  },
  [3576] = { -- Tin Bar
    { spellID = 3304, name = "Smelt Tin", yield = 1, reagents = { { 2771, 1 } } },
  },
  [3577] = { -- Gold Bar
    { spellID = 3308, name = "Smelt Gold", yield = 1, reagents = { { 2776, 1 } } },
  },
  [3823] = { -- Lesser Invisibility Potion
    { spellID = 3448, name = "Lesser Invisibility Potion", yield = 1, reagents = { { 3818, 1 }, { 3355, 1 }, { 3372, 1 } } },
  },
  [3824] = { -- Shadow Oil
    { spellID = 3449, name = "Shadow Oil", yield = 2, reagents = { { 3818, 4 }, { 3369, 4 }, { 3372, 1 } } },
  },
  [3827] = { -- Mana Potion
    { spellID = 3452, name = "Mana Potion", yield = 1, reagents = { { 3820, 1 }, { 3356, 1 }, { 3372, 1 } } },
  },
  [3837] = { -- Golden Scale Coif
    { spellID = 3503, name = "Golden Scale Coif", yield = 1, reagents = { { 3859, 8 }, { 3577, 2 }, { 3486, 2 } } },
  },
  [3848] = { -- Big Bronze Knife
    { spellID = 3491, name = "Big Bronze Knife", yield = 1, reagents = { { 2841, 6 }, { 2880, 4 }, { 3470, 2 }, { 818, 1 }, { 2319, 1 } } },
  },
  [3853] = { -- Moonsteel Broadsword
    { spellID = 3496, name = "Moonsteel Broadsword", yield = 1, reagents = { { 3859, 8 }, { 3466, 2 }, { 3486, 2 }, { 1705, 3 }, { 4234, 3 } } },
  },
  [3859] = { -- Steel Bar
    { spellID = 3569, name = "Smelt Steel", yield = 1, reagents = { { 3575, 1 }, { 3857, 1 } } },
  },
  [3860] = { -- Mithril Bar
    { spellID = 10097, name = "Smelt Mithril", yield = 1, reagents = { { 3858, 1 } } },
  },
  [4231] = { -- Cured Light Hide
    { spellID = 3816, name = "Cured Light Hide", yield = 1, reagents = { { 783, 1 }, { 4289, 1 } } },
  },
  [4233] = { -- Cured Medium Hide
    { spellID = 3817, name = "Cured Medium Hide", yield = 1, reagents = { { 4232, 1 }, { 4289, 1 } } },
  },
  [4236] = { -- Cured Heavy Hide
    { spellID = 3818, name = "Cured Heavy Hide", yield = 1, reagents = { { 4235, 1 }, { 4289, 3 } } },
  },
  [4245] = { -- Small Silk Pack
    { spellID = 3813, name = "Small Silk Pack", yield = 1, reagents = { { 4305, 3 }, { 4234, 2 }, { 2321, 3 } } },
  },
  [4252] = { -- Dark Leather Shoulders
    { spellID = 3769, name = "Dark Leather Shoulders", yield = 1, reagents = { { 2319, 12 }, { 3390, 1 }, { 4340, 1 }, { 2321, 2 } } },
  },
  [4254] = { -- Barbaric Gloves
    { spellID = 3771, name = "Barbaric Gloves", yield = 1, reagents = { { 4234, 6 }, { 5637, 2 }, { 2321, 1 } } },
  },
  [4305] = { -- Bolt of Silk Cloth
    { spellID = 3839, name = "Bolt of Silk Cloth", yield = 1, reagents = { { 4306, 4 } } },
  },
  [4313] = { -- Red Woolen Boots
    { spellID = 3847, name = "Red Woolen Boots", yield = 1, reagents = { { 2997, 4 }, { 2318, 2 }, { 2321, 1 }, { 2604, 2 } } },
  },
  [4317] = { -- Phoenix Pants
    { spellID = 3851, name = "Phoenix Pants", yield = 1, reagents = { { 2997, 6 }, { 5500, 1 }, { 2321, 3 } } },
  },
  [4321] = { -- Spider Silk Slippers
    { spellID = 3856, name = "Spider Silk Slippers", yield = 1, reagents = { { 4305, 3 }, { 3182, 1 }, { 2321, 2 } } },
  },
  [4329] = { -- Star Belt
    { spellID = 3864, name = "Star Belt", yield = 1, reagents = { { 4339, 4 }, { 4234, 4 }, { 3864, 1 }, { 7071, 1 }, { 4291, 1 } } },
  },
  [4339] = { -- Bolt of Mageweave
    { spellID = 3865, name = "Bolt of Mageweave", yield = 1, reagents = { { 4338, 5 } } },
  },
  [4359] = { -- Handful of Copper Bolts
    { spellID = 3922, name = "Handful of Copper Bolts", yield = 1, reagents = { { 2840, 1 } } },
  },
  [4361] = { -- Copper Tube
    { spellID = 3924, name = "Copper Tube", yield = 1, reagents = { { 2840, 2 }, { 2880, 1 } } },
  },
  [4363] = { -- Copper Modulator
    { spellID = 3926, name = "Copper Modulator", yield = 1, reagents = { { 4359, 2 }, { 2840, 1 }, { 2589, 2 } } },
  },
  [4368] = { -- Flying Tiger Goggles
    { spellID = 3934, name = "Flying Tiger Goggles", yield = 1, reagents = { { 2318, 6 }, { 818, 2 } } },
  },
  [4371] = { -- Bronze Tube
    { spellID = 3938, name = "Bronze Tube", yield = 1, reagents = { { 2841, 2 }, { 2880, 1 } } },
  },
  [4373] = { -- Shadow Goggles
    { spellID = 3940, name = "Shadow Goggles", yield = 1, reagents = { { 2319, 4 }, { 1210, 2 } } },
  },
  [4375] = { -- Whirring Bronze Gizmo
    { spellID = 3942, name = "Whirring Bronze Gizmo", yield = 1, reagents = { { 2841, 2 }, { 2592, 1 } } },
  },
  [4377] = { -- Heavy Blasting Powder
    { spellID = 3945, name = "Heavy Blasting Powder", yield = 1, reagents = { { 2838, 1 } } },
  },
  [4380] = { -- Big Bronze Bomb
    { spellID = 3950, name = "Big Bronze Bomb", yield = 3, reagents = { { 4377, 2 }, { 2841, 3 }, { 4404, 1 } } },
  },
  [4381] = { -- Minor Recombobulator
    { spellID = 3952, name = "Minor Recombobulator", yield = 1, reagents = { { 4371, 1 }, { 4375, 2 }, { 2319, 2 }, { 1206, 1 } } },
  },
  [4382] = { -- Bronze Framework
    { spellID = 3953, name = "Bronze Framework", yield = 1, reagents = { { 2841, 2 }, { 2319, 1 }, { 2592, 1 } } },
  },
  [4383] = { -- Moonsight Rifle
    { spellID = 3954, name = "Moonsight Rifle", yield = 1, reagents = { { 4371, 3 }, { 4375, 3 }, { 4400, 1 }, { 1705, 2 } } },
  },
  [4384] = { -- Explosive Sheep
    { spellID = 3955, name = "Explosive Sheep", yield = 1, reagents = { { 4382, 1 }, { 4375, 1 }, { 4377, 2 }, { 2592, 2 } } },
  },
  [4385] = { -- Green Tinted Goggles
    { spellID = 3956, name = "Green Tinted Goggles", yield = 1, reagents = { { 2319, 4 }, { 1206, 2 }, { 4368, 1 } } },
  },
  [4387] = { -- Iron Strut
    { spellID = 3958, name = "Iron Strut", yield = 1, reagents = { { 3575, 2 } } },
  },
  [4389] = { -- Gyrochronatom
    { spellID = 3961, name = "Gyrochronatom", yield = 1, reagents = { { 3575, 1 }, { 10558, 1 } } },
  },
  [4392] = { -- Advanced Target Dummy
    { spellID = 3965, name = "Advanced Target Dummy", yield = 1, reagents = { { 4387, 1 }, { 4382, 1 }, { 4389, 1 }, { 4234, 4 } } },
  },
  [4393] = { -- Craftsman's Monocle
    { spellID = 3966, name = "Craftsman's Monocle", yield = 1, reagents = { { 4234, 6 }, { 3864, 2 } } },
  },
  [4395] = { -- Goblin Land Mine
    { spellID = 3968, name = "Goblin Land Mine", yield = 1, reagents = { { 4377, 3 }, { 3575, 2 }, { 4389, 1 } } },
  },
  [4396] = { -- Mechanical Dragonling
    { spellID = 3969, name = "Mechanical Dragonling", yield = 1, reagents = { { 4382, 1 }, { 4387, 4 }, { 4389, 4 }, { 3864, 2 }, { 7191, 1 } } },
  },
  [4404] = { -- Silver Contact
    { spellID = 3973, name = "Silver Contact", yield = 5, reagents = { { 2842, 1 } } },
  },
  [4623] = { -- Lesser Stoneshield Potion
    { spellID = 4942, name = "Lesser Stoneshield Potion", yield = 1, reagents = { { 3858, 1 }, { 3821, 1 }, { 3372, 1 } } },
  },
  [4852] = { -- Flash Bomb
    { spellID = 8243, name = "Flash Bomb", yield = 1, reagents = { { 4611, 1 }, { 4377, 1 }, { 4306, 1 } } },
  },
  [5507] = { -- Ornate Spyglass
    { spellID = 6458, name = "Ornate Spyglass", yield = 1, reagents = { { 4371, 2 }, { 4375, 2 }, { 4363, 1 }, { 1206, 1 } } },
  },
  [5540] = { -- Pearl-handled Dagger
    { spellID = 6517, name = "Pearl-handled Dagger", yield = 1, reagents = { { 2841, 6 }, { 3466, 1 }, { 5498, 2 }, { 3478, 2 } } },
  },
  [5541] = { -- Iridescent Hammer
    { spellID = 6518, name = "Iridescent Hammer", yield = 1, reagents = { { 2841, 10 }, { 3466, 1 }, { 5500, 1 }, { 3478, 2 }, { 2319, 2 } } },
  },
  [5633] = { -- Great Rage Potion
    { spellID = 6618, name = "Great Rage Potion", yield = 1, reagents = { { 5637, 1 }, { 3356, 1 }, { 3372, 1 } } },
  },
  [5634] = { -- Free Action Potion
    { spellID = 6624, name = "Free Action Potion", yield = 1, reagents = { { 6370, 2 }, { 3820, 1 }, { 3372, 1 } } },
  },
  [5766] = { -- Lesser Wizard's Robe
    { spellID = 6690, name = "Lesser Wizard's Robe", yield = 1, reagents = { { 4305, 2 }, { 2321, 2 }, { 3182, 2 } } },
  },
  [5958] = { -- Fine Leather Pants
    { spellID = 7133, name = "Fine Leather Pants", yield = 1, reagents = { { 2319, 8 }, { 2997, 1 }, { 2321, 1 } } },
  },
  [5965] = { -- Guardian Cloak
    { spellID = 7153, name = "Guardian Cloak", yield = 1, reagents = { { 4234, 14 }, { 4305, 2 }, { 4291, 2 } } },
  },
  [5996] = { -- Draught of Water Breathing
    { spellID = 7179, name = "Draught of Water Breathing", yield = 1, reagents = { { 3820, 1 }, { 6370, 2 }, { 3371, 1 } } },
  },
  [6037] = { -- Truesilver Bar
    { spellID = 10098, name = "Smelt Truesilver", yield = 1, reagents = { { 7911, 1 } } },
  },
  [6041] = { -- Steel Weapon Chain
    { spellID = 7224, name = "Steel Weapon Chain", yield = 1, reagents = { { 3859, 8 }, { 3486, 2 }, { 4234, 4 } } },
  },
  [6048] = { -- Shadow Protection Potion
    { spellID = 7256, name = "Shadow Protection Potion", yield = 1, reagents = { { 3369, 1 }, { 3356, 1 }, { 3372, 1 } } },
  },
  [6049] = { -- Fire Protection Potion
    { spellID = 7257, name = "Fire Protection Potion", yield = 1, reagents = { { 4402, 1 }, { 6371, 1 }, { 3372, 1 } } },
  },
  [6050] = { -- Frost Protection Potion
    { spellID = 7258, name = "Frost Protection Potion", yield = 1, reagents = { { 3819, 1 }, { 3821, 1 }, { 3372, 1 } } },
  },
  [6052] = { -- Nature Protection Potion
    { spellID = 7259, name = "Nature Protection Potion", yield = 1, reagents = { { 3357, 1 }, { 3820, 1 }, { 3372, 1 } } },
  },
  [6263] = { -- Blue Overalls
    { spellID = 7639, name = "Blue Overalls", yield = 1, reagents = { { 2997, 4 }, { 2321, 2 }, { 6260, 2 } } },
  },
  [6264] = { -- Greater Adept's Robe
    { spellID = 7643, name = "Greater Adept's Robe", yield = 1, reagents = { { 2997, 5 }, { 2321, 3 }, { 2604, 3 } } },
  },
  [6370] = { -- Blackmouth Oil
    { spellID = 7836, name = "Blackmouth Oil", yield = 1, reagents = { { 6358, 2 }, { 3371, 1 } } },
  },
  [6371] = { -- Fire Oil
    { spellID = 7837, name = "Fire Oil", yield = 2, reagents = { { 6359, 2 }, { 3371, 1 } } },
  },
  [6712] = { -- Practice Lock
    { spellID = 8334, name = "Practice Lock", yield = 1, reagents = { { 2841, 1 }, { 4359, 2 }, { 2880, 1 } } },
  },
  [7048] = { -- Azure Silk Hood
    { spellID = 8760, name = "Azure Silk Hood", yield = 1, reagents = { { 4305, 2 }, { 6260, 2 }, { 2321, 1 } } },
  },
  [7061] = { -- Earthen Silk Belt
    { spellID = 8797, name = "Earthen Silk Belt", yield = 1, reagents = { { 4305, 5 }, { 7067, 4 }, { 4234, 4 }, { 7071, 1 }, { 4291, 2 } } },
  },
  [7063] = { -- Crimson Silk Robe
    { spellID = 8802, name = "Crimson Silk Robe", yield = 1, reagents = { { 4305, 8 }, { 7068, 4 }, { 3827, 2 }, { 2604, 4 }, { 4291, 1 } } },
  },
  [7071] = { -- Iron Buckle
    { spellID = 8768, name = "Iron Buckle", yield = 2, reagents = { { 3575, 1 } } },
  },
  [7284] = { -- Red Whelp Gloves
    { spellID = 9072, name = "Red Whelp Gloves", yield = 1, reagents = { { 7287, 6 }, { 2319, 4 }, { 2321, 1 } } },
  },
  [7349] = { -- Herbalist's Gloves
    { spellID = 9146, name = "Herbalist's Gloves", yield = 1, reagents = { { 2319, 8 }, { 3356, 4 }, { 2321, 2 } } },
  },
  [7358] = { -- Pilferer's Gloves
    { spellID = 9148, name = "Pilferer's Gloves", yield = 1, reagents = { { 2319, 10 }, { 5373, 2 }, { 2321, 2 } } },
  },
  [7371] = { -- Heavy Quiver
    { spellID = 9193, name = "Heavy Quiver", yield = 1, reagents = { { 4234, 8 }, { 2321, 2 } } },
  },
  [7378] = { -- Dusky Bracers
    { spellID = 9201, name = "Dusky Bracers", yield = 1, reagents = { { 4234, 16 }, { 2325, 1 }, { 4291, 2 } } },
  },
  [7391] = { -- Swift Boots
    { spellID = 9208, name = "Swift Boots", yield = 1, reagents = { { 4234, 10 }, { 2459, 2 }, { 4337, 2 }, { 4291, 1 } } },
  },
  [7506] = { -- Gnomish Universal Remote
    { spellID = 9269, name = "Gnomish Universal Remote", yield = 1, reagents = { { 2841, 6 }, { 4375, 1 }, { 814, 2 }, { 818, 1 }, { 774, 1 } } },
  },
  [7922] = { -- Steel Plate Helm
    { spellID = 9935, name = "Steel Plate Helm", yield = 1, reagents = { { 3859, 14 }, { 7966, 1 } } },
  },
  [7928] = { -- Ornate Mithril Shoulders
    { spellID = 9952, name = "Ornate Mithril Shoulders", yield = 1, reagents = { { 3860, 12 }, { 6037, 1 }, { 4304, 6 } } },
  },
  [7929] = { -- Orcish War Leggings
    { spellID = 9957, name = "Orcish War Leggings", yield = 1, reagents = { { 3860, 12 }, { 7067, 1 } } },
  },
  [7941] = { -- Heavy Mithril Axe
    { spellID = 9993, name = "Heavy Mithril Axe", yield = 1, reagents = { { 3860, 12 }, { 3864, 2 }, { 7966, 1 }, { 4234, 4 } } },
  },
  [7942] = { -- Blue Glittering Axe
    { spellID = 9995, name = "Blue Glittering Axe", yield = 1, reagents = { { 3860, 16 }, { 7909, 2 }, { 7966, 1 }, { 4304, 4 } } },
  },
  [7943] = { -- Wicked Mithril Blade
    { spellID = 9997, name = "Wicked Mithril Blade", yield = 1, reagents = { { 3860, 14 }, { 6037, 4 }, { 7966, 1 }, { 4304, 2 } } },
  },
  [7947] = { -- Ebon Shiv
    { spellID = 10013, name = "Ebon Shiv", yield = 1, reagents = { { 3860, 12 }, { 6037, 6 }, { 7910, 2 }, { 7966, 1 }, { 4304, 2 } } },
  },
  [7964] = { -- Solid Sharpening Stone
    { spellID = 9918, name = "Solid Sharpening Stone", yield = 1, reagents = { { 7912, 1 } } },
  },
  [7966] = { -- Solid Grinding Stone
    { spellID = 9920, name = "Solid Grinding Stone", yield = 1, reagents = { { 7912, 4 } } },
  },
  [7969] = { -- Mithril Spurs
    { spellID = 9964, name = "Mithril Spurs", yield = 1, reagents = { { 3860, 4 }, { 7966, 3 } } },
  },
  [8069] = { -- Crafted Solid Shot
    { spellID = 3947, name = "Crafted Solid Shot", yield = 200, reagents = { { 4377, 1 }, { 2841, 1 } } },
  },
  [8172] = { -- Cured Thick Hide
    { spellID = 10482, name = "Cured Thick Hide", yield = 1, reagents = { { 8169, 1 }, { 8150, 1 } } },
  },
  [8174] = { -- Comfortable Leather Hat
    { spellID = 10490, name = "Comfortable Leather Hat", yield = 1, reagents = { { 4234, 12 }, { 4236, 2 }, { 4291, 2 } } },
  },
  [8189] = { -- Turtle Scale Breastplate
    { spellID = 10511, name = "Turtle Scale Breastplate", yield = 1, reagents = { { 4304, 6 }, { 8167, 12 }, { 8343, 1 } } },
  },
  [8192] = { -- Nightscape Shoulders
    { spellID = 10516, name = "Nightscape Shoulders", yield = 1, reagents = { { 4304, 8 }, { 4338, 6 }, { 4291, 3 } } },
  },
  [8200] = { -- Big Voodoo Robe
    { spellID = 10520, name = "Big Voodoo Robe", yield = 1, reagents = { { 4304, 10 }, { 8151, 4 }, { 8343, 1 } } },
  },
  [8201] = { -- Big Voodoo Mask
    { spellID = 10531, name = "Big Voodoo Mask", yield = 1, reagents = { { 4304, 8 }, { 8151, 6 }, { 8343, 1 } } },
  },
  [8210] = { -- Wild Leather Shoulders
    { spellID = 10529, name = "Wild Leather Shoulders", yield = 1, reagents = { { 4304, 10 }, { 8153, 1 }, { 8172, 1 } } },
  },
  [8214] = { -- Wild Leather Helmet
    { spellID = 10546, name = "Wild Leather Helmet", yield = 1, reagents = { { 4304, 10 }, { 8153, 2 }, { 8172, 1 } } },
  },
  [8217] = { -- Quickdraw Quiver
    { spellID = 14930, name = "Quickdraw Quiver", yield = 1, reagents = { { 4304, 12 }, { 8172, 1 }, { 8949, 1 }, { 4291, 4 } } },
  },
  [8218] = { -- Thick Leather Ammo Pouch
    { spellID = 14932, name = "Thick Leather Ammo Pouch", yield = 1, reagents = { { 4304, 10 }, { 8172, 1 }, { 8951, 1 }, { 4291, 6 } } },
  },
  [8949] = { -- Elixir of Agility
    { spellID = 11449, name = "Elixir of Agility", yield = 1, reagents = { { 3820, 1 }, { 3821, 1 }, { 3372, 1 } } },
  },
  [8951] = { -- Elixir of Defense
    { spellID = 11450, name = "Elixir of Defense", yield = 1, reagents = { { 3355, 1 }, { 3821, 1 }, { 3372, 1 } } },
  },
  [9060] = { -- Inlaid Mithril Cylinder
    { spellID = 11454, name = "Inlaid Mithril Cylinder", yield = 1, reagents = { { 3860, 5 }, { 3577, 1 }, { 6037, 1 } } },
  },
  [9061] = { -- Goblin Rocket Fuel
    { spellID = 11456, name = "Goblin Rocket Fuel", yield = 2, reagents = { { 4625, 1 }, { 9260, 1 }, { 3372, 1 } } },
  },
  [9088] = { -- Gift of Arthas
    { spellID = 11466, name = "Gift of Arthas", yield = 1, reagents = { { 8836, 1 }, { 8839, 1 }, { 8925, 1 } } },
  },
  [9144] = { -- Wildvine Potion
    { spellID = 11458, name = "Wildvine Potion", yield = 1, reagents = { { 8153, 1 }, { 8831, 1 }, { 8925, 1 } } },
  },
  [9210] = { -- Ghost Dye
    { spellID = 11473, name = "Ghost Dye", yield = 2, reagents = { { 8845, 2 }, { 4342, 1 }, { 8925, 1 } } },
  },
  [9224] = { -- Potion of Demon Slaying
    { spellID = 11477, name = "Potion of Demon Slaying", yield = 1, reagents = { { 8846, 1 }, { 8845, 1 }, { 8925, 1 } } },
  },
  [9233] = { -- Draught of Detect Demon
    { spellID = 11478, name = "Draught of Detect Demon", yield = 1, reagents = { { 8846, 2 }, { 8925, 1 } } },
  },
  [9366] = { -- Golden Scale Gauntlets
    { spellID = 11643, name = "Golden Scale Gauntlets", yield = 1, reagents = { { 3859, 10 }, { 3577, 4 }, { 3486, 4 }, { 3864, 1 } } },
  },
  [9998] = { -- Black Mageweave Vest
    { spellID = 12048, name = "Black Mageweave Vest", yield = 1, reagents = { { 4339, 2 }, { 4291, 3 } } },
  },
  [10004] = { -- Shadoweave Robe
    { spellID = 12055, name = "Shadoweave Robe", yield = 1, reagents = { { 4339, 3 }, { 10285, 2 }, { 8343, 1 } } },
  },
  [10008] = { -- White Bandit Mask
    { spellID = 12059, name = "White Bandit Mask", yield = 1, reagents = { { 4339, 1 }, { 2324, 1 }, { 8343, 1 } } },
  },
  [10009] = { -- Red Mageweave Pants
    { spellID = 12060, name = "Red Mageweave Pants", yield = 1, reagents = { { 4339, 3 }, { 2604, 2 }, { 8343, 1 } } },
  },
  [10023] = { -- Shadoweave Gloves
    { spellID = 12071, name = "Shadoweave Gloves", yield = 1, reagents = { { 4339, 5 }, { 10285, 5 }, { 8343, 2 } } },
  },
  [10025] = { -- Shadoweave Mask
    { spellID = 12086, name = "Shadoweave Mask", yield = 1, reagents = { { 4339, 2 }, { 10285, 8 }, { 8343, 2 } } },
  },
  [10036] = { -- Tuxedo Jacket
    { spellID = 12093, name = "Tuxedo Jacket", yield = 1, reagents = { { 4339, 5 }, { 8343, 3 } } },
  },
  [10042] = { -- Cindercloth Robe
    { spellID = 12069, name = "Cindercloth Robe", yield = 1, reagents = { { 4339, 5 }, { 7077, 2 }, { 8343, 2 } } },
  },
  [10048] = { -- Colorful Kilt
    { spellID = 12047, name = "Colorful Kilt", yield = 1, reagents = { { 2997, 5 }, { 2604, 3 }, { 2321, 1 } } },
  },
  [10050] = { -- Mageweave Bag
    { spellID = 12065, name = "Mageweave Bag", yield = 1, reagents = { { 4339, 4 }, { 4291, 2 } } },
  },
  [10052] = { -- Orange Martial Shirt
    { spellID = 12064, name = "Orange Martial Shirt", yield = 1, reagents = { { 4339, 2 }, { 6261, 2 }, { 8343, 1 } } },
  },
  [10498] = { -- Gyromatic Micro-Adjustor
    { spellID = 12590, name = "Gyromatic Micro-Adjustor", yield = 1, reagents = { { 3859, 4 } } },
  },
  [10500] = { -- Fire Goggles
    { spellID = 12594, name = "Fire Goggles", yield = 1, reagents = { { 4385, 1 }, { 3864, 2 }, { 7068, 2 }, { 4234, 4 } } },
  },
  [10501] = { -- Catseye Ultra Goggles
    { spellID = 12607, name = "Catseye Ultra Goggles", yield = 1, reagents = { { 4304, 4 }, { 7909, 2 }, { 10592, 1 } } },
  },
  [10504] = { -- Green Lens
    { spellID = 12622, name = "Green Lens", yield = 1, reagents = { { 4304, 8 }, { 1529, 3 }, { 7909, 3 }, { 10286, 2 }, { 8153, 2 } } },
  },
  [10505] = { -- Solid Blasting Powder
    { spellID = 12585, name = "Solid Blasting Powder", yield = 1, reagents = { { 7912, 2 } } },
  },
  [10514] = { -- Mithril Frag Bomb
    { spellID = 12603, name = "Mithril Frag Bomb", yield = 3, reagents = { { 10561, 1 }, { 10560, 1 }, { 10505, 1 } } },
  },
  [10548] = { -- Sniper Scope
    { spellID = 12620, name = "Sniper Scope", yield = 1, reagents = { { 10559, 1 }, { 7910, 1 }, { 6037, 2 } } },
  },
  [10558] = { -- Gold Power Core
    { spellID = 12584, name = "Gold Power Core", yield = 3, reagents = { { 3577, 1 } } },
  },
  [10559] = { -- Mithril Tube
    { spellID = 12589, name = "Mithril Tube", yield = 1, reagents = { { 3860, 3 } } },
  },
  [10560] = { -- Unstable Trigger
    { spellID = 12591, name = "Unstable Trigger", yield = 1, reagents = { { 3860, 1 }, { 4338, 1 }, { 10505, 1 } } },
  },
  [10561] = { -- Mithril Casing
    { spellID = 12599, name = "Mithril Casing", yield = 1, reagents = { { 3860, 3 } } },
  },
  [10592] = { -- Catseye Draught
    { spellID = 12609, name = "Catseye Draught", yield = 1, reagents = { { 3821, 1 }, { 3818, 1 }, { 3372, 1 } } },
  },
  [11128] = { -- Golden Rod
    { spellID = 14379, name = "Golden Rod", yield = 1, reagents = { { 3577, 1 }, { 3478, 2 } } },
  },
  [11144] = { -- Truesilver Rod
    { spellID = 14380, name = "Truesilver Rod", yield = 1, reagents = { { 6037, 1 }, { 3486, 1 } } },
  },
  [11371] = { -- Dark Iron Bar
    { spellID = 14891, name = "Smelt Dark Iron", yield = 1, reagents = { { 11370, 8 } } },
  },
  [11590] = { -- Mechanical Repair Kit
    { spellID = 15255, name = "Mechanical Repair Kit", yield = 1, reagents = { { 3860, 1 }, { 4338, 1 }, { 10505, 1 } } },
  },
  [12190] = { -- Dreamless Sleep Potion
    { spellID = 15833, name = "Dreamless Sleep Potion", yield = 1, reagents = { { 8831, 3 }, { 8925, 1 } } },
  },
  [12359] = { -- Thorium Bar
    { spellID = 16153, name = "Smelt Thorium", yield = 1, reagents = { { 10620, 1 } } },
  },
  [12416] = { -- Radiant Belt
    { spellID = 16645, name = "Radiant Belt", yield = 1, reagents = { { 12359, 10 }, { 7077, 2 } } },
  },
  [12417] = { -- Radiant Circlet
    { spellID = 16659, name = "Radiant Circlet", yield = 1, reagents = { { 12359, 18 }, { 7077, 4 } } },
  },
  [12422] = { -- Imperial Plate Chest
    { spellID = 16663, name = "Imperial Plate Chest", yield = 1, reagents = { { 12359, 40 }, { 7910, 2 } } },
  },
  [12644] = { -- Dense Grinding Stone
    { spellID = 16639, name = "Dense Grinding Stone", yield = 1, reagents = { { 12365, 4 } } },
  },
  [12775] = { -- Huge Thorium Battleaxe
    { spellID = 16971, name = "Huge Thorium Battleaxe", yield = 1, reagents = { { 12359, 40 }, { 12644, 6 }, { 8170, 6 } } },
  },
  [12810] = { -- Enchanted Leather
    { spellID = 17181, name = "Enchanted Leather", yield = 1, reagents = { { 8170, 1 }, { 16202, 1 } } },
  },
  [13457] = { -- Greater Fire Protection Potion
    { spellID = 17574, name = "Greater Fire Protection Potion", yield = 1, reagents = { { 7068, 1 }, { 13463, 1 }, { 8925, 1 } } },
  },
  [13513] = { -- Flask of Chromatic Resistance
    { spellID = 17638, name = "Flask of Chromatic Resistance", yield = 1, reagents = { { 13467, 30 }, { 13465, 10 }, { 13468, 1 }, { 8925, 1 } } },
  },
  [13864] = { -- Runecloth Boots
    { spellID = 18423, name = "Runecloth Boots", yield = 1, reagents = { { 14048, 4 }, { 14227, 2 }, { 8170, 4 }, { 14341, 1 } } },
  },
  [14046] = { -- Runecloth Bag
    { spellID = 18405, name = "Runecloth Bag", yield = 1, reagents = { { 14048, 5 }, { 8170, 2 }, { 14341, 1 }, { 249430, 4 }, { 249409, 2 } } },
  },
  [14048] = { -- Bolt of Runecloth
    { spellID = 18401, name = "Bolt of Runecloth", yield = 1, reagents = { { 14047, 5 } } },
  },
  [14108] = { -- Felcloth Boots
    { spellID = 18437, name = "Felcloth Boots", yield = 1, reagents = { { 14048, 6 }, { 14256, 4 }, { 8170, 4 }, { 14341, 1 } } },
  },
  [14130] = { -- Wizardweave Turban
    { spellID = 18450, name = "Wizardweave Turban", yield = 1, reagents = { { 14048, 6 }, { 11176, 4 }, { 7910, 1 }, { 14341, 1 } } },
  },
  [14141] = { -- Ghostweave Vest
    { spellID = 18416, name = "Ghostweave Vest", yield = 1, reagents = { { 14048, 6 }, { 9210, 4 }, { 14227, 1 }, { 14341, 1 } } },
  },
  [15053] = { -- Volcanic Breastplate
    { spellID = 19076, name = "Volcanic Breastplate", yield = 1, reagents = { { 8170, 8 }, { 7078, 1 }, { 7076, 1 }, { 14341, 1 } } },
  },
  [15071] = { -- Frostsaber Boots
    { spellID = 19066, name = "Frostsaber Boots", yield = 1, reagents = { { 8170, 4 }, { 15422, 6 }, { 14341, 1 } } },
  },
  [15075] = { -- Chimeric Vest
    { spellID = 19081, name = "Chimeric Vest", yield = 1, reagents = { { 8170, 10 }, { 15423, 10 }, { 14341, 1 } } },
  },
  [15080] = { -- Heavy Scorpid Helm
    { spellID = 19088, name = "Heavy Scorpid Helm", yield = 1, reagents = { { 8170, 8 }, { 15408, 12 }, { 15407, 1 }, { 14341, 1 } } },
  },
  [15084] = { -- Wicked Leather Bracers
    { spellID = 19052, name = "Wicked Leather Bracers", yield = 1, reagents = { { 8170, 8 }, { 2325, 1 }, { 14341, 1 } } },
  },
  [15087] = { -- Wicked Leather Pants
    { spellID = 19083, name = "Wicked Leather Pants", yield = 1, reagents = { { 8170, 16 }, { 15407, 1 }, { 2325, 3 }, { 14341, 1 } } },
  },
  [15092] = { -- Runic Leather Bracers
    { spellID = 19065, name = "Runic Leather Bracers", yield = 1, reagents = { { 8170, 6 }, { 7971, 1 }, { 14047, 6 }, { 14341, 1 } } },
  },
  [15094] = { -- Runic Leather Headband
    { spellID = 19082, name = "Runic Leather Headband", yield = 1, reagents = { { 8170, 14 }, { 14047, 10 }, { 14341, 1 } } },
  },
  [15407] = { -- Cured Rugged Hide
    { spellID = 19047, name = "Cured Rugged Hide", yield = 2, reagents = { { 8171, 1 }, { 15409, 1 } } },
  },
  [15869] = { -- Silver Skeleton Key
    { spellID = 19666, name = "Silver Skeleton Key", yield = 2, reagents = { { 2842, 1 }, { 3470, 1 } } },
  },
  [15872] = { -- Arcanite Skeleton Key
    { spellID = 19669, name = "Arcanite Skeleton Key", yield = 2, reagents = { { 12360, 1 }, { 12644, 1 } } },
  },
  [15992] = { -- Dense Blasting Powder
    { spellID = 19788, name = "Dense Blasting Powder", yield = 1, reagents = { { 12365, 2 } } },
  },
  [15994] = { -- Thorium Widget
    { spellID = 19791, name = "Thorium Widget", yield = 1, reagents = { { 12359, 3 }, { 14047, 1 } } },
  },
  [15996] = { -- Lifelike Mechanical Toad
    { spellID = 19793, name = "Lifelike Mechanical Toad", yield = 1, reagents = { { 12803, 1 }, { 15994, 4 }, { 10558, 1 }, { 8170, 1 } } },
  },
  [16000] = { -- Thorium Tube
    { spellID = 19795, name = "Thorium Tube", yield = 1, reagents = { { 12359, 6 } } },
  },
  [16005] = { -- Dark Iron Bomb
    { spellID = 19799, name = "Dark Iron Bomb", yield = 3, reagents = { { 15994, 2 }, { 11371, 1 }, { 15992, 3 }, { 14047, 3 } } },
  },
  [16023] = { -- Masterwork Target Dummy
    { spellID = 19814, name = "Masterwork Target Dummy", yield = 1, reagents = { { 10561, 1 }, { 16000, 1 }, { 15994, 2 }, { 6037, 1 }, { 8170, 2 }, { 14047, 4 } } },
  },
  [18232] = { -- Field Repair Bot 74A
    { spellID = 22704, name = "Field Repair Bot 74A", yield = 1, reagents = { { 12359, 12 }, { 8170, 4 }, { 7191, 1 }, { 7067, 2 }, { 7068, 1 } } },
  },
  [18253] = { -- Major Rejuvenation Potion
    { spellID = 22732, name = "Major Rejuvenation Potion", yield = 1, reagents = { { 10286, 1 }, { 13464, 4 }, { 13463, 4 }, { 18256, 1 } } },
  },
  [18258] = { -- Gordok Ogre Suit
    { spellID = 22813, name = "Gordok Ogre Suit", yield = 1, reagents = { { 14048, 2 }, { 8170, 4 }, { 18240, 1 }, { 14341, 1 } } },
    { spellID = 22815, name = "Gordok Ogre Suit", yield = 1, reagents = { { 8170, 4 }, { 14048, 2 }, { 18240, 1 }, { 14341, 1 } } },
  },
  [18587] = { -- Goblin Jumper Cables XL
    { spellID = 23078, name = "Goblin Jumper Cables XL", yield = 1, reagents = { { 15994, 2 }, { 18631, 2 }, { 7191, 2 }, { 14227, 2 }, { 7910, 2 } } },
  },
  [18631] = { -- Truesilver Transformer
    { spellID = 23071, name = "Truesilver Transformer", yield = 1, reagents = { { 6037, 2 }, { 7067, 2 }, { 7069, 1 } } },
  },
  [18645] = { -- Gnomish Alarm-O-Bot
    { spellID = 23096, name = "Alarm-O-Bot", yield = 1, reagents = { { 12359, 4 }, { 15994, 2 }, { 8170, 4 }, { 7910, 1 }, { 7191, 1 } } },
  },
  [18662] = { -- Heavy Leather Ball
    { spellID = 23190, name = "Heavy Leather Ball", yield = 1, reagents = { { 4234, 2 }, { 2321, 1 } } },
  },
  [20549] = { -- Darkrune Gauntlets
    { spellID = 24912, name = "Darkrune Gauntlets", yield = 1, reagents = { { 12359, 12 }, { 20520, 6 }, { 6037, 6 }, { 12810, 2 } } },
  },
  [21277] = { -- Tranquil Mechanical Yeti
    { spellID = 26011, name = "Tranquil Mechanical Yeti", yield = 1, reagents = { { 15407, 1 }, { 15994, 4 }, { 7079, 2 }, { 18631, 2 }, { 10558, 1 } } },
  },
  [21340] = { -- Soul Pouch
    { spellID = 26085, name = "Soul Pouch", yield = 1, reagents = { { 14048, 6 }, { 8170, 4 }, { 7972, 2 }, { 14341, 1 } } },
  },
  [22246] = { -- Enchanted Mageweave Pouch
    { spellID = 27658, name = "Enchanted Mageweave Pouch", yield = 1, reagents = { { 4339, 4 }, { 11137, 4 }, { 8343, 2 } } },
  },
  [22251] = { -- Cenarion Herb Bag
    { spellID = 27724, name = "Cenarion Herb Bag", yield = 1, reagents = { { 14048, 5 }, { 8831, 10 }, { 11040, 8 }, { 14341, 2 } } },
  },
  [246948] = { -- Distilled Firewater
    { spellID = 1244421, name = "Distilled Firewater", yield = 1, reagents = { { 3819, 4 }, { 8846, 2 }, { 3372, 1 } } },
  },
  [249409] = { -- Cerulean Dye
    { spellID = 1249630, name = "Cerulean Dye", yield = 1, reagents = { { 249399, 2 }, { 3371, 1 } } },
  },
  [249430] = { -- Magenta Dye
    { spellID = 1249631, name = "Magenta Dye", yield = 1, reagents = { { 249424, 2 }, { 3372, 1 } } },
  },
}
