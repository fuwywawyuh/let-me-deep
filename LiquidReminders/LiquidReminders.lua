local _, LRP = ...

AddonCompartmentFrame:RegisterAddon({
    text = "Liquid Reminders",
    icon = "Interface\\AddOns\\LiquidReminders\\Media\\Textures\\logo_secondary.blp",
    registerForAnyClick = true,
    notCheckable = true,
    func = function()
        LRP.window:SetShown(not LRP.window:IsShown())
    end,
})

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

eventFrame:SetScript(
    "OnEvent",
    function(_, event, ...)
        if event == "ADDON_LOADED" then
            local addOnName = ...

            if addOnName == "LiquidReminders" then
                if not LiquidRemindersSaved then LiquidRemindersSaved = {} end
                if not LiquidRemindersSaved.reminders then LiquidRemindersSaved.reminders = {} end
                if not LiquidRemindersSaved.spellBookData then LiquidRemindersSaved.spellBookData = {} end
                if not LiquidRemindersSaved.deathData then LiquidRemindersSaved.deathData = {} end
                if not LiquidRemindersSaved.settings then
                    LiquidRemindersSaved.settings = {
                        frames = {}, -- Size and positioning of frames
                        timeline = {
                            selectedInstance = 1,
                            selectedEncounter = 1,
                            showRelevantRemindersOnly = false,
                            showNoteReminders = true,
                            showDeathLine = true,
                            trackVisibility = {}
                        },
                        reminderTypes = {
                            TEXT = {
                                alignment = "CENTER",
                                size = 40,
                                font = LRP.gs.visual.font,
                                grow = "UP"
                            },
                            SPELL = {
                                alignment = "LEFT",
                                size = 60,
                                font = LRP.gs.visual.font,
                                grow = "UP",
                                showAsText = false
                            }
                        }
                    }
                end

                LRP:Modernize()
                LRP:InitializeTextFormatter()
                LRP:InitializeConfirmWindow()
                LRP:InitializeTimelineData()
                LRP:InitializeNoteInterpreter()
                LRP:InitializeInterface()
                LRP:InitializeDisplay()
            end
        elseif event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_SPECIALIZATION_CHANGED" then
            -- Specialization info is not available on ADDON_LOADED, so role/spec-based reminders don't show when "showRelevantRemindersOnly" is enabled.
            -- As a band-aid fix, rebuild the reminder lines on PLAYER_ENTERING_WORLD (as well as on PLAYER_SPECIALIZATION_CHANGED).

            LRP:BuildReminderLines()
        end
    end
)

SLASH_LIQUIDREMINDERS1, SLASH_LIQUIDREMINDERS2, SLASH_LIQUIDREMINDERS3 = "/lr", "/liquidreminder", "/liquidreminders"
function SlashCmdList.LIQUIDREMINDERS()
    LRP.window:SetShown(not LRP.window:IsShown())
end