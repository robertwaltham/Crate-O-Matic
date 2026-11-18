# Crate-O-Matic

Crate-O-Matic adds an Auction House tab to World of Warcraft Forever for comparing Waylaid Crate fill costs, Craftsman's Writ turn-in costs, and potential crafting profits. It uses Auctionator's cached prices to help you decide what to buy or craft.

## What it shows

- **Waylaid Crates** ranks crates by gold per Merchant's Favor, including the price of the empty crate and its cheapest priced fill. Where recipe data is available, it compares buying the fill items with crafting them. Artisan Favor payouts are estimates.
- **Craftsman's Writs** ranks writs by net cost per point of base reputation: the writ and its required items, minus the estimated Coin Pouch payout. A negative net cost means the pouch is expected to cover the cost and leave some coin. Hover over a writ for its upfront cost and turn-in location when available. Writs you've turned in today are marked.
- **Profit Crafting** ranks writ items by estimated profit per craft after a 5% Auction House cut. Hover over an item for its material costs and estimated sale proceeds. Crafting estimates assume you have access to the recipes.

## Install and use

1. Place the `Crate-O-Matic` folder in `_forever_/Interface/AddOns/`, with `Crate-O-Matic.toc` directly inside it.
2. Enable Crate-O-Matic and Auctionator, then open the Auction House and select the **Crate-O-Matic** tab.
3. Hover over rows for cost details. With Auctionator's Shopping tab enabled, click a row to search for the items you'd need to buy in the required quantities.

## Credits

- Coin Pouch estimates use [Wowhead's reported loot values](https://www.wowhead.com/forever/guide/professions/craftsmans-writs-overview-recipes-rewards) and [community reports for Expert writs](https://www.wowhead.com/forever/item=284585/coin-pouch). Actual payouts vary.
- LibAHTab is copyright © 2022 plusmouse and is available under the [MIT License](Libs/LibAHTab-LICENSE).
- LibStub is in the public domain. See the [credits in its source](Libs/LibStub.lua).
