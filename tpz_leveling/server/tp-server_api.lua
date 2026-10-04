exports('getAPI', function()
    local self = {}

    self.AddPlayerLevelExperience = function(source, actionType, value)
        AddPlayerLevelExperience(source, actionType, value)
    end
    
    self.AddPlayerLevel = function(source, actionType, value)
        AddPlayerLevel(source, actionType, value)
    end
    
    self.GetLevelExperience = function(source, actionType)
        return GetLevelExperience(source, actionType)
    end
        
    self.GetPlayerData = function(source)
        if ConnectedPlayers[source] == nil then 
            return nil
        end

        return ConnectedPlayers[source]
    end
        
    return self
end)

