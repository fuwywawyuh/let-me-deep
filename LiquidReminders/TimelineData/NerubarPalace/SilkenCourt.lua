local _, LRP = ...

LRP.timelineData[1].encounters[7].phases = {
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 450980, -- Shatter Resistance
        count = 1,
        name = "Intermission 1",
        shortName = "I1"
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 450980, -- Shatter Resistance
        count = 1,
        name = "Phase 2",
        shortName = "P2"
    },
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 451277, -- Spike Storm
        count = 1,
        name = "Intermission 2",
        shortName = "I2"
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 451277, -- Spike Storm
        count = 1,
        name = "Phase 3",
        shortName = "P3"
    },
}

LRP.timelineData[1].encounters[7].events = {
    -- Venomous Rain
    {
        event = "SPELL_CAST_START",
        spellID = 438343,
        show = false,
        entries = {
            {60 * 0 + 18, 2},
            {60 * 0 + 52, 2},
            {60 * 1 + 18, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 438343,
        color = {50/255, 168/255, 82/255},
        show = true,
        entries = {
            {60 * 0 + 20, 10},
            {60 * 0 + 54, 10},
            {60 * 1 + 20, 10},
        }
    },

    -- Web Bomb
    {
        event = "SPELL_CAST_START",
        spellID = 439838,
        color = {190/255, 194/255, 140/255},
        show = true,
        entries = {
            {60 * 0 + 15, 2},
            {60 * 1 + 25, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 439838,
        show = false,
        entries = {
            {60 * 0 + 17},
            {60 * 1 + 27},
        }
    },

    -- Call of the Swarm
    {
        event = "SPELL_CAST_START",
        spellID = 438801,
        color = {152/255, 48/255, 156/255},
        show = true,
        entries = {
            {60 * 0 + 23, 3},
            {60 * 1 + 16, 3},

            {60 * 3 + 52, 3},
            {60 * 4 + 53, 3},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 438801,
        show = false,
        entries = {
            {60 * 0 + 26},
            {60 * 1 + 19},

            {60 * 3 + 55},
            {60 * 4 + 56},
        }
    },

    -- Impaling Eruption
    {
        event = "SPELL_CAST_START",
        spellID = 440504,
        color = {242/255, 88/255, 22/255},
        show = true,
        entries = {
            {60 * 0 +  8, 4},
            {60 * 0 + 28, 4},
            {60 * 1 +  2, 4},
            {60 * 1 + 22, 4},

            {60 * 3 + 35, 4},
            {60 * 4 +  5, 4},
            {60 * 4 + 35, 4},
            {60 * 4 +  5, 4},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 440504,
        show = false,
        entries = {
            {60 * 0 + 12},
            {60 * 0 + 32},
            {60 * 1 +  6},
            {60 * 1 + 26},

            {60 * 3 + 39},
            {60 * 3 +  9},
            {60 * 4 + 39},
            {60 * 4 +  9},
        }
    },

    -- Reckless Charge
    {
        event = "SPELL_CAST_START",
        spellID = 440246,
        color = {199/255, 132/255, 38/255},
        show = true,
        entries = {
            {60 * 0 + 38, 6},
            {60 * 1 + 38, 6},

            {60 * 8 +  1, 6},
            {60 * 9 + 39, 6},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 440246,
        show = false,
        entries = {
            {60 * 0 + 44},
            {60 * 1 + 44},

            {60 * 8 +  7},
            {60 * 9 + 45},
        }
    },

    -- Web Vortex
    {
        event = "SPELL_CAST_START",
        spellID = 441626,
        color = {163/255, 162/255, 171/255},
        show = true,
        entries = {
            {60 * 3 + 44, 2},
            {60 * 3 + 47, 2},
            {60 * 4 + 40, 2},
            {60 * 4 + 43, 2},

            {60 * 7 + 47, 2},
            {60 * 7 + 50, 2},
            {60 * 8 + 21, 2},
            {60 * 8 + 24, 2},
            {60 * 9 + 25, 2},
            {60 * 9 + 28, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 441626,
        show = false,
        entries = {
            {60 * 3 + 46},
            {60 * 3 + 49},
            {60 * 4 + 42},
            {60 * 4 + 45},

            {60 * 7 + 49},
            {60 * 7 + 52},
            {60 * 8 + 23},
            {60 * 8 + 26},
            {60 * 9 + 27},
            {60 * 9 + 30},
        }
    },

    -- Entropic Desolation
    {
        event = "SPELL_CAST_START",
        spellID = 450129,
        color = {67/255, 214/255, 247/255},
        show = true,
        entries = {
            {60 * 3 + 50, 5},
            {60 * 4 + 46, 5},

            {60 * 7 + 53, 5},
            {60 * 8 + 27, 5},
            {60 * 9 + 31, 5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 450129,
        show = false,
        entries = {
            {60 * 3 + 55},
            {60 * 4 + 51},

            {60 * 7 + 58},
            {60 * 8 + 32},
            {60 * 9 + 36},
        }
    },

    -- Strands of Reality
    {
        event = "SPELL_CAST_START",
        spellID = 441782,
        color = {145/255, 33/255, 219/255},
        show = true,
        entries = {
            {60 * 3 + 56, 4},
            {60 * 4 + 31, 4},
            {60 * 4 + 56, 4},

            {60 * 7 + 37, 4},
            {60 * 8 + 10, 4},
            {60 * 8 + 35, 4},
            {60 * 9 + 18, 4},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 441782,
        show = false,
        entries = {
            {60 * 4 +  0},
            {60 * 4 + 35},
            {60 * 5 +  0},

            {60 * 7 + 41},
            {60 * 8 + 14},
            {60 * 8 + 39},
            {60 * 9 + 22},
        }
    },

    -- Stinging Swarm
    {
        event = "SPELL_CAST_START",
        spellID = 438677,
        color = {50/255, 150/255, 255/255},
        show = true,
        entries = {
            {60 * 3 + 49, 2},
            {60 * 4 + 47, 2},

            {60 * 8 + 36, 2},
            {60 * 9 + 33, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 438677,
        show = false,
        entries = {
            {60 * 3 + 51},
            {60 * 4 + 49},

            {60 * 8 + 38},
            {60 * 9 + 35},
        }
    },

    -- Cataclysmic Entropy
    {
        event = "SPELL_CAST_START",
        spellID = 438355,
        color = {255/255, 14/255, 41/255},
        show = true,
        entries = {
            {60 * 4 +  6, 10},
            {60 * 5 +  4, 10},

            {60 * 8 + 47, 10},
            {60 * 9 + 49, 10},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 438355,
        show = false,
        entries = {
            {60 * 4 + 16},
            {60 * 5 + 14},

            {60 * 8 + 57},
            {60 * 9 + 59},
        }
    },

    -- Spike Eruption
    {
        event = "SPELL_CAST_START",
        spellID = 443068,
        show = false,
        entries = {
            {60 * 7 + 55, 2},
            {60 * 8 + 26, 2},
            {60 * 9 + 30, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 443068,
        color = {125/255, 78/255, 45/255},
        show = true,
        entries = {
            {60 * 7 + 57, 9},
            {60 * 8 + 28, 9},
            {60 * 9 + 32, 9},
        }
    },

    -- Unleashed Swarm
    {
        event = "SPELL_CAST_START",
        spellID = 442994,
        show = false,
        entries = {
            {60 * 7 + 38, 3},
            {60 * 8 + 53, 3},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 442994,
        color = {107/255, 196/255, 63/255},
        show = true,
        entries = {
            {60 * 7 + 41, 8},
            {60 * 8 + 56, 8},
        }
    },

    -- Piercing Strike
    {
        event = "SPELL_CAST_START",
        spellID = 438218,
        color = {230/255, 199/255, 78/255},
        show = true,
        entries = {
            {60 * 0 + 13, 2},
            {60 * 0 + 33, 2},
            {60 * 1 +  0, 2},
            {60 * 1 + 20, 2},
            {60 * 2 +  0, 2},

            {60 * 3 + 40, 2},
            {60 * 4 +  0, 2},
            {60 * 4 + 25, 2},
            {60 * 4 + 40, 2},
            {60 * 5 +  0, 2},
            {60 * 5 + 25, 2},

            {60 * 7 + 35, 2},
            {60 * 8 + 24, 2},
            {60 * 8 + 44, 2},
            {60 * 9 +  5, 2},
            {60 * 9 + 25, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 438218,
        show = false,
        entries = {
            {60 * 0 + 15, 2},
            {60 * 0 + 35, 2},
            {60 * 1 +  2, 2},
            {60 * 1 + 22, 2},
            {60 * 2 +  2, 2},

            {60 * 3 + 42, 2},
            {60 * 4 +  2, 2},
            {60 * 4 + 27, 2},
            {60 * 4 + 42, 2},
            {60 * 5 +  2, 2},
            {60 * 5 + 27, 2},

            {60 * 7 + 37, 2},
            {60 * 8 + 26, 2},
            {60 * 8 + 46, 2},
            {60 * 9 +  7, 2},
            {60 * 9 + 27, 2},
        }
    },

    -- Shatter Existence
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 450980,
        show = false,
        entries = {
            {60 * 2 + 10},
        }
    },
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 450980,
        color = {50/255, 26/255, 201/255},
        show = true,
        entries = {
            {60 * 2 + 10, 74},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 450980,
        show = false,
        entries = {
            {60 * 3 + 24},
        }
    },

    -- Spike Storm
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 451277,
        show = false,
        entries = {
            {60 * 5 + 39},
        }
    },
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 451277,
        color = {153/255, 47/255, 26/255},
        show = true,
        entries = {
            {60 * 5 + 39, 95},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 451277,
        show = false,
        entries = {
            {60 * 7 + 14},
        }
    },
}