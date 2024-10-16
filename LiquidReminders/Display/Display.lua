local _, LRP = ...

-- Used to record death data
local encounterStart, phaseStart, currentEncounter, currentPhase
local phaseEvents = {
	SPELL_CAST_START = {},
	SPELL_CAST_SUCCESS = {},
	SPELL_AURA_APPLIED = {},
	SPELL_AURA_REMOVED = {},
	UNIT_SPELLCAST_START = {},
	UNIT_SPELLCAST_SUCCEEDED = {},
	UNIT_DIED = {}
}

local simulationTimers = {}
local queuedReminders = {}
local reminderEvents = {
	SPELL_CAST_START = {},
	SPELL_CAST_SUCCESS = {},
	SPELL_AURA_APPLIED = {},
	SPELL_AURA_REMOVED = {},
	UNIT_SPELLCAST_START = {},
	UNIT_SPELLCAST_SUCCEEDED = {},
	UNIT_DIED = {}
}

function LRP:InitializeDisplay()
	LRP.anchors = {
		TEXT = LRP:CreateReminderAnchor("TEXT"),
		SPELL = LRP:CreateReminderAnchor("SPELL")
	}
end

-- Returns encounter info for an encounter ID
-- Can also be used to check if an encounter still exists in data
-- It's possible that there's still reminder data from raids that are not current
-- We don't want to delete that data (safety precaution), but we also do not want to display the reminders
local function GetEncounterInfo(encounterID)
	for _, instanceInfo in ipairs(LRP.timelineData) do
		for _, encounterInfo in ipairs(instanceInfo.encounters) do
			if encounterInfo.id == encounterID then
				return encounterInfo
			end
		end
	end
end

local function DequeueAllReminders()
	for id, timer in pairs(queuedReminders) do
		timer:Cancel()

		queuedReminders[id] = nil
	end
end

-- Hides all active reminders and dequeues all upcoming reminders
local function CleanUp()
	LRP.anchors.TEXT:HideAllReminders()
	LRP.anchors.SPELL:HideAllReminders()

	DequeueAllReminders()
end

local function OnEncounterEnd()
	currentEncounter = nil

	CleanUp()
end

local function QueueReminder(id, reminderData, simulationOffset, simulationEventTime)
	local encounterTime = reminderData.trigger.time
	local duration = reminderData.trigger.duration

	-- This currently only works correctly for reminders relative to pull
	-- For reminder relative to an event, it's comparing the time after the event to the simulation offset
	if simulationEventTime + encounterTime <= simulationOffset then return end -- Don't show reminders that will have already run out (only relevant for simulations)

	local queueTime = math.max(simulationEventTime + encounterTime - simulationOffset - duration, 0)

	queuedReminders[id] = C_Timer.NewTimer(
		queueTime,
		function()
			LRP.anchors[reminderData.display.type]:ShowReminder(id, reminderData, simulationOffset - simulationEventTime)

			queuedReminders[id] = nil
		end
	)
end

-- Offset is used for starting a simulation at arbitrary times in the fight
-- e.g. if the simulation is started at 1:20, then simulation offset is 80
local function OnEncounterStart(encounterID, simulationOffset)
	local encounterInfo = GetEncounterInfo(encounterID)

	if not encounterInfo then return end

	CleanUp() -- Safety precaution

	-- These variables are used to save death data
	encounterStart = GetTime()
	phaseStart = encounterStart
	currentEncounter = encounterID
	currentPhase = 0
	phaseEvents = {
		SPELL_CAST_START = {},
		SPELL_CAST_SUCCESS = {},
		SPELL_AURA_APPLIED = {},
		SPELL_AURA_REMOVED = {},
		UNIT_SPELLCAST_START = {},
		UNIT_SPELLCAST_SUCCEEDED = {},
		UNIT_DIED = {}
	}

	reminderEvents = {
		SPELL_CAST_START = {},
		SPELL_CAST_SUCCESS = {},
		SPELL_AURA_APPLIED = {},
		SPELL_AURA_REMOVED = {},
		UNIT_SPELLCAST_START = {},
		UNIT_SPELLCAST_SUCCEEDED = {},
		UNIT_DIED = {}
	}

	local addonReminders = LiquidRemindersSaved.reminders[encounterID] or {}
	local mrtReminders = LRP.MRTReminders or {}
	local combinedReminders = {addonReminders, mrtReminders}

	-- Fill the reminderEvents table
	-- This table contains the events that have at least one reminder relative to them
	-- When events happen during the fight, they are checked against this table and reminders are queued as needed
	for reminderSource, reminders in ipairs(combinedReminders) do
		for id, reminderData in pairs(reminders) do
			if reminderSource == 2 or LRP:IsRelevantReminder(reminderData) then
				local relativeTo = reminderData.trigger.relativeTo

				if relativeTo then
					local event = relativeTo.event
					local spellID = relativeTo.spellID
					local count = relativeTo.count

					if not reminderEvents[event][spellID] then
						reminderEvents[event][spellID] = {
							count = 0
						}
					end

					if not reminderEvents[event][spellID][count] then
						reminderEvents[event][spellID][count] = {}
					end

					reminderEvents[event][spellID][count][id] = reminderData
				else
					QueueReminder(id, reminderData, simulationOffset or 0, 0)
				end
			end
		end
	end

	-- Fill the phaseEvents table
	-- This table is used to keep track of what phase we are in
	-- This is used to record the timing of the player's death
	for phaseCount, phaseInfo in ipairs(encounterInfo.phases) do
		local event = phaseInfo.event
		local spellID = phaseInfo.spellID
		local count = phaseInfo.count

		if not phaseEvents[event][spellID] then
			phaseEvents[event][spellID] = {
				count = 0
			}
		end

		phaseEvents[event][spellID][count] = phaseCount
	end

	-- Clear death data 10s into an encounter
	-- We don't want to clear it on a boss reset, so 15s is just an arbitrary fight length that we consider not a reset
	C_Timer.After(
		15,
		function()
			if currentEncounter then
				LiquidRemindersSaved.deathData[currentEncounter] = nil
			end
		end
	)
end

local function OnDeath(destGUID)
	if not currentEncounter then return end
	if destGUID ~= UnitGUID("player") then return end

	LiquidRemindersSaved.deathData[currentEncounter] = {
		phase = currentPhase,
		time = GetTime() - phaseStart
	}

	LRP:BuildDeathLine()
end

local function OnEvent(event, spellID, simulationOffset, simulationEventTime)
	local eventTable = reminderEvents[event]
	local phaseTable = phaseEvents[event]

	if not eventTable then return end
	if not spellID then return end

	-- Check if any reminders are relative to this event
	-- If so, queue them
	if eventTable[spellID] then
		eventTable[spellID].count = eventTable[spellID].count + 1

		local reminders = eventTable[spellID][eventTable[spellID].count]

		if reminders then
			for id, reminderData in pairs(reminders) do
				QueueReminder(id, reminderData, simulationOffset or 0, simulationEventTime or 0)
			end
		end
	end

	-- Check if this event starts a new phase (for use in death data)
	if phaseTable[spellID] then
		phaseTable[spellID].count = phaseTable[spellID].count + 1

		local newPhase = phaseTable[spellID][phaseTable[spellID].count]

		-- If this event starts a new phase
		if newPhase then
			currentPhase = newPhase
			phaseStart = GetTime()
		end
	end	
end

function LRP:StartSimulation(instance, encounter, duration, simulationOffset)
	LRP.simulation = true

	LRP.anchors.TEXT:Hide()
	LRP.anchors.SPELL:Hide()

	local timelineData = LRP.timelineData[instance].encounters[encounter]
	local encounterID = timelineData.id

	OnEncounterStart(encounterID, simulationOffset)

	-- Queue all encounter events
	-- If the events happen before the simulation offset, fire them immediately and pass the offset
	for _, eventInfo in ipairs(timelineData.events) do
		if eventInfo.event then
			for _, entry in ipairs(eventInfo.entries) do
				local encounterTime = entry[1]

				table.insert(
					simulationTimers,
					C_Timer.NewTimer(
						math.max(encounterTime - simulationOffset, 0),
						function()
							OnEvent(eventInfo.event, eventInfo.spellID, simulationOffset, encounterTime)
						end
					)
				)
			end
		end
	end

	-- Queue end of encounter
	table.insert(
		simulationTimers,
		C_Timer.NewTimer(
			duration,
			function()
				LRP:StopSimulation()
			end
		)
	)

	LRP:StartSimulateLine(simulationOffset)
end

function LRP:StopSimulation()
	LRP.simulation = false

	-- Dequeue all timers
	for _, timer in pairs(simulationTimers) do
		timer:Cancel()
	end

	simulationTimers = {}

	OnEncounterEnd()
	LRP:StopSimulateLine()
end

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ENCOUNTER_START")
eventFrame:RegisterEvent("ENCOUNTER_END")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:RegisterEvent("UNIT_SPELLCAST_START")
eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

eventFrame:SetScript(
    "OnEvent",
    function(_, event, ...)
		if event == "ENCOUNTER_START" then
			local encounterID = ...

			LRP.window:Hide() -- This also stops any simulation that is running
			OnEncounterStart(encounterID)
		elseif event == "ENCOUNTER_END" then
			OnEncounterEnd()
		elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local _, subEvent, _, _, _, _, _, destGUID, _, _, _, spellID = CombatLogGetCurrentEventInfo()

			if subEvent == "UNIT_DIED" then
				-- If the player died, record the death time for the death lines
				if destGUID == UnitGUID("player") then
					OnDeath(destGUID)
				else
					-- If a creature died, use their npc ID as the spell ID for OnEvent()
					local npcID = LRP:NpcID(destGUID)

					if npcID then
						OnEvent(subEvent, npcID)
					end
				end
			else
				OnEvent(subEvent, spellID)
			end
		elseif event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED" then
			local _, castGUID, spellID = ...

			if not castGUID then return end

			OnEvent(event, spellID)
		end
    end
)