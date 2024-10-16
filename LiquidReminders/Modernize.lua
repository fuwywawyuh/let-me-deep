local _, LRP = ...

local version = 3

function LRP:Modernize()
    local internalVersion = LiquidRemindersSaved.internalVersion

    -- We started manually handling anchor movement to allow them to be snapped to the cernter of the screen
    -- The implementation is easier if the point used is always "CENTER", however some anchors still used others
    -- If they are, reset their positioning
    if not internalVersion then
        local anchorNames = {"SpellReminderAnchor", "TextReminderAnchor"}

        for _, anchorName in ipairs(anchorNames) do
            local anchorPointInfo = LiquidRemindersSaved.settings.frames[anchorName] and LiquidRemindersSaved.settings.frames[anchorName].points or {}

            if anchorPointInfo[2] or anchorPointInfo[1] and anchorPointInfo[1].point ~= "CENTER" then
                LiquidRemindersSaved.settings.frames[anchorName].points = {}
            end
        end

        internalVersion = 1
    end

    -- Reminders could be set for 0 (or negative number of) seconds relative to a phase, or even pull
    -- These reminders can never show up, and in case of being relative to pull, they would not even be displayed on the timeline
    -- It's no longer possible to set them like this since the time edit boxes now have a minimum value
    if internalVersion < 2 then
        for _, encounterReminders in pairs(LiquidRemindersSaved.reminders) do
            for _, reminderData in pairs(encounterReminders) do
                if reminderData.trigger.time < 1 then
                    reminderData.trigger.time = 1
                end
            end
        end
    end

    -- Phase 3 on Ansurek was relative to the Dreadful Presence application
    -- This was however not consistent, so it was later changed to "Land" (450040) unit event
    if internalVersion < 3 then
        local reminders = LiquidRemindersSaved.reminders[2922]

        if not reminders then return end -- User has no Ansurek reminders

        for id, reminderData in pairs(reminders) do
            local relativeTo = reminderData.trigger.relativeTo

            if relativeTo and relativeTo.event == "SPELL_AURA_APPLIED" and relativeTo.spellID == 445268 and relativeTo.count == 1 then
                relativeTo.event = "UNIT_SPELLCAST_SUCCEEDED"
                relativeTo.spellID = 450040
                relativeTo.count = 1
                
                reminderData.trigger.time = reminderData.trigger.time + 3.3
            end
        end
    end

    LiquidRemindersSaved.internalVersion = version
end

