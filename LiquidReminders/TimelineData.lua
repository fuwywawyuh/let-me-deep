local _, LRP = ...

LRP.timelineData = {
    {
        name = "Nerub-ar Palace",
        icon = 5779391,
        encounters = {
            {
                name = "Ulgrax the Devourer",
                icon = 5779390,
                id = 2902,
                events = {},
                phases = {}
            },
            {
                name = "The Bloodbound Horror",
                icon = 5779386,
                id = 2917,
                events = {},
                phases = {}
            },
            {
                name = "Sikran, Captain of the Sureki",
                icon = 5779389,
                id = 2898,
                events = {},
                phases = {}
            },
            {
                name = "Rasha'nan",
                icon = 5661707,
                id = 2918,
                events = {},
                phases = {}
            },
            {
                name = "Broodtwister Ovi'nax",
                icon = 5688871,
                id = 2919,
                events = {},
                phases = {}
            },
            {
                name = "Nexus-Princess Ky'veza",
                icon = 5779388,
                id = 2920,
                events = {},
                phases = {}
            },
            {
                name = "Silken Court",
                icon = 5779387,
                id = 2921,
                events = {},
                phases = {}
            },
            {
                name = "Queen Ansurek",
                icon = 5779391,
                id = 2922,
                events = {},
                phases = {}
            },
        },
    }
}

if LRP.gs.debug then
    table.insert(
        LRP.timelineData,
        {
            name = "Castle Nathria",
            icon = 3614361,
            encounters = {
                {
                    name = "Shriekwing",
                    icon = 3614368,
                    id = 2398,
                    events = {},
                    phases = {}
                },
            }
        }
    )
end

function LRP:InitializeTimelineData()
    -- Transforms the above table into an infotable that can be interpreted by dropdown widgets
    LRP.timelineDataInfoTable = {}

    for i, instanceInfo in ipairs(LRP.timelineData) do
        LRP.timelineDataInfoTable[i] = {
            text = instanceInfo.name,
            icon = instanceInfo.icon,
            value = i,
            children = {}
        }

        for j, encounterInfo in ipairs(instanceInfo.encounters) do
            LRP.timelineDataInfoTable[i].children[j] = {
                text = encounterInfo.name,
                icon = encounterInfo.icon,
                value = j
            }
        end
    end

    -- Add a time field to the phase entries for encounters
    -- This time field is based on when the specified event happens according to the event table
    -- This is only done to know (estimate) where the phase labels/reminder lines should appear on the timeline
    -- Actual reminders during encounters show based on the events themselves, not based on this estimated time
    for _, instanceInfo in ipairs(LRP.timelineData) do
        for _, encounterInfo in ipairs(instanceInfo.encounters) do
            for _, phaseInfo in ipairs(encounterInfo.phases) do
                for _, eventInfo in ipairs(encounterInfo.events) do
                    if phaseInfo.event == eventInfo.event and phaseInfo.spellID == eventInfo.spellID then
                        phaseInfo.time = eventInfo.entries[phaseInfo.count][1]
                    end
                end
            end
        end 
    end

    -- Populate the "track visibility" table in options
    -- This table determines which tracks show on the timeline
    -- Users can turn certain tracks off in case they are not interested in them (e.g. role-specific abilities like tank slams)
    if not LiquidRemindersSaved.settings.timeline.trackVisibility then LiquidRemindersSaved.settings.timeline.trackVisibility = {} end

    local trackVisibility = LiquidRemindersSaved.settings.timeline.trackVisibility

    for _, instanceInfo in ipairs(LRP.timelineData) do
        for _, encounterInfo in ipairs(instanceInfo.encounters) do
            local encounterID = encounterInfo.id

            -- If this is the first time we see this encounter, create a table for it
            if not trackVisibility[encounterID] then
                trackVisibility[encounterID] = {}
            end

            for _, eventInfo in ipairs(encounterInfo.events) do
                if eventInfo.show then
                    local spellID = eventInfo.spellID

                    -- If the entry does not exist yet, set it to show by default
                    if trackVisibility[encounterID][spellID] == nil then
                        trackVisibility[encounterID][spellID] = true
                    end
                end
            end
        end 
    end
end