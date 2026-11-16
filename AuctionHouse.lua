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

local views = {
  {
    label = "Waylaid Crates", entries = addon.crates, rewardKey = "favor",
    itemTitle = "Waylaid Crate", inputTitle = "Cheapest bundle", rewardTitle = "Favor",
    metric = "Cost / Favor", detail = "Cost per Merchant's Favor",
    priceLabel = "Empty crate (AH)", prefix = "Waylaid Crate: ", plural = "crates", missingInput = "fills",
    note = "* Artisan Favor is estimated. Craft costs assume access to the recipe.",
  },
  {
    label = "Craftsman's Writs", entries = addon.writs, rewardKey = "reputation",
    itemTitle = "Craftsman's Writ", inputTitle = "Required turn-in", rewardTitle = "Rep",
    metric = "Cost / Rep", detail = "Cost per reputation point",
    priceLabel = "Writ (AH)", prefix = "Craftsman's Writ: ", plural = "writs", missingInput = "turn-ins",
    note = "Reputation shown is the base quest reward. Craft costs assume access to the recipe.",
  },
  profitView,
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

local profitColumns = {
  { title = "#", x = 7, width = 23 },
  { title = "Crafted item", x = 33, width = 219 },
  { title = "Yield", x = 256, width = 39, align = "RIGHT" },
  { title = "Materials", x = 302, width = 84, align = "RIGHT" },
  { title = "AH sale", x = 393, width = 90, align = "RIGHT" },
  { title = "Raw profit", x = 490, width = 92, align = "RIGHT" },
  { title = ("After %d%% AH cut"):format(addon.AUCTION_CUT_PERCENT), x = 589, width = 96, align = "RIGHT" },
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
  if view == profitView then
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
      GameTooltip:AddLine("Turn-in location unavailable in QuestieDB.", 1, 0.74, 0.35)
    end
    GameTooltip:AddLine(" ")
  end
  if not result then
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
  GameTooltip:AddDoubleLine("Total", money(result.total))
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
  local questID = row.entry and row.entry.questID
  local checkCompletion = C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted or IsQuestFlaggedCompleted
  local completed = questID and checkCompletion and checkCompletion(questID) == true or false
  if row.completed == completed then
    return
  end
  row.completed = completed

  for index, cell in ipairs(row.cells) do
    if completed then
      cell:SetTextColor(0.55, 0.55, 0.55)
    elseif index == 7 then
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
  if panel and panel:IsVisible() and panel.view.entries == addon.writs then
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
  if not panel:IsVisible() or panel.view.entries ~= addon.writs then
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
  if not entry then
    row:Hide()
    return
  end
  local view = panel.view
  local values
  if view == profitView then
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
        bundle.source, reward, money(result.total), money(result.perReward),
      }
    else
      local bundle = entry.bundles[1]
      local input = #entry.bundles == 1 and ("%d x %s"):format(bundle[2], itemName(bundle[1])) or "See fill options"
      values = { "", entry.name, input, "", reward, "Unpriced", "" }
    end
  end
  for index, value in ipairs(values) do
    row.cells[index]:SetText(value)
  end
  updateCompletion(row)
  if view == profitView then
    setProfitColor(row.cells[6], result.rawProfit)
    setProfitColor(row.cells[7], result.netProfit)
    row.completed = nil
  end
  row:Show()
end

local function layoutCells(cells, layout)
  for index, column in ipairs(layout) do
    local cell = cells[index]
    cell:ClearAllPoints()
    cell:SetPoint("LEFT", column.x, 0)
    cell:SetWidth(column.width)
    cell:SetJustifyH(column.align or "LEFT")
  end
end

local function selectView(frame, view)
  frame.view = view
  for index, tab in ipairs(frame.viewTabs) do
    tab:SetEnabled(views[index] ~= view)
  end
  local layout = view == profitView and profitColumns or columns
  if frame.columnLayout ~= layout then
    frame.columnLayout = layout
    layoutCells(frame.headerCells, layout)
    for _, row in ipairs(frame.rows) do
      layoutCells(row.cells, layout)
    end
  end
  for index, column in ipairs(layout) do
    frame.headerCells[index]:SetText(column.title or "")
  end
  if view ~= profitView then
    frame.headerCells[2]:SetText(view.itemTitle)
    frame.headerCells[3]:SetText(view.inputTitle)
    frame.headerCells[5]:SetText(view.rewardTitle)
    frame.headerCells[7]:SetText(view.metric)
  end
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
  for index = 1, #columns do
    local cell = parent:CreateFontString(nil, "OVERLAY", template)
    cell:SetWordWrap(false)
    cells[index] = cell
  end
  return cells
end

local function calculate()
  local view = panel.view
  local api = Auctionator and Auctionator.API and Auctionator.API.v1
  if api and not api.GetAuctionPriceByItemID then
    api = nil
  end

  local rowCount, pricedCount, missingEntry, missingBundle
  if view == profitView then
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
  makeText(frame, "GameFontHighlightSmall", 20, -47):SetText("Auctionator cached prices")

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
  selectView(frame, views[1])
  frame:Hide()
  frame:SetScript("OnShow", calculate)
  frame:SetScript("OnHide", updateDailyResetTimer)
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
