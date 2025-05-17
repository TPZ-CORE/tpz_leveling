ConnectedPlayers = {}

-----------------------------------------------------------
--[[ General Events  ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    ConnectedPlayers = {}

end)

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

-- When first joining the game, we request the player to be added into the list
-- The following list handles the players and their metabolism correctly.
function RegisterConnectedPlayer(source, identifier, charidentifier, data)
    local _source         = source

    ConnectedPlayers[_source]                      = {}
    ConnectedPlayers[_source]['source']            = _source

    ConnectedPlayers[_source]['identifier']        = identifier
    ConnectedPlayers[_source]['charidentifier']    = charidentifier

    ConnectedPlayers[_source]['lumberjack']        = { level = data['lumberjack'].level or 1, experience = data['lumberjack'].experience or 0 }
    ConnectedPlayers[_source]['hunting']           = { level = data['hunting'].level or 1,    experience = data['hunting'].experience or 0    }
    ConnectedPlayers[_source]['farming']           = { level = data['farming'].level or 1,    experience = data['farming'].experience or 0    }
    ConnectedPlayers[_source]['mining']            = { level = data['mining'].level or 1,     experience = data['mining'].experience or 0     }
    ConnectedPlayers[_source]['fishing']           = { level = data['fishing'].level or 1,    experience = data['fishing'].experience or 0    }

end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

-- Save player leveling progress.
AddEventHandler('playerDropped', function (reason)
    local _source = source

    if ConnectedPlayers[_source] == nil then
        return
    end

    local playerData = ConnectedPlayers[_source]

    local LevelingParameters = { 
        ['lumberjack'] = { level = playerData['lumberjack'].level, experience = playerData['lumberjack'].experience },
        ['hunting']    = { level = playerData['hunting'].level,    experience = playerData['hunting'].experience    },
        ['farming']    = { level = playerData['farming'].level,    experience = playerData['farming'].experience    },
        ['mining']     = { level = playerData['mining'].level,     experience = playerData['mining'].experience     },
        ['fishing']    = { level = playerData['fishing'].level,    experience = playerData['fishing'].experience    },
    }

    local UpdateParameters = { 
        ['identifier']      = playerData.identifier, 
        ['charidentifier']  = playerData.charidentifier, 
        ['leveling_status'] = json.encode(LevelingParameters)
    }

    exports.ghmattimysql:execute("UPDATE `characters` SET `leveling_status` = @leveling_status WHERE `identifier` = @identifier AND `charidentifier` = @charidentifier", UpdateParameters)

    ConnectedPlayers[_source] = nil
end)
