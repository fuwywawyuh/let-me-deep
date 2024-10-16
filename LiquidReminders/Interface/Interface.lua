local _, LRP = ...

-- Tooltip
CreateFrame("GameTooltip", "LRTooltip", UIParent, "GameTooltipTemplate")

LRP.Tooltip = _G["LRTooltip"]
LRP.Tooltip.TextLeft1:SetFont(LRP.gs.visual.font, 13)

-- Main window
local windowWidth = 1200
local windowHeight = 800 -- Only used for initial positioning as a base value. Height is set depending on timeline data.

local windowMinWidth = 800

function LRP:InitializeInterface()
    local screenWidth, screenHeight = GetPhysicalScreenSize()

    LRP.window = LRP:CreateWindow("Main", true, true, true)
    LRP.window:SetFrameStrata("HIGH")
    LRP.window:SetResizeBounds(windowMinWidth, 0) -- Height is set based on timeine data
    LRP.window:Hide()

    LRP.window:SetScript("OnHide", function() LRP:StopSimulation() end)

    -- If there's no saved position/size settings for the main window yet, apply some default values
    local windowSettings = LiquidRemindersSaved.settings.frames["Main"]

    if not windowSettings or not windowSettings.points then
        LRP.window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", (screenWidth - windowWidth) / 2, -(screenHeight - windowHeight) / 2)
    end

    if not windowSettings or not windowSettings.width then
        LRP.window:SetWidth(windowWidth)
    end
    
    -- Settings button
    LRP.window:AddButton(
        "Interface\\Addons\\LiquidReminders\\Media\\Textures\\Cogwheel.tga",
        function()
            LRP.anchors.TEXT:SetShown(not LRP.anchors.TEXT:IsShown())
            LRP.anchors.SPELL:SetShown(not LRP.anchors.SPELL:IsShown())
        end
    )

    -- Timeline
    LRP:InitializeTimeline()
    
    local timeline = LRP.timeline

    timeline:SetParent(LRP.window)
    timeline:SetPoint("LEFT", LRP.window, "LEFT", 16, 0)
    timeline:SetPoint("RIGHT", LRP.window, "RIGHT", -16, 0)

    -- Reminder config
    LRP:InitializeConfig()

    LRP.reminderConfig:SetParent(LRP.window)
    LRP.reminderConfig:SetFrameStrata("DIALOG")
    LRP.reminderConfig:Hide()
end