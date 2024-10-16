local _, LRP = ...

LRP.timelineData[1].encounters[3].phases = {}

LRP.timelineData[1].encounters[3].events = {
    -- Shattering Sweep
    {
        event = "SPELL_CAST_START",
        spellID = 456420,
        color = {250/255, 57/255, 90/255},
        show = true,
        entries = {
            {60 * 1 + 30, 5},
            {60 * 3 +  8, 5},
            {60 * 4 + 45, 5},
            {60 * 6 + 25, 5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 456420,
        show = false,
        entries = {
            {60 * 1 + 35},
            {60 * 3 + 13},
            {60 * 4 + 50},
            {60 * 6 + 30},
        }
    },

    -- Phase Blades
    {
        event = "SPELL_CAST_START",
        spellID = 433519,
        color = {250/255, 89/255, 35/255},
        show = true,
        entries = {
            {60 * 0 + 17, 2},
            {60 * 0 + 44, 2},
            {60 * 1 + 12, 2},

            {60 * 1 + 53, 2},
            {60 * 2 + 21, 2},
            {60 * 2 + 49, 2},

            {60 * 3 + 31, 2},
            {60 * 3 + 59, 2},
            {60 * 4 + 27, 2},

            {60 * 5 +  8, 2},
            {60 * 5 + 36, 2},
            {60 * 6 +  4, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 433519,
        show = false,
        entries = {
            {60 * 0 + 19},
            {60 * 0 + 46},
            {60 * 1 + 14},

            {60 * 1 + 55},
            {60 * 2 + 23},
            {60 * 2 + 51},

            {60 * 3 + 33},
            {60 * 4 +  1},
            {60 * 4 + 29},

            {60 * 5 + 10},
            {60 * 5 + 38},
            {60 * 6 +  6},
        }
    },

    -- Decimate
    {
        event = "SPELL_CAST_START",
        spellID = 442428,
        color = {80/255, 69/255, 245/255},
        show = true,
        entries = {
            {60 * 0 + 51, 2},
            {60 * 1 + 17, 2},
            {60 * 2 + 32, 2},
            {60 * 3 +  0, 2},
            {60 * 4 + 10, 2},
            {60 * 4 + 38, 2},
            {60 * 5 + 47, 2},
            {60 * 6 + 15, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 442428,
        show = false,
        entries = {
            {60 * 0 + 53},
            {60 * 1 + 19},
            {60 * 2 + 34},
            {60 * 3 +  2},
            {60 * 4 + 12},
            {60 * 4 + 40},
            {60 * 5 + 49},
            {60 * 6 + 17},
        }
    },

    -- Captain's Flourish
    {
        spellID = 439511,
        color = {211/255, 79/255, 247/255},
        show = true,
        entries = {
            {60 * 0 +  6, 4},
            {60 * 0 + 32, 4},
            {60 * 0 + 57, 4},
            {60 * 1 + 23, 4},

            {60 * 1 + 41, 4},
            {60 * 2 +  9, 4},
            {60 * 2 + 37, 4},
            {60 * 3 +  5, 4},

            {60 * 3 + 19, 4},
            {60 * 3 + 47, 4},
            {60 * 4 + 15, 4},
            {60 * 4 + 43, 4},

            {60 * 4 + 56, 4},
            {60 * 5 + 24, 4},
            {60 * 5 + 52, 4},
            {60 * 6 + 20, 4},
        }
    },

    -- Rain of Arrows
    {
        event = "SPELL_CAST_START",
        spellID = 439559,
        color = {209/255, 209/255, 209/255},
        show = true,
        entries = {
            {60 * 0 + 23, 2},
            {60 * 1 +  6, 2},

            {60 * 2 +  0, 2},
            {60 * 2 + 26, 2},
            {60 * 2 + 53, 2},

            {60 * 3 + 37, 2},
            {60 * 4 +  4, 2},
            {60 * 4 + 30, 2},

            {60 * 5 + 15, 2},
            {60 * 5 + 41, 2},
            {60 * 6 +  8, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 439559,
        show = false,
        entries = {
            {60 * 0 + 25},
            {60 * 1 +  8},

            {60 * 2 +  2},
            {60 * 2 + 28},
            {60 * 2 + 55},

            {60 * 3 + 39},
            {60 * 4 +  6},
            {60 * 4 + 32},

            {60 * 5 + 17},
            {60 * 5 + 43},
            {60 * 6 + 10},
        }
    },
}