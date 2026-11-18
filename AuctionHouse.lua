local _, addon = ...

local TITLE = "Crate-O-Matic"
local TAB_ID = "CrateOMatic"
local PANEL_WIDTH = 738
local ROW_HEIGHT = 25
local LIST_WIDTH = PANEL_WIDTH - 48
local LIST_HEIGHT = 250
local panel

local profitView = {
  label = "Profit Crafting", plural = "writ items",
  note = "Estimates per craft. Cooldown materials use AH prices. Assumes recipe access and faction AH fees.",
}

local writView = {
  label = "Craftsman's Writs", entries = addon.writs, rewardKey = "reputation",
  itemTitle = "Craftsman's Writ", inputTitle = "Required turn-in", rewardTitle = "Rep",
  metric = "Net / Rep", detail = "Net cost per reputation point",
  priceLabel = "Writ (AH)", prefix = "Craftsman's Writ: ", plural = "writs", missingInput = "turn-ins",
  note = "Net cost subtracts the estimated Coin Pouch payout. Rep is the base quest reward.",
}

local quillView = {
  label = "Forger's Quill",
  note = "Rerolls assume equally likely same-tier alternatives. Estimates use priced outcomes and base crate rewards.",
}

local views = {
  {
    label = "Waylaid Crates", entries = addon.crates, rewardKey = "favor",
    itemTitle = "Waylaid Crate", inputTitle = "Cheapest bundle", rewardTitle = "Favor",
    metric = "Cost / Favor", detail = "Cost per Merchant's Favor",
    priceLabel = "Empty crate (AH)", prefix = "Waylaid Crate: ", plural = "crates", missingInput = "fills",
    note = "* Artisan Favor is estimated. Craft costs assume access to the recipe.",
  },
  writView,
  profitView,
  quillView,
}

local columns = {
  { title = "#", x = 7, width = 23 },
  { x = 33, width = 165 },
  { x = 204, width = 204 },
  { title = "Source", x = 412, width = 74 },
  { x = 489, width = 40 },
  { title = "Total cost", x = 533, width = 74, align = "RIGHT" },
  { x = 615, width = 70, align = "RIGHT" },
}

local writColumns = {
  { title = "#", x = 7, width = 23 },
  { x = 33, width = 148 },
  { x = 186, width = 169 },
  { title = "Source", x = 359, width = 66 },
  { x = 430, width = 28 },
  { title = "Est. Purse", x = 462, width = 62, align = "RIGHT" },
  { title = "Net Cost", x = 529, width = 81, align = "RIGHT" },
  { x = 615, width = 70, align = "RIGHT" },
}

local profitColumns = {
  { title = "#", x = 7, width = 23 },
  { title = "Crafted item", x = 33, width = 219 },
  { title = "Yield", x = 256, width = 39, align = "RIGHT" },
  { title = "Materials", x = 302, width = 84, align = "RIGHT" },
  { title = "AH sale", x = 393, width = 90, align = "RIGHT" },
  { title = "Raw profit", x = 490, width = 92, align = "RIGHT" },
  { title = ("After %d%% AH cut"):format(addon.AUCTION_CUT_PERCENT), x = 589, width = 96, align = "RIGHT" },
}

local quillColumns = {
  { title = "Tier", x = 7, width = 88 },
  { title = "Cheapest writ (AH)", x = 100, width = 178 },
  { title = "Writ cost", x = 284, width = 83, align = "RIGHT" },
  { title = "Priced outcomes", x = 373, width = 88, align = "RIGHT" },
  { title = "Net EV", x = 466, width = 69, align = "RIGHT" },
  { title = "-1 SD", x = 541, width = 69, align = "RIGHT" },
  { title = "+1 SD", x = 616, width = 69, align = "RIGHT" },
}

local function money(copper)
  local sign = copper < 0 and "-" or ""
  copper = math.abs(copper)
  if copper > 0 and copper < 1 then
    return sign .. "<1c"
  end
  copper = math.floor(copper + 0.5)
  local gold = math.floor(copper / 10000)
  local silver = math.floor(copper / 100) % 100
  local remainder = copper % 100
  if gold > 0 then
    return sign .. ("%dg %02ds %02dc"):format(gold, silver, remainder)
  end
  if silver > 0 then
    return sign .. ("%ds %02dc"):format(silver, remainder)
  end
  return sign .. ("%dc"):format(remainder)
end

local function itemName(itemID)
  return addon.itemNames[itemID] or ("Item " .. itemID)
end

local function purseValue(entry)
  return entry.estimatedPurse and money(entry.estimatedPurse) or "Unknown"
end

local function addPlanPurchases(plan, addItem)
  if plan.source == "Buy" then
    addItem(plan.itemID, plan.quantity)
  elseif plan.recipe then
    for _, input in ipairs(plan.ingredients) do
      addPlanPurchases(input, addItem)
    end
    if plan.remainder > 0 then
      addItem(plan.itemID, plan.remainder)
    end
  end
end

local function shopForRow(row)
  panel.shoppingRequest = nil
  local api = Auctionator and Auctionator.API and Auctionator.API.v1
  if not api or not api.MultiSearchAdvanced then
    panel.status:SetText("Enable Auctionator's Shopping tab to shop for this row.")
    return
  end

  local itemIDs, quantities = {}, {}
  local function addItem(itemID, quantity)
    if not quantities[itemID] then
      itemIDs[#itemIDs + 1] = itemID
    end
    quantities[itemID] = (quantities[itemID] or 0) + quantity
  end

  if panel.view == quillView then
    if not row.entry then return end
    addItem(row.entry.id, 1)
  elseif panel.view == profitView then
    for _, material in ipairs(row.result.materials) do
      if not material.vendor then
        addItem(material.id, material.quantity)
      end
    end
  else
    local entry = row.entry
    if not row.result and #entry.bundles > 1 then
      panel.status:SetText("More cached prices are needed to pick a fill for this crate.")
      return
    end
    addItem(entry.id, 1)
    if row.result then
      addPlanPurchases(row.result.bundle, addItem)
    else
      local bundle = entry.bundles[1]
      if not addon.vendorPrices[bundle[1]] then
        addItem(bundle[1], bundle[2])
      end
    end
  end

  local remaining = #itemIDs
  if remaining == 0 then
    panel.status:SetText("This craft has no auction materials to search for.")
    return
  end

  -- Wait for the exact, localized names, including items not seen this session.
  local terms = {}
  panel.shoppingRequest = terms
  panel.status:SetText("Looking up item names for Auctionator…")
  for index, itemID in ipairs(itemIDs) do
    local item = Item:CreateFromItemID(itemID)
    item:ContinueOnItemLoad(function()
      if panel.shoppingRequest ~= terms then return end
      terms[index] = { searchString = item:GetItemName(), quantity = quantities[itemID], isExact = true }
      remaining = remaining - 1
      if remaining == 0 then
        panel.shoppingRequest = nil
        api.MultiSearchAdvanced(TITLE, terms)
      end
    end)
  end
end

local function addPlanDetails(plan, indent)
  if not plan.recipe then
    local source = plan.source == "Vendor" and "vendor" or "AH"
    GameTooltip:AddDoubleLine(
      ("%s%d x %s (%s)"):format(indent, plan.quantity, itemName(plan.itemID), source), money(plan.cost))
    return
  end

  GameTooltip:AddLine(("%s%d x %s"):format(indent, plan.crafts, plan.recipe.name), 0.82, 0.88, 1)
  for _, input in ipairs(plan.ingredients) do
    addPlanDetails(input, indent .. "  ")
  end
  if plan.remainder > 0 then
    GameTooltip:AddLine(("%sBuy %d x %s from the AH"):format(indent, plan.remainder, itemName(plan.itemID)), 0.85, 0.85, 0.85)
  end
end

local function showProfitDetails(result)
  if not result.entry.yield then
    GameTooltip:AddLine("Recipe data unavailable.", 1, 0.74, 0.35)
    return
  end
  GameTooltip:AddDoubleLine("Yield per craft", tostring(result.entry.yield))
  GameTooltip:AddDoubleLine("AH sale", result.sale and money(result.sale) or "Unpriced")
  if result.cut then
    GameTooltip:AddDoubleLine("AH cut", money(result.cut))
  end
  GameTooltip:AddLine(" ")
  GameTooltip:AddDoubleLine("Materials", result.cost and money(result.cost) or "Unpriced")
  for _, material in ipairs(result.materials) do
    local source = material.vendor and "vendor" or "AH"
    GameTooltip:AddDoubleLine(("%d x %s (%s)"):format(material.quantity, itemName(material.id), source),
      material.cost and money(material.cost) or "Unpriced")
  end
end

local function showRowTooltip(row)
  local result = row.result
  local entry = row.entry
  local view = panel.view
  GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
  if view == quillView then
    GameTooltip:SetText(result.name, 1, 0.82, 0)
    if entry then
      GameTooltip:AddDoubleLine("Input writ", entry.name)
      GameTooltip:AddDoubleLine("Input writ cost", money(result.writPrice))
      GameTooltip:AddDoubleLine("Alternative writs priced", ("%d of %d"):format(result.pricedCount, result.outcomeCount))
      if result.meanSale then
        GameTooltip:AddDoubleLine("Average resale after AH cut", money(result.meanSale))
      end
      if result.deviation then
        GameTooltip:AddDoubleLine("Standard deviation", money(result.deviation))
      end
    else
      GameTooltip:AddLine("No cached writ prices for this tier.")
    end
    GameTooltip:Show()
    return
  elseif view == profitView then
    GameTooltip:SetText(entry.name, 1, 0.82, 0)
    showProfitDetails(result)
    GameTooltip:Show()
    return
  end
  GameTooltip:SetText(view.prefix .. entry.name, 1, 0.82, 0)
  if row.completed then
    GameTooltip:AddLine("Turned in today.", 0.65, 0.65, 0.65)
  end
  if entry.questID then
    local location = addon.writLocations[entry.questID]
    if location then
      GameTooltip:AddDoubleLine("Turn in to", location.name)
      GameTooltip:AddDoubleLine("Location", ("%s (%.2f, %.2f)"):format(location.zone, location.x, location.y))
    else
      GameTooltip:AddLine("Turn-in location unconfirmed.", 1, 0.74, 0.35)
    end
    GameTooltip:AddLine(" ")
  end
  if not result then
    if view == writView then
      GameTooltip:AddDoubleLine("Estimated Coin Pouch", purseValue(entry))
    end
    GameTooltip:AddLine("Complete auction prices unavailable.", 1, 0.74, 0.35)
    for _, bundle in ipairs(entry.bundles) do
      GameTooltip:AddLine(("%d x %s"):format(bundle[2], itemName(bundle[1])), 0.85, 0.85, 0.85)
    end
    GameTooltip:Show()
    return
  end
  local bundle = result.bundle
  GameTooltip:AddDoubleLine(view.priceLabel, money(result.entryPrice))
  GameTooltip:AddDoubleLine(("%d x %s"):format(bundle.quantity, itemName(bundle.itemID)), money(bundle.cost))
  if view == writView then
    GameTooltip:AddDoubleLine("Upfront cost", money(result.total))
    GameTooltip:AddDoubleLine("Estimated Coin Pouch", purseValue(entry))
    GameTooltip:AddDoubleLine("Net cost", money(result.netCost))
  else
    GameTooltip:AddDoubleLine("Total", money(result.total))
  end
  GameTooltip:AddDoubleLine(view.detail, money(result.perReward))
  if bundle.recipe then
    GameTooltip:AddLine(" ")
    addPlanDetails(bundle, "")
  end
  if result.pricedBundles < #entry.bundles then
    GameTooltip:AddLine(("Prices found for %d of %d bundles."):format(result.pricedBundles, #entry.bundles), 1, 0.74, 0.35)
  end
  if entry.estimatedFavor then
    GameTooltip:AddLine(("Estimated Artisan payout: %d Favor."):format(result.reward), 1, 0.74, 0.35)
  end
  GameTooltip:Show()
end

local function updateCompletion(row)
  local questID = panel.view == writView and row.entry and row.entry.questID
  local checkCompletion = C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted or IsQuestFlaggedCompleted
  local completed = questID and checkCompletion and checkCompletion(questID) == true or false
  if row.completed == completed then
    return
  end
  row.completed = completed

  for index, cell in ipairs(row.cells) do
    if completed then
      cell:SetTextColor(0.55, 0.55, 0.55)
    elseif index == #panel.columnLayout then
      cell:SetTextColor(0.52, 0.9, 0.65)
    else
      cell:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
    end
  end
  if GameTooltip:IsOwned(row) then
    showRowTooltip(row)
  end
end

local function refreshWritCompletion()
  if panel and panel:IsVisible() and panel.view == writView then
    for _, row in ipairs(panel.rows) do
      updateCompletion(row)
    end
  end
end

local function updateDailyResetTimer()
  if panel.dailyResetTimer then
    panel.dailyResetTimer:Cancel()
    panel.dailyResetTimer = nil
  end
  if not panel:IsVisible() or panel.view ~= writView then
    return
  end
  local getReset = C_DateAndTime and C_DateAndTime.GetSecondsUntilDailyReset or GetQuestResetTime
  local seconds = getReset and getReset()
  if seconds and seconds >= 0 then
    panel.dailyResetTimer = C_Timer.NewTimer(math.max(seconds + 1, 2), function()
      panel.dailyResetTimer = nil
      refreshWritCompletion()
      updateDailyResetTimer()
    end)
  end
end

local function setProfitColor(cell, profit)
  if profit and profit > 0 then
    cell:SetTextColor(0.52, 0.9, 0.65)
  elseif profit and profit < 0 then
    cell:SetTextColor(1, 0.5, 0.5)
  else
    cell:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
  end
end

local function setRow(row, entry, rank, result)
  row.entry = entry
  row.result = result
  if not entry and not result then
    row:Hide()
    return
  end
  local view = panel.view
  local values
  if view == quillView then
    local netValue, deviation = result.netValue, result.deviation
    values = {
      result.name, entry and entry.name or "Unpriced", entry and money(result.writPrice) or "-",
      entry and ("%d / %d"):format(result.pricedCount, result.outcomeCount) or "-",
      netValue and money(netValue) or "-",
      netValue and deviation and money(netValue - deviation) or "-",
      netValue and deviation and money(netValue + deviation) or "-",
    }
  elseif view == profitView then
    values = {
      result.netProfit and rank or "", entry.name, entry.yield or "-",
      result.cost and money(result.cost) or "Unpriced", result.sale and money(result.sale) or "Unpriced",
      result.rawProfit and money(result.rawProfit) or "-", result.netProfit and money(result.netProfit) or "-",
    }
  else
    local reward = entry[view.rewardKey] .. (entry.estimatedFavor and "*" or "")
    if result then
      local bundle = result.bundle
      values = {
        rank, entry.name, ("%d x %s"):format(bundle.quantity, itemName(bundle.itemID)),
        bundle.source, reward,
      }
    else
      local bundle = entry.bundles[1]
      local input = #entry.bundles == 1 and ("%d x %s"):format(bundle[2], itemName(bundle[1])) or "See fill options"
      values = { "", entry.name, input, "", reward }
    end
    if view == writView then
      values[#values + 1] = purseValue(entry)
    end
    values[#values + 1] = result and money(result.netCost) or "Unpriced"
    values[#values + 1] = result and money(result.perReward) or ""
  end
  for index, value in ipairs(values) do
    row.cells[index]:SetText(value)
  end
  updateCompletion(row)
  if view == profitView then
    setProfitColor(row.cells[6], result.rawProfit)
    setProfitColor(row.cells[7], result.netProfit)
    row.completed = nil
  elseif view == quillView then
    setProfitColor(row.cells[5], result.netValue)
    row.cells[7]:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
  end
  row:Show()
end

local function layoutCells(cells, layout)
  for index, cell in ipairs(cells) do
    local column = layout[index]
    if column then
      cell:ClearAllPoints()
      cell:SetPoint("LEFT", column.x, 0)
      cell:SetWidth(column.width)
      cell:SetJustifyH(column.align or "LEFT")
      cell:Show()
    else
      cell:Hide()
    end
  end
end

local function selectView(frame, view)
  frame.view = view
  for index, tab in ipairs(frame.viewTabs) do
    tab:SetEnabled(views[index] ~= view)
  end
  local layout = view == quillView and quillColumns or view == profitView and profitColumns
    or view == writView and writColumns or columns
  if frame.columnLayout ~= layout then
    frame.columnLayout = layout
    layoutCells(frame.headerCells, layout)
    for _, row in ipairs(frame.rows) do
      layoutCells(row.cells, layout)
      row.completed = nil
    end
  end
  for index, column in ipairs(layout) do
    frame.headerCells[index]:SetText(column.title or "")
  end
  if view.rewardKey then
    frame.headerCells[2]:SetText(view.itemTitle)
    frame.headerCells[3]:SetText(view.inputTitle)
    frame.headerCells[5]:SetText(view.rewardTitle)
    frame.headerCells[#layout]:SetText(view.metric)
  end
  frame.quillDetails:SetShown(view == quillView)
  frame.note:SetText(view.note)
end

local function makeText(parent, template, x, y)
  local label = parent:CreateFontString(nil, "OVERLAY", template)
  label:SetPoint("TOPLEFT", x, y)
  label:SetJustifyH("LEFT")
  return label
end

local function makeCells(parent, template)
  local cells = {}
  for index = 1, math.max(#columns, #writColumns, #profitColumns, #quillColumns) do
    local cell = parent:CreateFontString(nil, "OVERLAY", template)
    cell:SetWordWrap(false)
    cells[index] = cell
  end
  return cells
end

local function calculate()
  panel.shoppingRequest = nil
  local view = panel.view
  local api = Auctionator and Auctionator.API and Auctionator.API.v1
  if api and not api.GetAuctionPriceByItemID then
    api = nil
  end

  local rowCount, pricedCount, missingEntry, missingBundle
  if view == quillView then
    local tiers, crate, quillCost = addon.CalculateQuill(api)
    rowCount = #tiers
    for rank, tier in ipairs(tiers) do
      setRow(panel.rows[rank], tier.entry, rank, tier)
    end
    local details = panel.quillDetails
    if crate then
      local estimate = crate.entry.estimatedFavor and " (estimated Favor)" or ""
      details.crate:SetText(("%s  |  %d x %s (%s)"):format(crate.entry.name,
        crate.bundle.quantity, itemName(crate.bundle.itemID), crate.bundle.source))
      details.cost:SetText(("%s filled  |  %d Favor%s  |  %s per Favor"):format(
        money(crate.total), crate.reward, estimate, money(crate.perReward)))
    else
      details.crate:SetText("No complete crate prices cached.")
      details.cost:SetText("")
    end
    details.quill:SetText(("Quill cost (%d Favor)  %s"):format(
      addon.QUILL_FAVOR_COST, quillCost and money(quillCost) or "Unpriced"))
  elseif view == profitView then
    local results
    results, pricedCount = addon.CalculateProfit(api)
    rowCount = #results
    for rank, result in ipairs(results) do
      setRow(panel.rows[rank], result.entry, rank, result)
    end
  else
    local results = {}
    if api then
      results, missingEntry, missingBundle = addon.Calculate(api, view.entries, view.rewardKey)
    end
    local priced = {}
    for rank, result in ipairs(results) do
      priced[result.entry] = true
      setRow(panel.rows[rank], result.entry, rank, result)
    end
    pricedCount = #results
    rowCount = pricedCount
    for _, entry in ipairs(view.entries) do
      if not priced[entry] then
        rowCount = rowCount + 1
        setRow(panel.rows[rowCount], entry)
      end
    end
  end
  for index = rowCount + 1, #panel.rows do
    setRow(panel.rows[index])
  end
  updateDailyResetTimer()

  panel.scrollBar:SetValue(0)
  panel.scroll:SetVerticalScroll(0)
  local contentHeight = math.max(LIST_HEIGHT, rowCount * ROW_HEIGHT)
  panel.scrollChild:SetHeight(contentHeight)
  panel.scroll:UpdateScrollChildRect()
  panel.scrollBar:SetMinMaxValues(0, contentHeight - LIST_HEIGHT)
  panel.scrollBar:SetShown(contentHeight > LIST_HEIGHT)

  if not api then
    panel.status:SetText("Enable Auctionator to read cached auction prices.")
  elseif view == quillView then
    panel.status:SetText(("Net EV is average resale after the %d%% AH cut, minus the input writ and Quill costs."):format(
      addon.AUCTION_CUT_PERCENT))
  elseif pricedCount == 0 then
    panel.status:SetText("No complete prices yet. Scan or search in Auctionator, then reopen this tab.")
  else
    local status = ("%d of %d %s priced."):format(pricedCount, rowCount, view.plural)
    if view == profitView then
      status = status .. " Hover over an item to see its materials."
    elseif missingEntry + missingBundle > 0 then
      status = status .. (" Missing prices for %d %s and %d %s."):format(missingEntry, view.plural, missingBundle, view.missingInput)
    end
    panel.status:SetText(status)
  end
end

local function makePanel(auctionFrame)
  local frame = CreateFrame("Frame", nil, auctionFrame, "BackdropTemplate")
  frame:SetSize(PANEL_WIDTH, 420)
  frame:SetPoint("TOP", auctionFrame, "TOP", 0, -44)
  frame:SetFrameLevel(auctionFrame:GetFrameLevel() + 2)
  frame:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    edgeSize = 24,
    insets = { left = 5, right = 5, top = 5, bottom = 5 },
  })
  frame:SetBackdropColor(0.055, 0.063, 0.078, 1)
  frame.viewTabs = {}
  for index, view in ipairs(views) do
    local tab = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    tab:SetSize(152, 24)
    tab:SetPoint("TOPLEFT", 20 + (index - 1) * 155, -17)
    tab:SetText(view.label)
    tab:SetScript("OnClick", function()
      selectView(frame, view)
      calculate()
    end)
    frame.viewTabs[index] = tab
  end
  makeText(frame, "GameFontHighlightSmall", 20, -47):SetText("Auctionator cached prices. Click a row to shop in Auctionator.")

  local header = CreateFrame("Frame", nil, frame)
  header:SetSize(LIST_WIDTH, 22)
  header:SetPoint("TOPLEFT", 14, -68)
  local background = header:CreateTexture(nil, "BACKGROUND")
  background:SetAllPoints()
  background:SetColorTexture(0.19, 0.16, 0.1, 0.85)
  frame.headerCells = makeCells(header, "GameFontNormalSmall")

  local scroll = CreateFrame("ScrollFrame", nil, frame)
  scroll:SetSize(LIST_WIDTH, LIST_HEIGHT)
  scroll:SetPoint("TOPLEFT", 14, -91)
  local scrollChild = CreateFrame("Frame", nil, scroll)
  scrollChild:SetSize(LIST_WIDTH, LIST_HEIGHT)
  scroll:SetScrollChild(scrollChild)
  frame.scroll, frame.scrollChild = scroll, scrollChild

  local scrollBar = CreateFrame("Slider", nil, frame)
  scrollBar:SetPoint("TOPLEFT", scroll, "TOPRIGHT", 5, 0)
  scrollBar:SetSize(12, LIST_HEIGHT)
  scrollBar:SetOrientation("VERTICAL")
  scrollBar:EnableMouse(true)
  scrollBar:SetMinMaxValues(0, 0)
  local track = scrollBar:CreateTexture(nil, "BACKGROUND")
  track:SetAllPoints()
  track:SetColorTexture(1, 1, 1, 0.08)
  local thumb = scrollBar:CreateTexture(nil, "ARTWORK")
  thumb:SetSize(12, 22)
  thumb:SetColorTexture(0.7, 0.58, 0.33)
  scrollBar:SetThumbTexture(thumb)
  scrollBar:SetScript("OnValueChanged", function(_, value)
    scroll:SetVerticalScroll(value)
  end)
  scroll:EnableMouseWheel(true)
  scroll:SetScript("OnMouseWheel", function(_, delta)
    scrollBar:SetValue(scrollBar:GetValue() - delta * ROW_HEIGHT * 3)
  end)
  frame.scrollBar = scrollBar

  frame.rows = {}
  local maxRows = math.max(#addon.crates, #addon.writs, addon.profitItemCount)
  for index = 1, maxRows do
    local row = CreateFrame("Button", nil, scrollChild)
    row:SetSize(LIST_WIDTH, ROW_HEIGHT)
    row:SetPoint("TOPLEFT", 0, -(index - 1) * ROW_HEIGHT)
    if index % 2 == 0 then
      local stripe = row:CreateTexture(nil, "BACKGROUND")
      stripe:SetAllPoints()
      stripe:SetColorTexture(1, 1, 1, 0.045)
    end
    local highlight = row:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetColorTexture(1, 0.82, 0.4, 0.10)
    row.cells = makeCells(row, "GameFontHighlightSmall")
    row:RegisterForClicks("LeftButtonUp")
    row:SetScript("OnClick", shopForRow)
    row:SetScript("OnEnter", showRowTooltip)
    row:SetScript("OnLeave", function(self)
      if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
    end)
    row:SetScript("OnHide", row:GetScript("OnLeave"))
    row:Hide()
    frame.rows[index] = row
  end

  frame.status = makeText(frame, "GameFontHighlightSmall", 20, -355)
  frame.status:SetSize(PANEL_WIDTH - 40, 26)
  frame.status:SetJustifyV("TOP")
  frame.note = makeText(frame, "GameFontHighlightSmall", 20, -387)
  frame.note:SetTextColor(0.67, 0.67, 0.67)

  local quillDetails = CreateFrame("Frame", nil, frame)
  quillDetails:SetPoint("TOPLEFT", 20, -185)
  quillDetails:SetSize(PANEL_WIDTH - 40, 90)
  makeText(quillDetails, "GameFontNormal", 0, 0):SetText("Cheapest crate per Favor")
  quillDetails.crate = makeText(quillDetails, "GameFontHighlight", 0, -21)
  quillDetails.cost = makeText(quillDetails, "GameFontHighlightSmall", 0, -41)
  quillDetails.quill = makeText(quillDetails, "GameFontHighlight", 0, -65)
  frame.quillDetails = quillDetails

  selectView(frame, views[1])
  frame:Hide()
  frame:SetScript("OnShow", calculate)
  frame:SetScript("OnHide", function(self)
    self.shoppingRequest = nil
    updateDailyResetTimer()
  end)
  return frame
end

local function attachToAuctionHouse()
  if panel or not AuctionHouseFrame or not AuctionHouseFrame:IsShown() then
    return
  end
  panel = makePanel(AuctionHouseFrame)
  LibStub("LibAHTab-1-0"):CreateTab(TAB_ID, panel, TITLE)
end

local events = CreateFrame("Frame")
events:RegisterEvent("AUCTION_HOUSE_SHOW")
events:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
events:RegisterEvent("QUEST_LOG_UPDATE")
events:RegisterEvent("QUEST_TURNED_IN")
events:SetScript("OnEvent", function(_, event, interaction)
  if event == "QUEST_LOG_UPDATE" then
    refreshWritCompletion()
  elseif event == "QUEST_TURNED_IN" then
    C_Timer.After(0, refreshWritCompletion)
  elseif event == "AUCTION_HOUSE_SHOW" or interaction == Enum.PlayerInteractionType.Auctioneer then
    -- The Blizzard auction frame is loaded on demand when the auctioneer opens.
    C_Timer.After(0, attachToAuctionHouse)
  end
end)

-- Also handle loading the addon while the Auction House is already open.
C_Timer.After(0, attachToAuctionHouse)
