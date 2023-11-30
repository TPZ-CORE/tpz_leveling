
local DevMode      = true

local LevelingData = {
	
    ['lumberjack'] = { level = 1, experience = 0 },
    ['hunting']    = { level = 1, experience = 0 },
    ['farming']    = { level = 1, experience = 0 },
    ['mining']     = { level = 1, experience = 0 },
    ['fishing']    = { level = 1, experience = 0 },

}

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

-- @tpz_core:isPlayerReady : After selecting a character, we request the player leveling data.
AddEventHandler("tpz_core:isPlayerReady", function()
    Wait(2000)

    -- If devmode is enabled, we are not running the following code since it already does.
    if DevMode then
        return
    end

	TriggerServerEvent("tpz_leveling:requestPlayerLevelingData")

end)

RegisterNetEvent("tpz_leveling:isLoaded")
AddEventHandler("tpz_leveling:isLoaded", function ()
	-- todo - nothing (Can be used for HUD)
end)

RegisterNetEvent("tpz_leveling:registerPlayerLevelingData")
AddEventHandler("tpz_leveling:registerPlayerLevelingData", function(data)

    LevelingData['lumberjack'] = { level = data['lumberjack'].level, experience = data['lumberjack'].experience }
    LevelingData['hunting']    = { level = data['hunting'].level,    experience = data['hunting'].experience    }
    LevelingData['farming']    = { level = data['farming'].level,    experience = data['farming'].experience    }
    LevelingData['mining']     = { level = data['mining'].level,     experience = data['mining'].experience     }
    LevelingData['fishing']    = { level = data['fishing'].level,    experience = data['fishing'].experience    }

	TriggerEvent("tpz_leveling:isLoaded")
end)

if DevMode then

	Citizen.CreateThread(function ()
		Wait(2000)

		TriggerServerEvent("tpz_leveling:requestPlayerLevelingData")

	end)

end

-----------------------------------------------------------
--[[ General Events ]]--
-----------------------------------------------------------

RegisterNetEvent("tpz_leveling:updatePlayerLevelExperienceType")
AddEventHandler("tpz_leveling:updatePlayerLevelExperienceType", function(levelType, level, experience)
	
    LevelingData[levelType].level      = level
	LevelingData[levelType].experience = experience
end)

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

GetLevelTypeExperienceData = function(levelType)

	local level      = LevelingData[levelType].level
	local experience = LevelingData[levelType].experience

	return { level = level, experience = experience }
end

AddLevelExperience = function(targetSource, levelType, value)
	TriggerServerEvent("tpz_leveling:AddLevelExperience", targetSource, levelType, value)
end