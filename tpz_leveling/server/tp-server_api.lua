exports('getAPI', function()
    local self = {}

    self.AddPlayerLevelExperience = function(source, actionType, value)
        AddPlayerLevelExperience(source, actionType, value)
    end
    
    self.AddPlayerLevel = function(source, actionType, value)
        AddPlayerLevel(source, actionType, value)
    end
    
    self.GetLevelExperience = function(source, actionType)
        GetLevelExperience(source, actionType)
    end

    return self
end)
