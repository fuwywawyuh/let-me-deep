local _, LRP = ...

LRP.timelineData[1].encounters[4].phases = {
    {
        event = "SPELL_CAST_START",
        spellID = 439795, -- Web Reave
        count = 1,
        name = "Kick 1",
        shortName = "Kick 1"
    },
    {
        event = "SPELL_CAST_START",
        spellID = 439795, -- Web Reave
        count = 2,
        name = "Kick 2",
        shortName = "Kick 2"
    },
    {
        event = "SPELL_CAST_START",
        spellID = 439795, -- Web Reave
        count = 3,
        name = "Kick 3",
        shortName = "Kick 3"
    },
    {
        event = "SPELL_CAST_START",
        spellID = 439795, -- Web Reave
        count = 4,
        name = "Kick 4",
        shortName = "Kick 4"
    },
    {
        event = "SPELL_CAST_START",
        spellID = 439795, -- Web Reave
        count = 5,
        name = "Kick 5",
        shortName = "Kick 5"
    },
}

LRP.timelineData[1].encounters[4].events = {
    -- Acidic Eruption
    {
        event = "SPELL_CAST_START",
        spellID = 452806,
        color = {245/255, 49/255, 78/255},
        show = true,
        entries = {
            {60 * 1 +  2, 3},
            {60 * 2 +  7, 3},
            {60 * 3 + 13, 3},
            {60 * 4 + 17, 3},
            {60 * 5 + 23, 3},
        }
    },

    -- Web Reave
    {
        event = "SPELL_CAST_START",
        spellID = 439795,
        color = {245/255, 240/255, 206/255},
        show = true,
        entries = {
            {60 * 1 +  8, 4},
            {60 * 2 + 12, 4},
            {60 * 3 + 18, 4},
            {60 * 4 + 23, 4},
            {60 * 5 + 28, 4},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 439795,
        show = false,
        entries = {
            {60 * 1 + 12},
            {60 * 2 + 16},
            {60 * 3 + 22},
            {60 * 4 + 27},
            {60 * 5 + 32},
        }
    },

    -- Spinneret's Strands
    {
        event = "SPELL_CAST_START",
        spellID = 439784,
        color = {150/255, 150/255, 150/255},
        show = true,
        entries = {
            {60 * 0 + 14, 2},
            {60 * 1 + 38, 2},
            {60 * 2 + 28, 2},
            {60 * 2 + 43, 2},
            {60 * 3 + 33, 2},
            {60 * 5 + 38, 2},
            {60 * 5 + 58, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 439784,
        show = false,
        entries = {
            {60 * 0 + 16},
            {60 * 1 + 40},
            {60 * 2 + 30},
            {60 * 2 + 45},
            {60 * 3 + 35},
            {60 * 5 + 40},
            {60 * 6 +  0},
        }
    },

    -- Rolling Acid
    {
        event = "SPELL_CAST_START",
        spellID = 439789,
        show = false,
        entries = {
            {60 * 0 + 35, 2},
            {60 * 1 + 45, 2},
            {60 * 2 + 25, 2},
            {60 * 4 + 40, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 439789,
        show = false,
        entries = {
            {60 * 0 + 37},
            {60 * 1 + 47},
            {60 * 2 + 27},
            {60 * 4 + 42},
        }
    },
    {
        spellID = 439790,
        color = {226/255, 242/255, 82/255},
        show = true,
        entries = {
            {60 * 0 + 33, 5},
            {60 * 1 + 43, 5},
            {60 * 2 + 23, 5},
            {60 * 4 + 38, 5},
        }
    },

    -- Enveloping Webs
    {
        event = "SPELL_CAST_START",
        spellID = 454989,
        color = {174/255, 205/255, 209/255},
        show = true,
        entries = {
            {60 * 0 + 38, 4},
            {60 * 1 + 23, 4},
            {60 * 2 + 48, 4},
            {60 * 3 + 53, 4},
            {60 * 4 + 53, 4},
            {60 * 6 +  3, 4},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 454989,
        show = false,
        entries = {
            {60 * 0 + 40},
            {60 * 1 + 25},
            {60 * 2 + 50},
            {60 * 3 + 55},
            {60 * 4 + 55},
            {60 * 6 +  5},
        }
    },

    -- Savage Assault
    {
        event = "SPELL_CAST_START",
        spellID = 444687,
        color = {201/255, 146/255, 83/255},
        show = true,
        entries = {
            {60 * 0 +  5, 1},
            {60 * 0 + 28, 1},
            {60 * 0 + 30, 1},
            {60 * 0 + 43, 1},
            {60 * 0 + 45, 1},

            {60 * 1 + 14, 1},
            {60 * 1 + 16, 1},
            {60 * 1 + 34, 1},
            {60 * 1 + 36, 1},
            {60 * 1 + 48, 1},
            {60 * 1 + 50, 1},

            {60 * 2 + 19, 1},
            {60 * 2 + 21, 1},
            {60 * 2 + 39, 1},
            {60 * 2 + 41, 1},
            {60 * 2 + 53, 1},
            {60 * 2 + 55, 1},

            {60 * 3 + 24, 1},
            {60 * 3 + 26, 1},
            {60 * 3 + 44, 1},
            {60 * 3 + 46, 1},
            {60 * 3 + 58, 1},
            {60 * 4 +  0, 1},

            {60 * 4 + 29, 1},
            {60 * 4 + 31, 1},
            {60 * 4 + 49, 1},
            {60 * 4 + 51, 1},
            {60 * 5 +  3, 1},
            {60 * 5 +  5, 1},

            {60 * 5 + 34, 1},
            {60 * 5 + 36, 1},
            {60 * 5 + 54, 1},
            {60 * 5 + 56, 1},
            {60 * 6 +  8, 1},
            {60 * 6 + 10, 1},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 444687,
        show = false,
        entries = {
            {60 * 0 +  5},
            {60 * 0 + 28},
            {60 * 0 + 30},
            {60 * 0 + 43},
            {60 * 0 + 46},

            {60 * 1 + 14},
            {60 * 1 + 16},
            {60 * 1 + 34},
            {60 * 1 + 36},
            {60 * 1 + 48},
            {60 * 1 + 50},

            {60 * 2 + 19},
            {60 * 2 + 21},
            {60 * 2 + 39},
            {60 * 2 + 41},
            {60 * 2 + 53},
            {60 * 2 + 55},

            {60 * 3 + 24},
            {60 * 3 + 26},
            {60 * 3 + 44},
            {60 * 3 + 46},
            {60 * 3 + 58},
            {60 * 4 +  1},

            {60 * 4 + 29},
            {60 * 4 + 31},
            {60 * 4 + 49},
            {60 * 4 + 51},
            {60 * 5 +  3},
            {60 * 5 +  6},

            {60 * 5 + 34},
            {60 * 5 + 36},
            {60 * 5 + 54},
            {60 * 5 + 56},
            {60 * 6 +  8},
            {60 * 6 + 10},
        }
    },

    -- Erosive Spray
    {
        event = "SPELL_CAST_START",
        spellID = 439811,
        show = false,
        entries = {
            {60 * 0 +  8, 2},
            {60 * 0 + 48, 2},
            {60 * 1 + 28, 2},
            {60 * 1 + 53, 2},
            {60 * 2 + 33, 2},
            {60 * 2 + 58, 2},
            {60 * 3 + 38, 2},
            {60 * 4 +  3, 2},
            {60 * 4 + 43, 2},
            {60 * 5 +  8, 2},
            {60 * 5 + 48, 2},
            {60 * 6 + 13, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 439811,
        show = false,
        entries = {
            {60 * 0 + 10},
            {60 * 0 + 50},
            {60 * 1 + 30},
            {60 * 1 + 55},
            {60 * 2 + 35},
            {60 * 3 +  0},
            {60 * 3 + 40},
            {60 * 4 +  5},
            {60 * 4 + 45},
            {60 * 5 + 10},
            {60 * 5 + 50},
            {60 * 6 + 15},
        }
    },
    {
        spellID = 439811,
        color = {233/255, 137/255, 240/255},
        show = true,
        entries = {
            {60 * 0 + 10, 4},
            {60 * 0 + 50, 4},
            {60 * 1 + 30, 4},
            {60 * 1 + 55, 4},
            {60 * 2 + 35, 4},
            {60 * 3 +  0, 4},
            {60 * 3 + 40, 4},
            {60 * 4 +  5, 4},
            {60 * 4 + 45, 4},
            {60 * 5 + 10, 4},
            {60 * 5 + 50, 4},
            {60 * 6 + 15, 4},
        }
    },

    -- Infested Spawn
    {
        event = "SPELL_CAST_START",
        spellID = 455373,
        show = false,
        entries = {
            {60 * 0 + 19, 3},
            {60 * 1 + 18, 3},
            {60 * 3 + 29, 3},
            {60 * 3 + 49, 3},
            {60 * 4 + 34, 3},
            {60 * 4 + 59, 3},
            {60 * 5 + 43, 3},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 455373,
        show = false,
        entries = {
            {60 * 0 + 22, 3},
            {60 * 1 + 21, 3},
            {60 * 3 + 32, 3},
            {60 * 3 + 52, 3},
            {60 * 4 + 37, 3},
            {60 * 5 +  2, 3},
            {60 * 5 + 46, 3},
        }
    },
    {
        spellID = 455373,
        color = {93/255, 145/255, 240/255},
        show = true,
        entries = {
            {60 * 0 + 21, 4},
            {60 * 1 + 20, 4},
            {60 * 3 + 31, 4},
            {60 * 3 + 51, 4},
            {60 * 4 + 36, 4},
            {60 * 5 +  1, 4},
            {60 * 5 + 45, 4},
        }
    },

    -- Caustic Hail (different spell ID while flying vs. while stationary)
    {
        spellID = 456853,
        color = {30/255, 201/255, 99/255},
        show = true,
        entries = {
            {60 * 0 + 57, 3},
            {60 * 1 +  1, 3},

            {60 * 2 +  1, 3},
            {60 * 2 +  5, 3},

            {60 * 3 +  6, 3},
            {60 * 3 + 10, 3},

            {60 * 4 + 12, 3},
            {60 * 4 + 16, 3},

            {60 * 5 + 17, 3},
            {60 * 5 + 21, 3},
        }
    },
}