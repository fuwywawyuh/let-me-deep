---@diagnostic disable: undefined-field
local _, LRP = ...

local LGF = LibStub("LibGetFrame-1.0")

LGF:ScanForUnitFrames()

-- A random spell ID is chosen from these tables for test reminders
local testSpellIDs = {
    51052, -- Anti-Magic Zone
    115310, -- Revival
    157982, -- Tranquility
    196718, -- Darkness
    97462, -- Rallying Cry
    374227, -- Zephyr
    15286, -- Vampiric Embrace
    265202, -- Holy Word: Salvation
    64843, -- Divine Hymn
    271466, -- Luminous Barrier
    62618, -- Power Word: Barrier
    6262, -- Healthstone
    192077, -- Wind Rush Totem
    98008, -- Spirit Link Totem
    108280, -- Healing Tide Totem
    77761, -- Stampeding Roar
    406732, -- Spatial Paradox
}

local testTexts = {
    "Go down",
    "Pick up seed",
    "Go far",
    "Pre-position for ability",
    "Go to the edge",
    "Place gateway",
    "Watch out for beams",
    "Stand on aug evokers",
    "Go to {rt1}",
    "Go to {rt2}",
    "Go to {rt3}",
    "Healthstone + tonic",
    "DPS potion",
    "Go to platform",
    "Soak puddles",
    "Drop seed if Firestorm",
    "Sac Fiery Growth #3",
    "Hit red colossus",
    "Life grip ghost",
    "Bubble taunt",
    "Hard overlap"
}

function LRP:CreateReminderAnchor(anchorType)
    local anchorName = anchorType == "TEXT" and "TextReminderAnchor" or "SpellReminderAnchor"

    local activeGlows = {}
    local queuedTTS = {}
    local inactiveReminders = {}
    local activeReminders = {}
    local hideOnUseReminders = {} -- Spell reminders that should be hidden on use. Key is a spell ID, value is a table of reminder IDs.
    local PositionButtons = function() end

    local reminderAnchor = CreateFrame("Frame", nil, LRP.window)

    reminderAnchor:SetFrameStrata(LRP.window:GetFrameStrata())
    reminderAnchor:SetFrameLevel(LRP.window:GetFrameLevel() + 100)
    reminderAnchor:SetSize(400, 24)
    reminderAnchor:SetPoint("CENTER", UIParent, "CENTER")
    reminderAnchor:SetAlpha(0.7)
    reminderAnchor:SetMovable(true)
    reminderAnchor:EnableMouse(true)
    reminderAnchor:Hide()

    reminderAnchor.tex = reminderAnchor:CreateTexture(nil, "OVERLAY")
    reminderAnchor.tex:SetAllPoints(reminderAnchor)
    reminderAnchor.tex:SetColorTexture(0, 0.5, 0)

    reminderAnchor.text = reminderAnchor:CreateFontString(nil, "OVERLAY")
    reminderAnchor.text:SetFont(LRP.gs.visual.font, 16, LRP.gs.visual.fontFlags)
    reminderAnchor.text:SetPoint("CENTER", reminderAnchor, "CENTER", 0, -1)
    reminderAnchor.text:SetText(anchorType == "TEXT" and "Text reminder anchor" or "Spell reminder anchor")
    reminderAnchor.text:SetIgnoreParentAlpha(true)

    local function ShowGlow(id, reminderData)
        if not reminderData.glow then return end
        if not reminderData.glow.enabled then return end

        local glowType = reminderData.glow.type

        local glowInfo = {
            type = glowType,
            frames = {}
        }

        for _, name in ipairs(reminderData.glow.names) do
            local unit = UnitExists(name) and name

            -- If no group member with this name is present, see if it's a valid nickname
            if not unit and LiquidAPI then
                unit = LiquidAPI:GetCharacterInGroup(name)
            end

            if unit then
                local unitFrame = LGF.GetUnitFrame(unit)

                if unitFrame then
                    LRP:StartGlow(unitFrame, id, glowType, reminderData.glow.color)

                    table.insert(glowInfo.frames, unitFrame)
                end
            end
        end

        activeGlows[id] = glowInfo
    end

    local function HideGlow(id)
        local glowInfo = activeGlows[id]

        if glowInfo then
            local glowType = glowInfo.type

            for _, frame in ipairs(glowInfo.frames) do
                LRP:StopGlow(frame, id, glowType)
            end
        end

        activeGlows[id] = nil
    end

    local function QueueTTS(id, reminderData, simulationOffset)
        if not reminderData.tts.enabled then return end

        local triggerTime = reminderData.trigger.time - simulationOffset -- Time after pull (or some event) that the reminder should finish showing
        local duration = math.min(triggerTime, reminderData.trigger.duration) -- Total duration that the reminder shows for
        local ttsTime = reminderData.tts.time -- Number of seconds remaining on the reminder when the TTS should play
        local queueTime = math.max(0, duration - ttsTime)
        local text

        if reminderData.display.type == "SPELL" then
            local spellInfo = C_Spell.GetSpellInfo(reminderData.display.spellID)

            text = spellInfo.name
        else
            text = LRP:FormatForTTS(reminderData.display.text)
        end

        queuedTTS[id] = C_Timer.NewTimer(
            queueTime,
            function()
                C_VoiceChat.SpeakText(
                    reminderData.tts.voice,
                    text,
                    Enum.VoiceTtsDestination.LocalPlayback,
                    C_TTSSettings and C_TTSSettings.GetSpeechRate() or 0,
                    C_TTSSettings and C_TTSSettings.GetSpeechVolume() or 100
                )

                queuedTTS[id] = nil
            end
        )
    end

    local function DequeueTTS(id)
        if queuedTTS[id] then
            queuedTTS[id]:Cancel()

            queuedTTS[id] = nil
        end
    end

    local function PositionReminders()
        local growDirection = LiquidRemindersSaved.settings.reminderTypes[anchorType].grow == "UP" and 1 or -1
        local reminders = activeReminders
        local orderedReminders = {}
    
        for id in pairs(reminders) do
            table.insert(orderedReminders, id)
        end
    
        table.sort(
            orderedReminders,
            function(idA, idB)
                local reminderA = reminders[idA]
                local reminderB = reminders[idB]
    
                local expirationTimeA = reminderA:GetExpirationTime()
                local expirationTimeB = reminderB:GetExpirationTime()
    
                if expirationTimeA ~= expirationTimeB then
                    return expirationTimeA < expirationTimeB
                else
                    return idA < idB
                end
            end
        )
    
        local size = LiquidRemindersSaved.settings.reminderTypes[anchorType].size
        local alignment = LiquidRemindersSaved.settings.reminderTypes[anchorType].alignment

        local point, relativePoint

        if growDirection == 1 then -- Grow up
            point = alignment == "LEFT" and "BOTTOMLEFT" or alignment == "RIGHT" and "BOTTOMRIGHT" or "BOTTOM"
            relativePoint = alignment == "LEFT" and "TOPLEFT" or alignment == "RIGHT" and "TOPRIGHT" or "TOP"
        else -- Grow down
            point = alignment == "LEFT" and "TOPLEFT" or alignment == "RIGHT" and "TOPRIGHT" or "TOP"
            relativePoint = alignment == "LEFT" and "BOTTOMLEFT" or alignment == "RIGHT" and "BOTTOMRIGHT" or "BOTTOM"
        end

        local spacing = 1
    
        for i, id in ipairs(orderedReminders) do
            local reminder = reminders[id]
    
            reminder:ClearAllPoints()
            reminder:SetPoint(point, reminderAnchor, relativePoint, 0, growDirection * ((i - 1) * size + i * spacing))
    
            reminder:UpdateSize()
            reminder:UpdateAlignment()
        end
    end

    function reminderAnchor:HideReminder(id, dequeueTTS, dontPosition)
        local reminder = activeReminders[id]

        if not reminder then return end

        reminder:Hide()
        
        table.insert(inactiveReminders, reminder)
        activeReminders[id] = nil

        HideGlow(id)

        -- If TTS should be dequeued (typically when reminders are hidden as a result of the encounter being over), do so
        -- When a reminder is hidden because it ran out, the TTS is not dequeued as it cleans itself up when it runs
        if dequeueTTS then
            DequeueTTS(id)
        end

        -- If this reminder had hideOnUse set, remove its entry from the hideOnUse table
        for _, reminderIDs in pairs(hideOnUseReminders) do
            reminderIDs[id] = nil
        end

        -- If this flag is set, don't do any positioning
        -- This is only used in HideAllReminders, since positioning after hiding each reminder is superfluous
        if not dontPosition then
            PositionReminders()
        end
    end

    function reminderAnchor:HideAllReminders()
        for id in pairs(activeReminders) do
            reminderAnchor:HideReminder(id, true, true)
        end

        hideOnUseReminders = {}

        PositionReminders()
    end
    
    local function AcquireReminder()
        local pool = inactiveReminders
    
        if #pool > 0 then
            local reminder = pool[#pool]
    
            pool[#pool] = nil
    
            return reminder
        end
    
        return anchorType == "TEXT" and LRP:CreateTextReminder(reminderAnchor.HideReminder) or LRP:CreateSpellReminder(reminderAnchor.HideReminder)
    end
    
    function reminderAnchor:ShowReminder(id, reminderData, simulationOffset)
        local reminderType = reminderData.display.type

        -- Don't display empty text reminders
        if reminderType == "TEXT" and reminderData.display.text == "" then
            return
        end

        -- If this is the spell reminder anchor, and the setting to show them as text is turned on, show the reminder on the text anchor instead
        if anchorType == "SPELL" and LiquidRemindersSaved.settings.reminderTypes.SPELL.showAsText then
            LRP.anchors.TEXT:ShowReminder(id, reminderData, simulationOffset)

            return
        end

        if activeReminders[id] then return end -- Reminder is already active, don't show it again

        -- Acquire new reminder and initialize it
        local reminder = AcquireReminder()
        activeReminders[id] = reminder
        reminder:Initialize(id, reminderData, simulationOffset)

        -- If this is a spell reminder with "hide on use" set, track it
        if reminderType == "SPELL" and reminderData.trigger.hideOnUse then
            local spellID = reminderData.display.spellID

            if not hideOnUseReminders[spellID] then
                hideOnUseReminders[spellID] = {}
            end

            hideOnUseReminders[spellID][id] = true
        end

        ShowGlow(id, reminderData)
        QueueTTS(id, reminderData, simulationOffset)

        PositionReminders()
    end

    -- Called when the player casts a spell
    -- Checks against hideOnUseReminders, and hides corresponding ones
    local function OnPlayerSpellCast(spellID)
        local reminders = hideOnUseReminders[spellID]
        local shouldPosition = false

        if reminders then
            for id in pairs(reminders) do
                reminderAnchor:HideReminder(id, true, true)

                shouldPosition = true
            end

            if shouldPosition then
                PositionReminders()
            end
        end
    end

    -- Frame drag move
    local isMoving = false
    local uiScale, startOffsets, startCursorX, startCursorY

    reminderAnchor:SetScript(
        "OnMouseDown",
        function(_, button)
            if button == "LeftButton" then
                isMoving = true

                uiScale = UIParent:GetEffectiveScale()

                startCursorX, startCursorY = GetCursorPosition()
                startCursorX = startCursorX / uiScale
                startCursorY = startCursorY / uiScale

                local _, _, _, offsetX, offsetY = reminderAnchor:GetPoint(1)

                startOffsets = {
                    x = offsetX,
                    y = offsetY
                }
            end
        end
    )

    reminderAnchor:SetScript(
        "OnMouseUp",
        function()
            isMoving = false

            LRP:SavePosition(reminderAnchor, anchorName)
        end
    )

    reminderAnchor:SetScript(
        "OnUpdate",
        function()
            if isMoving then
                local cursorX, cursorY = GetCursorPosition()

                cursorX = cursorX / uiScale
                cursorY = cursorY / uiScale

                local distanceX = cursorX - startCursorX
                local distanceY = cursorY - startCursorY

                local newOffsetX = startOffsets.x + distanceX
                local newOffsetY = startOffsets.y + distanceY

                -- Snap to center horizontally
                if math.abs(newOffsetX) < 12 then
                    newOffsetX = 0
                end

                reminderAnchor:SetPoint("CENTER", UIParent, "CENTER", newOffsetX, newOffsetY)
            end
        end
    )

    -- Script handlers
    reminderAnchor:SetScript(
        "OnEnter",
        function()
            reminderAnchor:SetAlpha(1)
        end
    )
    
    reminderAnchor:SetScript(
        "OnLeave",
        function()
            reminderAnchor:SetAlpha(0.7)
        end
    )

    reminderAnchor:SetScript(
        "OnHide",
        function()
            reminderAnchor:HideAllReminders()
        end
    )

    -- Left align button
    local leftAlignButton = LRP:CreateButton(
        reminderAnchor,
        "Align left",
        function()
            LiquidRemindersSaved.settings.reminderTypes[anchorType].alignment = "LEFT"

            PositionReminders()
        end
    )

    leftAlignButton:SetIgnoreParentAlpha(true)

    -- Right align button
    local rightAlignButton = LRP:CreateButton(
        reminderAnchor,
        "Align right",
        function()
            LiquidRemindersSaved.settings.reminderTypes[anchorType].alignment = "RIGHT"

            PositionReminders()
        end
    )

    rightAlignButton:SetIgnoreParentAlpha(true)

    -- Center align button (only for text reminder anchor)
    local centerAlignButton

    if anchorType == "TEXT" then
        centerAlignButton = LRP:CreateButton(
            reminderAnchor,
            "Align center",
            function()
                LiquidRemindersSaved.settings.reminderTypes[anchorType].alignment = "CENTER"

                PositionReminders()
            end
        )

        centerAlignButton:SetIgnoreParentAlpha(true)
    end

    -- Decrease font size button
    local decreaseFontSizeButton = LRP:CreateButton(
        reminderAnchor,
        "-",
        function()
            local currentSize = LiquidRemindersSaved.settings.reminderTypes[anchorType].size
            local newSize = math.max(math.min(currentSize - 2, 100), 20) -- Keep font size between 20 and 100

            LiquidRemindersSaved.settings.reminderTypes[anchorType].size = newSize

            PositionReminders()
        end
    )

    decreaseFontSizeButton:SetPoint("LEFT", reminderAnchor, "RIGHT", 2, 0)
    decreaseFontSizeButton:SetIgnoreParentAlpha(true)

    -- Increase font size button
    local increaseFontSizeButton = LRP:CreateButton(
        reminderAnchor,
        "+",
        function()
            local currentSize = LiquidRemindersSaved.settings.reminderTypes[anchorType].size
            local newSize = math.max(math.min(currentSize + 2, 100), 20) -- Keep font size between 20 and 100

            LiquidRemindersSaved.settings.reminderTypes[anchorType].size = newSize

            PositionReminders()
        end
    )

    increaseFontSizeButton:SetPoint("LEFT", decreaseFontSizeButton, "RIGHT", 2, 0)
    increaseFontSizeButton:SetIgnoreParentAlpha(true)

    -- Grow direction button
    local growDirectionButton = LRP:CreateButton(
        reminderAnchor,
        LiquidRemindersSaved.settings.reminderTypes[anchorType].grow == "UP" and "Grow down" or "Grow up",
        function(button)
            local currentGrowDirection = LiquidRemindersSaved.settings.reminderTypes[anchorType].grow
            local newGrowDirection = currentGrowDirection == "UP" and "DOWN" or "UP"

            LiquidRemindersSaved.settings.reminderTypes[anchorType].grow = newGrowDirection

            button:SetText(newGrowDirection == "UP" and "Grow down" or "Grow up")

            PositionButtons()
            PositionReminders()
        end
    )

    growDirectionButton:SetPoint("LEFT", increaseFontSizeButton, "RIGHT", 2, 0)
    growDirectionButton:SetIgnoreParentAlpha(true)

    -- Show spell reminders as text reminders button
    local showAsTextCheckButton

    if anchorType == "SPELL" then
        showAsTextCheckButton = LRP:CreateCheckButton(
            reminderAnchor,
            "Show as text reminders",
            function(checked)
                LiquidRemindersSaved.settings.reminderTypes.SPELL.showAsText = checked

                if checked then
                    reminderAnchor:HideAllReminders()

                    reminderAnchor.tex:SetColorTexture(0.3, 0.3, 0.3)
                    reminderAnchor.text:SetText("|cffaaaaaaSpell reminder anchor (disabled)|r")
                else
                    reminderAnchor.tex:SetColorTexture(0, 0.5, 0)
                    reminderAnchor.text:SetText("Spell reminder anchor")
                end
            end
        )

        showAsTextCheckButton:SetSize(20, 20)
        showAsTextCheckButton:SetIgnoreParentAlpha(true)
        showAsTextCheckButton.title:SetTextHeight(15)
        showAsTextCheckButton:SetChecked(LiquidRemindersSaved.settings.reminderTypes.SPELL.showAsText)

        LRP:AddTooltip(
            showAsTextCheckButton,
            "When checked, spell reminders show up as text on the text reminder anchor."
        )
    end

    -- Show icons only check button
    local showIconsOnlyCheckButton

    if anchorType == "SPELL" then
        showIconsOnlyCheckButton = LRP:CreateCheckButton(
            reminderAnchor,
            "Show icons only",
            function(checked)
                LiquidRemindersSaved.settings.reminderTypes.SPELL.showIconsOnly = checked

                for _, reminder in pairs(activeReminders) do
                    reminder:UpdateTextVisibility()
                end
            end
        )

        showIconsOnlyCheckButton:SetSize(20, 20)
        showIconsOnlyCheckButton:SetIgnoreParentAlpha(true)
        showIconsOnlyCheckButton.title:SetTextHeight(15)
        showIconsOnlyCheckButton:SetChecked(LiquidRemindersSaved.settings.reminderTypes.SPELL.showIconsOnly)

        LRP:AddTooltip(
            showIconsOnlyCheckButton,
            "When checked, spell names are hidden."
        )
    end

    -- Test button
    local testButton = LRP:CreateButton(
        reminderAnchor,
        "Test",
        function()
            local defaultReminder = LiquidRemindersSaved.settings.defaultReminder

            local randomSpellID = testSpellIDs[math.random(#testSpellIDs)]
            local randomText = testTexts[math.random(#testTexts)]

            local randomReminder = {
                trigger = {
                    duration = defaultReminder and defaultReminder.trigger.duration or 10,
                    time = defaultReminder and defaultReminder.trigger.duration or 10,
                    hideOnUse = false
                },
                display = {
                    type = anchorType,
                    text = randomText,
                    spellID = randomSpellID,
                    color = defaultReminder and defaultReminder.display.color or {
                        r = 1,
                        g = 1,
                        b = 1
                    }
                },
                tts = {
                    enabled = false
                },
                glow = {
                    enabled = false
                }
            }

            -- Chance to show a randomly colored reminder
            if math.random(4) == 1 then
                randomReminder.display.color = {
                    r = math.random(0, 255) / 255,
                    g = math.random(0, 255) / 255,
                    b = math.random(0, 255) / 255
                }
            end
        
            reminderAnchor:ShowReminder(LRP:GenerateUniqueID(), randomReminder, 0)
        end
    )

    testButton:SetPoint("RIGHT", reminderAnchor, "LEFT", -2, 0)
    testButton:SetIgnoreParentAlpha(true)

    PositionButtons = function()
        local growDirection = LiquidRemindersSaved.settings.reminderTypes[anchorType].grow
        
        leftAlignButton:ClearAllPoints()
        rightAlignButton:ClearAllPoints()

        if anchorType == "TEXT" then
            centerAlignButton:ClearAllPoints()
        end

        if anchorType == "SPELL" then
            showAsTextCheckButton:ClearAllPoints()
            showIconsOnlyCheckButton:ClearAllPoints()
        end
        
        if growDirection == "UP" then
            leftAlignButton:SetPoint("TOPLEFT", reminderAnchor, "BOTTOMLEFT", 0, -2)
            rightAlignButton:SetPoint("TOPRIGHT", reminderAnchor, "BOTTOMRIGHT", 0, -2)

            if anchorType == "TEXT" then
                centerAlignButton:SetPoint("TOP", reminderAnchor, "BOTTOM", 0, -2)
            end

            if anchorType == "SPELL" then
                showAsTextCheckButton:SetPoint("TOP", reminderAnchor, "BOTTOM", -0.5 * showAsTextCheckButton.title:GetStringWidth() - 8, -4)
                showIconsOnlyCheckButton:SetPoint("TOP", showAsTextCheckButton, "BOTTOM", 0, -4)
            end
        else
            leftAlignButton:SetPoint("BOTTOMLEFT", reminderAnchor, "TOPLEFT", 0, 2)
            rightAlignButton:SetPoint("BOTTOMRIGHT", reminderAnchor, "TOPRIGHT", 0, 2)

            if anchorType == "TEXT" then
                centerAlignButton:SetPoint("BOTTOM", reminderAnchor, "TOP", 0, 2)
            end

            if anchorType == "SPELL" then
                showAsTextCheckButton:SetPoint("BOTTOM", reminderAnchor, "TOP", -0.5 * showAsTextCheckButton.title:GetStringWidth() - 8, 4)
                showIconsOnlyCheckButton:SetPoint("BOTTOM", showAsTextCheckButton, "TOP", 0, 4)
            end
        end
    end

    -- Listen for player spell casts to hide reminders that have hideOnUse set
    local hideOnUseFrame = CreateFrame("Frame")

    hideOnUseFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

    hideOnUseFrame:SetScript(
        "OnEvent",
        function(_, _, unit, _, spellID)
            if unit == "player" then
                OnPlayerSpellCast(spellID)
            end
        end
    )

    C_Timer.After(
        0,
        function()
            -- Somehow if these two functions are not called prior to GetStringWidth(), GetStringWidth() returns 0
            -- No idea why this is the case, and this is what worked after a bunch of trial and error
            -- If someone reads this and knows why this happens, please let me know
            if anchorType == "SPELL" then
                showAsTextCheckButton:SetPoint("TOP")
                showAsTextCheckButton.title:GetWidth()

                showIconsOnlyCheckButton:SetPoint("TOP")
                showIconsOnlyCheckButton.title:GetWidth()
            end

            PositionButtons()
        end
    )

    -- Restore position
    -- Force using CENTER point only, since it makes snapping to center of screen a little easier
    LRP:RestorePosition(reminderAnchor, anchorName)

    return reminderAnchor
end