# TPZ-CORE Leveling

## Get the level and experience values of a leveling type:

```lua
-- Level Types: hunting, fishing, lumberjack, mining, farming.
local data = exports.tpz_leveling:GetLevelTypeExperienceData(<levelType>)

print(data.level, data.experience)
```

## Add level experience on a leveling type.

```lua

-- Level Types: hunting, fishing, lumberjack, mining, farming.
-- If targetSource set to nil, it will get the player source, the targetSource is used only if you want to add level experience
-- on another player and not the one which the event is triggered.

TriggerServerEvent("tpz_leveling:AddLevelExperience", <targetSource>, <levelType>, <experienceValue>) -- Client Side
TriggerEvent("tpz_leveling:AddLevelExperience", <targetSource>, <levelType>, experienceValue>) -- Server Side

```
