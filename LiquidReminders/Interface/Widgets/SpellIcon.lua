local _, LRP = ...

function LRP:CreateSpellIcon(parent)
    local spellIcon = CreateFrame("Button", nil, parent)

    spellIcon.OnEnter = function() end
    spellIcon.OnLeave = function() end

    spellIcon:SetScript("OnEnter", function(_self) _self.OnEnter() end)
    spellIcon:SetScript("OnLeave", function(_self) _self.OnLeave() end)

    spellIcon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

    spellIcon.tex = spellIcon:CreateTexture(nil, "BACKGROUND")
    spellIcon.tex:SetAllPoints(spellIcon)
    spellIcon.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    LRP:AddBorder(spellIcon)
    LRP:AddTooltip(spellIcon)

    function spellIcon:SetSpellID(spellID)
        spellID = tonumber(spellID)

        local spellInfo = spellID and C_Spell.GetSpellInfo(spellID)

        if spellInfo then
            local spell = Spell:CreateFromSpellID(spellID)

            spell:ContinueOnSpellLoad(
                function()
                    local description = spell:GetSpellDescription()

                    spellIcon.tooltipText = string.format("|cFFFFCC00%s|r", spellInfo.name)

                    if description and description ~= "" then
                        spellIcon.tooltipText = string.format("%s|n|n%s", spellIcon.tooltipText, description)
                    end
                end
            )

            spellIcon.tex:SetTexture(spellInfo.iconID)
        else
            spellIcon.tooltipText = "|cffffffffInvalid spell ID|r"
            spellIcon.tex:SetTexture(134400)
        end
    end

    spellIcon:SetSpellID()

    return spellIcon
end