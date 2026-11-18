local addonName, addon = ...

addon.AUCTION_CUT_PERCENT = 5
addon.QUILL_FAVOR_COST = 15 -- Forger's Quill (item 262896)

local function positivePrice(price)
  return type(price) == "number" and price > 0 and price < math.huge and price or nil
end

local function newPriceLookup(api)
  local auctionPrices = {}
  local plans = {}

  local function auctionPrice(itemID)
    if auctionPrices[itemID] == nil then
      auctionPrices[itemID] = api and positivePrice(api.GetAuctionPriceByItemID(addonName, itemID)) or false
    end
    return auctionPrices[itemID]
  end

  local function vendorUnitPrice(itemID)
    local price = addon.vendorPrices[itemID]
    if price and api and api.GetVendorPriceByItemID then
      return positivePrice(api.GetVendorPriceByItemID(addonName, itemID)) or price
    end
    return price
  end

  -- The bundled recipe graph is acyclic. Memoize by quantity so each estimate
  -- accounts for whole crafts, including when pricing crafted intermediates.
  local function cheapest(itemID, quantity)
    local itemPlans = plans[itemID]
    if not itemPlans then
      itemPlans = {}
      plans[itemID] = itemPlans
    end
    if itemPlans[quantity] ~= nil then
      return itemPlans[quantity]
    end

    local best
    local vendorPrice = vendorUnitPrice(itemID)
    if vendorPrice then
      best = { source = "Vendor", itemID = itemID, quantity = quantity, cost = vendorPrice * quantity }
    else
      local unitPrice = auctionPrice(itemID)
      if unitPrice then
        best = { source = "Buy", itemID = itemID, quantity = quantity, cost = unitPrice * quantity }
      end
      local recipes = addon.recipes[itemID]
      if recipes then
        for _, recipe in ipairs(recipes) do
          local fullCrafts = math.ceil(quantity / recipe.yield)
          -- Compare a full run with buying the units of the last partial batch.
          local firstCrafts = fullCrafts
          if unitPrice and fullCrafts > 1 and quantity % recipe.yield ~= 0 then
            firstCrafts = fullCrafts - 1
          end
          for crafts = firstCrafts, fullCrafts do
            local remainder = math.max(0, quantity - crafts * recipe.yield)
            local cost = remainder > 0 and remainder * unitPrice or 0
            local ingredients = {}
            for _, reagent in ipairs(recipe.reagents) do
              local input = cheapest(reagent[1], reagent[2] * crafts)
              if not input then
                cost = nil
                break
              end
              cost = cost + input.cost
              ingredients[#ingredients + 1] = input
            end
            if cost and (not best or cost < best.cost) then
              best = {
                source = remainder > 0 and "Craft + buy" or "Craft",
                itemID = itemID, quantity = quantity, cost = cost, recipe = recipe,
                crafts = crafts, ingredients = ingredients, remainder = remainder,
              }
            end
          end
        end
      end
    end

    itemPlans[quantity] = best or false
    return itemPlans[quantity]
  end

  return auctionPrice, cheapest, vendorUnitPrice
end

function addon.Calculate(api, entries, rewardKey)
  local auctionPrice, cheapest = newPriceLookup(api)
  local results = {}
  local missingEntry, missingBundle = 0, 0

  for _, entry in ipairs(entries) do
    local entryPrice = auctionPrice(entry.id)
    if not entryPrice then
      missingEntry = missingEntry + 1
    else
      local best, priced = nil, 0
      for _, bundle in ipairs(entry.bundles) do
        local plan = cheapest(bundle[1], bundle[2])
        if plan then
          priced = priced + 1
          if not best or plan.cost < best.cost then
            best = plan
          end
        end
      end

      if best then
        local total = entryPrice + best.cost
        local netCost = total - (entry.estimatedPurse or 0)
        local reward = entry[rewardKey]
        results[#results + 1] = {
          entry = entry, entryPrice = entryPrice, bundle = best,
          reward = reward, total = total, netCost = netCost, perReward = netCost / reward, pricedBundles = priced,
        }
      else
        missingBundle = missingBundle + 1
      end
    end
  end

  table.sort(results, function(left, right)
    if left.perReward ~= right.perReward then
      return left.perReward < right.perReward
    end
    if left.netCost ~= right.netCost then
      return left.netCost < right.netCost
    end
    return left.entry.id < right.entry.id
  end)
  return results, missingEntry, missingBundle
end

local writTiers = {
  { name = "Journeyman", reputation = 75, sealedID = 262888 },
  { name = "Expert", reputation = 125, sealedID = 262889 },
  { name = "Artisan", reputation = 200, sealedID = 262890 },
}

function addon.CalculateQuill(api)
  local crates = addon.Calculate(api, addon.crates, "favor")
  local crate = crates[1]
  local quillCost = crate and crate.perReward * addon.QUILL_FAVOR_COST
  local auctionPrice = newPriceLookup(api)
  local saleMultiplier = 1 - addon.AUCTION_CUT_PERCENT / 100
  local tiers = {}

  for _, tier in ipairs(writTiers) do
    local writs = {}
    local result = { name = tier.name, pricedCount = 0, sealedPrice = auctionPrice(tier.sealedID) or nil }
    for _, writ in ipairs(addon.writs) do
      if writ.reputation == tier.reputation then
        writs[#writs + 1] = writ
        local price = auctionPrice(writ.id)
        if price and (not result.writPrice or price < result.writPrice
          or (price == result.writPrice and writ.id < result.entry.id)) then
          result.entry = writ
          result.writPrice = price
        end
      end
    end
    result.outcomeCount = math.max(0, #writs - 1)

    if result.entry then
      result.rerollCost = quillCost and result.writPrice + quillCost
      -- Accumulate the population variance of the priced alternatives.
      local count, mean, squaredDeviations = 0, 0, 0
      for _, writ in ipairs(writs) do
        local price = auctionPrice(writ.id)
        if writ ~= result.entry and price then
          local sale = price * saleMultiplier
          count = count + 1
          local delta = sale - mean
          mean = mean + delta / count
          squaredDeviations = squaredDeviations + delta * (sale - mean)
        end
      end
      result.pricedCount = count
      if count > 0 then
        result.meanSale = mean
        result.netValue = result.rerollCost and mean - result.rerollCost
      end
      if count > 1 then
        result.deviation = math.sqrt(squaredDeviations / count)
      end
    end
    tiers[#tiers + 1] = result
  end

  return tiers, crate, quillCost
end

-- Price cooldown reagents at their market value in Profit Crafting.
local cooldownMaterials = {
  [12360] = true, -- Arcanite Bar
  [14342] = true, -- Mooncloth
  [15407] = true, -- Cured Rugged Hide (Refined Deeprock Salt cooldown)
}

local function addBaseMaterials(itemID, quantity, materials, surplus)
  local recipes = addon.recipes[itemID]
  if cooldownMaterials[itemID] or not recipes then
    materials[itemID] = (materials[itemID] or 0) + quantity
    return
  end

  -- The only bundled alternatives have the same yield and reagents.
  local recipe = recipes[1]
  local needed = quantity - (surplus[itemID] or 0)
  local crafts = math.max(0, math.ceil(needed / recipe.yield))
  surplus[itemID] = crafts * recipe.yield - needed
  if crafts > 0 then
    for _, reagent in ipairs(recipe.reagents) do
      addBaseMaterials(reagent[1], reagent[2] * crafts, materials, surplus)
    end
  end
end

local profitItems = {}
local seen = {}
for _, writ in ipairs(addon.writs) do
  for _, bundle in ipairs(writ.bundles) do
    local itemID = bundle[1]
    if not seen[itemID] then
      seen[itemID] = true
      local recipes = addon.recipes[itemID]
      local entry = { id = itemID, name = addon.itemNames[itemID] or writ.name, materials = {} }
      if recipes then
        local recipe = recipes[1]
        entry.yield = recipe.yield
        local quantities, surplus = {}, {}
        for _, reagent in ipairs(recipe.reagents) do
          addBaseMaterials(reagent[1], reagent[2], quantities, surplus)
        end
        for materialID, quantity in pairs(quantities) do
          entry.materials[#entry.materials + 1] = { id = materialID, quantity = quantity }
        end
        table.sort(entry.materials, function(left, right) return left.id < right.id end)
      end
      profitItems[#profitItems + 1] = entry
    end
  end
end
addon.profitItemCount = #profitItems

function addon.CalculateProfit(api)
  local auctionPrice, _, vendorUnitPrice = newPriceLookup(api)
  local results = {}
  local pricedCount = 0
  for _, entry in ipairs(profitItems) do
    local result = { entry = entry, materials = {} }
    local salePrice = auctionPrice(entry.id)
    if salePrice and entry.yield then
      result.sale = salePrice * entry.yield
      result.cut = result.sale * addon.AUCTION_CUT_PERCENT / 100
    end

    local totalCost = 0
    local complete = entry.yield ~= nil
    for _, material in ipairs(entry.materials) do
      local vendorPrice = not cooldownMaterials[material.id] and vendorUnitPrice(material.id) or nil
      local unitPrice = vendorPrice or auctionPrice(material.id)
      local cost = unitPrice and unitPrice * material.quantity
      result.materials[#result.materials + 1] = {
        id = material.id, quantity = material.quantity, vendor = vendorPrice ~= nil, cost = cost,
      }
      if cost then
        totalCost = totalCost + cost
      else
        complete = false
      end
    end
    if complete then
      result.cost = totalCost
      if result.sale then
        result.rawProfit = result.sale - totalCost
        result.netProfit = result.rawProfit - result.cut
        pricedCount = pricedCount + 1
      end
    end
    results[#results + 1] = result
  end

  table.sort(results, function(left, right)
    if left.netProfit ~= right.netProfit then
      if left.netProfit == nil then return false end
      if right.netProfit == nil then return true end
      return left.netProfit > right.netProfit
    end
    if left.entry.name ~= right.entry.name then
      return left.entry.name < right.entry.name
    end
    return left.entry.id < right.entry.id
  end)
  return results, pricedCount
end
