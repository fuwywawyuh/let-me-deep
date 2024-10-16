local _, LRP = ...

function LRP:CreateCheckButton(parent, title, OnValueChanged, labelLeft)
    local checkButton = CreateFrame("Button", nil, parent)

    checkButton.OnEnter = function() end
    checkButton.OnLeave = function() end

    checkButton:SetScript("OnEnter", function(_self) _self.OnEnter() end)
    checkButton:SetScript("OnLeave", function(_self) _self.OnLeave() end)

    local isChecked = false

    checkButton:SetSize(20, 20)
    checkButton:SetHighlightAtlas("QuestSharing-QuestLog-ButtonHighlight", "ADD")

    checkButton.OnValueChanged = OnValueChanged

    -- Background
    checkButton.tex = checkButton:CreateTexture(nil, "BACKGROUND")
    checkButton.tex:SetAllPoints()
    checkButton.tex:SetColorTexture(0, 0, 0, 0.5)

    function checkButton:SetBackgroundColor(r, g, b, a)
        checkButton.tex:SetColorTexture(r, g, b, a)
    end

    -- Border
    local borderColor = LRP.gs.visual.borderColor

    LRP:AddBorder(checkButton)
    checkButton:SetBorderColor(borderColor.r, borderColor.g, borderColor.b)

    -- Title
    checkButton.title = checkButton:CreateFontString(nil, "OVERLAY")

    checkButton.title:SetFont(LRP.gs.visual.font, 13, LRP.gs.visual.fontFlags)
    checkButton.title:SetText(string.format("|cFFFFCC00%s|r", title))

    if labelLeft then
        checkButton.title:SetPoint("RIGHT", checkButton, "LEFT", -4, -1)
    else
        checkButton.title:SetPoint("LEFT", checkButton, "RIGHT", 4, -1)
    end

    -- Check
    checkButton.checkmark = checkButton:CreateTexture(nil, "OVERLAY")
    checkButton.checkmark:SetAllPoints()
    checkButton.checkmark:SetAtlas("common-icon-checkmark-yellow")

    function checkButton:SetChecked(checked)
        isChecked = checked

        checkButton.checkmark:SetShown(checked)
    end

    checkButton:SetScript(
        "OnClick",
        function()
            checkButton:SetChecked(not isChecked)
        end
    )

    hooksecurefunc(
        checkButton,
        "SetChecked",
        function(_, checked, dontRun)
            if dontRun then return end -- To avoid recursion

            checkButton.OnValueChanged(checked)
        end
    )

    return checkButton
end