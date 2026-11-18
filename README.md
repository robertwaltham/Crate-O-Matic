# Crate-O-Matic

Crate-O-Matic adds an Auction House tab to World of Warcraft Forever for comparing Waylaid Crate fill costs, Craftsman's Writ turn-in costs, crafting profits, and Forger's Quill rerolls. It uses Auctionator's cached prices to help you decide what to buy or craft.

## What it shows

- **Waylaid Crates** ranks crates by gold per Merchant's Favor, including the price of the empty crate and its cheapest priced fill. Where recipe data is available, it compares buying the fill items with crafting them. Favor amounts are base turn-in rewards.
- **Craftsman's Writs** ranks writs by net cost per point of base reputation: the writ and its required items, minus the estimated Coin Pouch payout. A negative net cost means the pouch is expected to cover the cost and leave some coin. Hover over a writ for its upfront cost and turn-in location when available. Writs you've turned in today are marked.
- **Profit Crafting** ranks writ items by estimated profit per craft after a 5% Auction House cut. Hover over an item for its material costs and estimated sale proceeds. Crafting estimates assume you have access to the recipes.
- **Forger's Quill** shows the cheapest auction writ per tier and the filled crate with the lowest cost per Merchant's Favor. The reroll cost adds one Quill to the input writ price and compares the total with the same-tier sealed writ's auction price. The cheaper option is highlighted. A Quill costs 15 Favor, valued at that crate's cost per Favor. Net expected value is average resale after the Auction House cut, minus the reroll cost. Each other same-tier writ with a cached price gets equal weight. The priced outcome count shows coverage, and the range shows one standard deviation on either side of the mean when at least two outcomes have prices. Click a writ row to search for the input writ.

## Install and use

1. Place the `Crate-O-Matic` folder in `_forever_/Interface/AddOns/`, with `Crate-O-Matic.toc` directly inside it.
2. Enable Crate-O-Matic and Auctionator, then open the Auction House and select the **Crate-O-Matic** tab.
3. Hover over rows for cost details. With Auctionator's Shopping tab enabled, click a row to search for the items you'd need to buy in the required quantities.

## Credits

- Artisan crate Favor payouts follow the live rewards reported by [Waylaid Auction Helper 1.2.1](https://www.curseforge.com/wow/addons/waylaid-auction-helper/files/9580959).
- Coin Pouch estimates use [Wowhead's reported loot values](https://www.wowhead.com/forever/guide/professions/craftsmans-writs-overview-recipes-rewards) and [community reports for Expert writs](https://www.wowhead.com/forever/item=284585/coin-pouch). Actual payouts vary.
- LibAHTab is copyright © 2022 plusmouse and is available under the [MIT License](Libs/LibAHTab-LICENSE).
- LibStub is in the public domain. See the [credits in its source](Libs/LibStub.lua).
