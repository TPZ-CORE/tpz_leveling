local TPZ = {}

TriggerEvent("getTPZCore", function(cb) TPZ = cb end)

-----------------------------------------------------------
--[[ Local Functions  ]]--
-----------------------------------------------------------

-- @GetTableLength returns the length of a table.
local function GetTableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

-- Add player experience by the actionType.
AddPlayerLevelExperience = function(source, actionType, value)
    local _source    = source
    local levelData  = ConnectedPlayers[_source][actionType]

    levelData.experience = levelData.experience + value

    if levelData.experience >= Config.RequiredLevelExperience then
        levelData.experience = 0

        levelData.level = levelData.level + 1
    end

    TriggerClientEvent("tpz_leveling:client:updateByActionType", _source, levelData.level, levelData.experience )
end

-- Add player level by the actionType.
AddPlayerLevel = function(source, actionType, value)
    local _source    = source
    local levelData  = ConnectedPlayers[_source][actionType]

    levelData.level = levelData.level + value

    TriggerClientEvent("tpz_leveling:client:updateByActionType", _source, levelData.level, levelData.experience )
end

-- Get player level and experience by the actionType.
GetLevelExperience = function(source, actionType)
    local _source = source

    if ConnectedPlayers[_source] == nil or ConnectedPlayers[_source] and ConnectedPlayers[_source][actionType] == nilthen
        return 1, 0
    end

    return ConnectedPlayers[_source][actionType]
end

-----------------------------------------------------------
--[[ General Events  ]]--
-----------------------------------------------------------

RegisterServerEvent("tpz_leveling:server:requestPlayerData")
AddEventHandler("tpz_leveling:server:requestPlayerData", function()
    local _source = source
    local xPlayer = TPZ.GetPlayer(_source)

    while not xPlayer.loaded() do
        Wait(1000)
    end

    local identifier     = xPlayer.getIdentifier()
    local charidentifier = xPlayer.getCharacterIdentifier()
    local playerName     = GetPlayerName(_source)
    
    exports.ghmattimysql:execute('SELECT * FROM `characters` WHERE `identifier` = @identifier AND `charidentifier` = @charidentifier', { 
        ['identifier']     = identifier,  
        ['charidentifier'] = charidentifier 
    }, function(result)

        local LevelingData = {}
        
        if result[1] and result[1].leveling_status then
            LevelingData = json.decode(result[1].leveling_status)
        end

        -- We are registering the connected player with its metabolism data to be used and updated properly.
        RegisterConnectedPlayer(_source, identifier, charidentifier, LevelingParameters)
        TriggerClientEvent("tpz_leveling:client:registerPlayerData", _source, LevelingParameters )
    end)

end)
