local TPZ     = {}

TriggerEvent("getTPZCore", function(cb) TPZ = cb end)

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

AddEventHandler('playerDropped', function (reason)
    local _source = source

    if ConnectedPlayers[_source] then

        local playerData = ConnectedPlayers[_source]

        local LevelingParameters = { 
            ['lumberjack'] = { level = playerData['lumberjack'].level, experience = playerData['lumberjack'].experience },
            ['hunting']    = { level = playerData['hunting'].level,    experience = playerData['hunting'].experience    },
            ['farming']    = { level = playerData['farming'].level,    experience = playerData['farming'].experience    },
            ['mining']     = { level = playerData['mining'].level,     experience = playerData['mining'].experience     },
            ['fishing']    = { level = playerData['fishing'].level,    experience = playerData['fishing'].experience    },
        }

        local UpdateParameters = { ['charidentifier'] = playerData.charidentifier , ['leveling_status'] = json.encode(LevelingParameters)}

        exports.ghmattimysql:execute("UPDATE characters SET leveling_status = @leveling_status WHERE charidentifier = @charidentifier", UpdateParameters)

        ConnectedPlayers[_source] = nil
    end

end)

-----------------------------------------------------------
--[[ General Events  ]]--
-----------------------------------------------------------

RegisterServerEvent("tpz_leveling:requestPlayerLevelingData")
AddEventHandler("tpz_leveling:requestPlayerLevelingData", function()
    local _source         = source

    local xPlayer         = TPZ.GetPlayer(_source)

    while not xPlayer.loaded() do
        Wait(1000)
    end

    local identifier      = xPlayer.getIdentifier()
    local charidentifier  = xPlayer.getCharacterIdentifier()
    local playerName      =  GetPlayerName(_source)
    
    local Parameters      = { ['charidentifier'] = charidentifier }

    exports.ghmattimysql:execute('SELECT leveling_status FROM characters WHERE charidentifier = @charidentifier', Parameters, function(result)
        
        if result[1] then 

            local data = json.decode(result[1].leveling_status)

            local dataLength = GetTableLength(data)

            local LevelingParameters = { 
                ['lumberjack'] = { level = 1, experience = 0 },
                ['hunting']    = { level = 1, experience = 0 },
                ['farming']    = { level = 1, experience = 0 },
                ['mining']     = { level = 1, experience = 0 },
                ['fishing']    = { level = 1, experience = 0 },
            }

            if dataLength ~= 0 then
                LevelingParameters['lumberjack'] = { level = data['lumberjack'].level, experience = data['lumberjack'].experience }
                LevelingParameters['hunting']    = { level = data['hunting'].level,    experience = data['hunting'].experience    }
                LevelingParameters['farming']    = { level = data['farming'].level,    experience = data['farming'].experience    }
                LevelingParameters['mining']     = { level = data['mining'].level,     experience = data['mining'].experience     }
                LevelingParameters['fishing']    = { level = data['fishing'].level,    experience = data['fishing'].experience    }
            end

            -- We are registering the connected player with its metabolism data to be used and updated properly.
            RegisterConnectedPlayer(_source, identifier, charidentifier, LevelingParameters)

            TriggerClientEvent("tpz_leveling:registerPlayerLevelingData", _source, LevelingParameters )

            --print("[TPZ-CORE Leveling] Successfully loaded user " .. identifier .. " (" .. playerName .. ")")


        else
            print("[Error]: `leveling_status` column does not exist on `characters` table.")
        end
        
    end)

end)


RegisterServerEvent("tpz_leveling:AddLevelExperience")
AddEventHandler("tpz_leveling:AddLevelExperience", function(targetSource, levelType, value)

	local _source = source

    if targetSource then
        _source = tonumber(targetSource)
    end

    local level, experience = UpdateLevelExperience(_source, levelType, value)

    TriggerClientEvent("tpz_leveling:updatePlayerLevelExperienceType", _source, levelType, level, experience)

end)

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

UpdateLevelExperience = function(source, levelType, value)
    local _source    = source
    local levelData  = ConnectedPlayers[_source][levelType]

    levelData.experience = levelData.experience + value

    if levelData.experience == 1000 then
        levelData.experience = 0

        levelData.level = levelData.level + 1

    elseif levelData.experience > 1000 then
        levelData.experience = 0

        levelData.level = levelData.level + 1

    end

    return levelData.level, levelData.experience


end

-- @GetTableLength returns the length of a table.
function GetTableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end