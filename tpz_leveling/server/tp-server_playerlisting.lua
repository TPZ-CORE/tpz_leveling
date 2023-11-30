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

    ConnectedPlayers[_source]['lumberjack']        = { level = data['lumberjack'].level, experience = data['lumberjack'].experience }
    ConnectedPlayers[_source]['hunting']           = { level = data['hunting'].level,    experience = data['hunting'].experience    }
    ConnectedPlayers[_source]['farming']           = { level = data['farming'].level,    experience = data['farming'].experience    }
    ConnectedPlayers[_source]['mining']            = { level = data['mining'].level,     experience = data['mining'].experience     }
    ConnectedPlayers[_source]['fishing']           = { level = data['fishing'].level,    experience = data['fishing'].experience    }

end

GetConnectedPlayers = function()
    local data = { list = {}, players = 0 }

    local finished = false

    for index, player in pairs (ConnectedPlayers) do

        data.players = data.players + 1

        table.insert(data.list, player)

        if next(ConnectedPlayers, index) == nil then
            finished = true
        end

    end

    while not finished do
        Wait(50)
    end

    return data
end