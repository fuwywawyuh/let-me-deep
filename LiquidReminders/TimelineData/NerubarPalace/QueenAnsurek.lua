local _, LRP = ...

LRP.timelineData[1].encounters[8].phases = {
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 447207, -- Predation
        count = 1,
        name = "Intermission",
        shortName = "I1"
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 447207, -- Predation
        count = 1,
        name = "Phase 2",
        shortName = "P2"
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 448300, -- Echoing Connection (Ascended Voidspeaker)
        count = 1,
        name = "Platform 1",
        shortName = "Platform 1"
    },
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 462693, -- Echoing Connection (Chamber Expeller)
        count = 3,
        name = "Platform 2",
        shortName = "Platform 2"
    },
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 448300, -- Echoing Connection (Ascended Voidspeaker)
        count = 3,
        name = "Platform 3",
        shortName = "Platform 3"
    },
    {
        event = "UNIT_SPELLCAST_SUCCEEDED",
        spellID = 450040, -- Land
        count = 1,
        name = "Phase 3",
        shortName = "P3"
    },
}

LRP.timelineData[1].encounters[8].events = {
    -- Venom Nova
    {
        event = "SPELL_CAST_START",
        spellID = 437417,
        color = {245/255, 37/255, 89/255},
        show = true,
        entries = {
            {60 * 0 + 29, 5},
            {60 * 1 + 25, 5},
            {60 * 2 + 21, 5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 437417,
        show = false,
        entries = {
            {60 * 0 + 34},
            {60 * 1 + 29},
            {60 * 2 + 26},
        }
    },

    -- Reactive Toxin
    {
        event = "SPELL_CAST_START",
        spellID = 437592,
        show = false,
        entries = {
            {60 * 0 + 19, 1},
            {60 * 1 + 15, 1},
            {60 * 2 +  8, 1},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 437592,
        color = {24/255, 128/255, 4/255},
        show = true,
        entries = {
            {60 * 0 + 20, 5},
            {60 * 1 + 16, 5},
            {60 * 2 +  9, 5},
        }
    },

    -- Silken Tomb
    {
        event = "SPELL_CAST_START",
        spellID = 439814,
        color = {226/255, 235/255, 113/255},
        show = true,
        entries = {
            {60 * 0 + 12, 4},
            {60 * 0 + 52, 4},
            {60 * 1 + 46, 4},
            {60 * 2 + 12, 4},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 439814,
        show = false,
        entries = {
            {60 * 0 + 16},
            {60 * 0 + 56},
            {60 * 1 + 50},
            {60 * 2 + 16},
        }
    },

    -- Liquefy
    {
        event = "SPELL_CAST_START",
        spellID = 440899,
        color = {47/255, 230/255, 34/255},
        show = true,
        entries = {
            {60 * 0 +  6, 2},
            {60 * 0 + 46, 2},
            {60 * 1 + 40, 2},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 440899,
        show = false,
        entries = {
            {60 * 0 +  8},
            {60 * 0 + 48},
            {60 * 1 + 42},
        }
    },

    -- Feast
    {
        event = "SPELL_CAST_START",
        spellID = 437093,
        color = {176/255, 43/255, 28/255},
        show = true,
        entries = {
            {60 * 0 +  8, 1},
            {60 * 0 + 48, 1},
            {60 * 1 + 42, 1},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 437093,
        show = false,
        entries = {
            {60 * 0 +  9},
            {60 * 0 + 49},
            {60 * 1 + 43},
        }
    },

    -- Web Blades
    {
        spellID = 439299,
        color = {180/255, 180/255, 180/255},
        show = true,
        entries = {
            {60 * 0 + 20, 4},
            {60 * 1 +  0, 4},
            {60 * 1 + 13, 4},
            {60 * 1 + 38, 4},
            {60 * 1 + 54, 4},
            {60 * 2 + 20, 4},

            {60 * 6 + 13.6, 4},
            {60 * 6 + 24.6, 4},

            {60 * 6 + 50.6, 4},
            {60 * 7 + 11.6, 4},
            {60 * 7 + 28.6, 4},
            {60 * 7 + 44.6, 4},

            {60 * 8 + 31.6, 4},
            {60 * 8 + 50.6, 4},
            {60 * 9 +  4.6, 4},
            {60 * 9 + 28.0, 4},
        }
    },

    -- Predation
    {
        event = "SPELL_CAST_START",
        spellID = 447076,
        show = false,
        entries = {
            {60 * 2 + 33.9, 4},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 447076,
        show = false,
        entries = {
            {60 * 2 + 37.9},
        }
    },
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 447207,
        color = {194/255, 167/255, 128/255},
        show = true,
        entries = {
            {60 * 2 + 37.9, 42.4},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 447207,
        show = false,
        entries = {
            {60 * 3 + 20.3},
        }
    },

    -- Paralyzing Venom
    {
        event = "SPELL_CAST_START",
        spellID = 447456,
        color = {46/255, 230/255, 129/255},
        show = true,
        entries = {
            {60 * 2 + 47, 2.5},
            {60 * 2 + 51, 2.5},
            {60 * 2 + 55, 2.5},

            {60 * 3 +  6, 2.5},
            {60 * 3 + 10, 2.5},
            {60 * 3 + 14, 2.5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 447456,
        show = false,
        entries = {
            {60 * 2 + 49.5},
            {60 * 2 + 53.5},
            {60 * 2 + 57.5},

            {60 * 3 +  8.5},
            {60 * 3 + 12.5},
            {60 * 3 + 16.5},
        }
    },

    -- Wrest
    {
        event = "SPELL_CAST_START",
        spellID = 447411,
        color = {235/255, 218/255, 47/255},
        show = true,
        entries = {
            {60 * 2 + 40, 6},
            {60 * 2 + 59, 6},
            {60 * 3 + 18, 2.3}, -- This cast is never finished

            {60 * 3 + 56.3, 5},
            {60 * 4 +  4.3, 5},

            {60 * 4 + 26.8, 5},
            {60 * 4 + 34.8, 5},
            {60 * 4 + 42.8, 5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 447411,
        show = false,
        entries = {
            {60 * 2 + 46},
            {60 * 3 +  5},

            {60 * 4 +  1.3, 5},
            {60 * 4 +  9.3, 5},

            {60 * 4 + 31.8, 5},
            {60 * 4 + 39.8, 5},
            {60 * 4 + 47.8, 5},
        }
    },

    -- Radiating Gloom
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 447999,
        show = false,
        entries = {
            {60 * 3 + 27.9},
            {60 * 3 + 27.9},

            {60 * 4 + 59.3},
            {60 * 4 + 59.3},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 447999,
        show = false,
        entries = {
            {60 * 3 + 44.6},
            {60 * 3 + 44.6},

            {60 * 5 + 18.8},
            {60 * 5 + 18.8},
        }
    },

    -- Echoing Connection (Ascended Voidspeaker)
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 448300,
        show = false,
        entries = {
            {60 * 3 + 26.0},
            {60 * 3 + 26.0},

            {60 * 4 + 57.8},
            {60 * 4 + 57.8},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 448300,
        show = false,
        entries = {
            {60 * 3 + 44.6},
            {60 * 3 + 44.6},

            {60 * 5 + 18.7},
            {60 * 5 + 18.7},
        }
    },

    -- Echoing Connection (Chamber Guardian)
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 462692,
        show = false,
        entries = {
            {60 * 3 + 52.0},
            {60 * 3 + 52.0},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 462692,
        show = false,
        entries = {
            {60 * 4 + 15.0},
            {60 * 4 + 15.0},
        }
    },

    -- Echoing Connection (Chamber Expeller)
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 462693,
        show = false,
        entries = {
            {60 * 3 + 52.4},
            {60 * 3 + 52.4},

            {60 * 4 + 22.3},
            {60 * 4 + 22.3},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 462693,
        show = false,
        entries = {
            {60 * 4 + 16.1},
            {60 * 4 + 16.1},

            {60 * 4 + 49.9},
            {60 * 4 + 49.9},
        }
    },

    -- Ascended Voidspeaker death (old phase change trigger)
    {
        event = "UNIT_DIED",
        spellID = 223150,
        show = false,
        entries = {
            {60 * 3 + 44.6},
        }
    },

    -- Expulsion Beam (taking the average from both sides)
    {
        event = "SPELL_CAST_START",
        spellID = 451600,
        color = {51/255, 68/255, 255/255},
        show = true,
        entries = {
            {60 * 3 + 57.3, 3},
            {60 * 4 +  7.3, 3},
            {60 * 4 + 26.5, 3},
            {60 * 4 + 36.5, 3},
            {60 * 4 + 46.5, 3},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 451600,
        show = false,
        entries = {
            {60 * 4 +  0.3, 3},
            {60 * 4 + 10.3, 3},
            {60 * 4 + 29.5, 3},
            {60 * 4 + 39.5, 3},
            {60 * 4 + 49.5, 3},
        }
    },

    -- Dark Detonation (old phase change trigger)
    {
        event = "SPELL_CAST_START",
        spellID = 455374,
        show = false,
        entries = {
            {60 * 4 + 29.9}
        }
    },

    -- Frothing Gluttony
    {
        event = "SPELL_CAST_START",
        spellID = 445422,
        show = false,
        entries = {
            {60 * 6 + 33.6, 5},
            {60 * 7 + 53.6, 5},
            {60 * 9 + 21.5, 5},
            {60 * 9 + 57.1, 5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 445422,
        show = false,
        entries = {
            {60 * 6 + 38.6},
            {60 * 7 + 58.6},
            {60 * 9 + 26.5},
            {60 * 10 +  2.1},
        }
    },
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 445632,
        color = {230/255, 46/255, 156/255},
        show = true,
        entries = {
            {60 * 6 + 39.6, 9},
            {60 * 7 + 59.6, 9},
            {60 * 9 + 27.5, 9},
            {60 * 10 +  3.1, 9},
        }
    },
    {
        event = "SPELL_AURA_REMOVED",
        spellID = 445632,
        show = false,
        entries = {
            {60 * 6 + 48.6},
            {60 * 8 +  8.6},
            {60 * 9 + 36.5},
            {60 * 10 + 12.1},
        }
    },

    -- Abyssal Infusion
    {
        event = "SPELL_CAST_START",
        spellID = 443888,
        show = false,
        entries = {
            {60 * 6 + 22.5, 1},
            {60 * 7 + 42.6, 1},
            {60 * 9 +  2.6, 1},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 443888,
        show = false,
        entries = {
            {60 * 6 + 23.5},
            {60 * 7 + 43.6},
            {60 * 9 +  3.6},
        }
    },
    {
        spellID = 443903,
        color = {69/255, 36/255, 237/255},
        show = true,
        entries = {
            {60 * 6 + 24.3, 6},
            {60 * 7 + 44.3, 6},
            {60 * 9 +  4.3, 6},
        }
    },

    -- Queen's Summons
    {
        event = "SPELL_CAST_START",
        spellID = 444829,
        color = {222/255, 185/255, 104/255},
        show = true,
        entries = {
            {60 * 6 +  8.5, 4},
            {60 * 7 + 12.5, 4},
            {60 * 8 + 35.5, 4},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 444829,
        show = false,
        entries = {
            {60 * 6 + 12.5, 4},
            {60 * 7 + 16.5, 4},
            {60 * 8 + 39.5, 4},
        }
    },

    -- Royal Condemnation
    {
        event = "SPELL_CAST_START",
        spellID = 438976,
        show = false,
        entries = {
            {60 * 7 + 21.0, 1.5},
            {60 * 8 + 13.2, 1.5},
            {60 * 8 + 47.0, 1.5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 438976,
        show = false,
        entries = {
            {60 * 7 + 22.5, 1.5},
            {60 * 8 + 14.7, 1.5},
            {60 * 8 + 48.5, 1.5},
        }
    },
    {
        spellID = 438974,
        color = {72/255, 130/255, 150/255},
        show = true,
        entries = {
            {60 * 7 + 16.6, 6.3},
            {60 * 8 +  8.6, 6.3},
            {60 * 8 + 42.5, 6.3},
        }
    },

    -- Land (6s before first Infest cast start)
    {
        event = "UNIT_SPELLCAST_SUCCEEDED",
        spellID = 450040,
        show = false,
        entries = {
            {60 * 5 + 48.5},
        }
    },

    -- Infest
    {
        event = "SPELL_CAST_START",
        spellID = 443325,
        show = false,
        entries = {
            {60 * 5 + 54.5, 1.5},
            {60 * 7 +  0.5, 1.5},
            {60 * 8 + 22.5, 1.5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 443325,
        show = false,
        entries = {
            {60 * 5 + 56.0},
            {60 * 7 +  2.0},
            {60 * 8 + 24.0},
        }
    },
    {
        spellID = 443656,
        color = {100/255, 158/255, 96/255},
        show = true,
        entries = {
            {60 * 5 + 56.0, 4},
            {60 * 7 +  2.0, 4},
            {60 * 8 + 24.0, 4},
        }
    },

    -- Gorge
    {
        event = "SPELL_CAST_START",
        spellID = 443336,
        color = {135/255, 58/255, 201/255},
        show = true,
        entries = {
            {60 * 5 + 56.5, 3.5},
            {60 * 7 +  2.5, 3.5},
            {60 * 8 + 24.5, 3.5},
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 443336,
        show = false,
        entries = {
            {60 * 5 + 57.5},
            {60 * 7 +  3.5},
            {60 * 8 + 25.5},
        }
    },

    -- Dreadful Presence
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 445268,
        show = false,
        entries = {
            {60 * 5 + 45.0}
        }
    },

    -- Aphotic Communion
    {
        event = "SPELL_CAST_START",
        spellID = 449986,
        show = false,
        entries = {
            {60 * 5 + 25.0}
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 449986,
        show = false,
        entries = {
            {60 * 5 + 45.0}
        }
    },

    -- Cataclysmic Evolution
    {
        event = "SPELL_AURA_APPLIED",
        spellID = 451832,
        show = false,
        entries = {
            {60 * 9 + 24.0}
        }
    },
    {
        event = "SPELL_CAST_SUCCESS",
        spellID = 451832,
        show = false,
        entries = {
            {60 * 9 + 24.0}
        }
    },
}
