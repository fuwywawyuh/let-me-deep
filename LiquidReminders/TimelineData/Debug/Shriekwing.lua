local _, LRP = ...

if LRP.gs.debug then
    LRP.timelineData[2].encounters[1].phases = {
        {
            event = "SPELL_CAST_START",
            spellID = 328857,
            count = 1,
            name = "Phase 2",
            shortName = "P2"
        },
        {
            event = "SPELL_CAST_START",
            spellID = 328857,
            count = 2,
            name = "Phase 2",
            shortName = "P2"
        },
        {
            event = "SPELL_CAST_START",
            spellID = 328857,
            count = 3,
            name = "Phase 2",
            shortName = "P2"
        },
        {
            event = "SPELL_CAST_START",
            spellID = 328857,
            count = 4,
            name = "Phase 2",
            shortName = "P2"
        },
    }
    
    LRP.timelineData[2].encounters[1].events = {
        {
            event = "SPELL_CAST_START",
            spellID = 328857,
            color = {245/255, 49/255, 78/255},
            show = true,
            entries = {
                {60 * 0 + 10, 2},
                {60 * 0 + 20, 2},
                {60 * 0 + 30, 2},
                {60 * 0 + 40, 2},
            }
        },
    }
end