
local LevelingData = {}

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

GetLevelTypeExperienceData = function(levelType)

    if LevelingData[levelType] == nil then
        return { level = 1, experience = 0}
    end
    
	local level      = LevelingData[levelType].level
	local experience = LevelingData[levelType].experience

	return { level = level, experience = experience }
end
-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

-- @tpz_core:isPlayerReady : After selecting a character, we request the player leveling data.
AddEventHandler("tpz_core:isPlayerReady", function()
    Wait(2000)

    -- If devmode is enabled, we are not running the following code since it already does.
    if Config.DevMode then
        return
    end

	TriggerServerEvent("tpz_leveling:server:requestPlayerData")

end)

RegisterNetEvent("tpz_leveling:client:playerDataLoaded")
AddEventHandler("tpz_leveling:client:playerDataLoaded", function ()
	-- todo - nothing (Can be used for HUD)
end)

RegisterNetEvent("tpz_leveling:client:registerPlayerData")
AddEventHandler("tpz_leveling:client:registerPlayerData", function(data)
    LevelingData = data
	TriggerEvent("tpz_leveling:playerDataLoaded")
end)

if Config.DevMode then
	Citizen.CreateThread(function ()
		Wait(2000)
		TriggerServerEvent("tpz_leveling:server:requestPlayerData")
	end)
end

-----------------------------------------------------------
--[[ General Events ]]--
-----------------------------------------------------------

RegisterNetEvent("tpz_leveling:client:updateByActionType")
AddEventHandler("tpz_leveling:client:updateByActionType", function(actionType, param1, param2)

    if LevelingData[actionType] == nil then
        return
    end

    LevelingData[actionType].level      = param1
    LevelingData[actionType].experience = param2
end)
