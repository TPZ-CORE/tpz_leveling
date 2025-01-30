


-- @param actionType : The required type to retrieve the data such as level and experience.
-- Example: local level, experience = tpz_leveling:GetLevelTypeExperienceData('mining')
exports('GetLevelTypeExperienceData', function(actionType)
    return GetLevelTypeExperienceData(actionType)
end)


