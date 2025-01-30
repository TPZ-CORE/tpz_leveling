# TPZ-CORE Leveling

## Requirements

1. TPZ-Core: https://github.com/TPZ-CORE/tpz_core
2. TPZ-Characters: https://github.com/TPZ-CORE/tpz_characters
3. TPZ-Inventory : https://github.com/TPZ-CORE/tpz_inventory
   
# Installation

1. When opening the zip file, open `tpz_leveling-main` directory folder and inside there will be another directory folder which is called as `tpz_leveling`, this directory folder is the one that should be exported to your resources (The folder which contains `fxmanifest.lua`).

2. Add `ensure tpz_leveling` after the **REQUIREMENTS** in the resources.cfg or server.cfg, depends where your scripts are located.

# Development

## Get the level and experience values of a leveling type:

```lua
-- Level Types: hunting, fishing, lumberjack, mining, farming.
local LevelData = exports.tpz_leveling:GetLevelTypeExperienceData('mining')
print(LevelData.level, LevelData.experience)
```

## Add level experience on a leveling type.

```lua

-- Level Types: hunting, fishing, lumberjack, mining, farming.
-- If targetSource set to nil, it will get the player source, the targetSource is used only if you want to add level experience
-- on another player and not the one which the event is triggered.

TriggerServerEvent("tpz_leveling:AddLevelExperience", <targetSource>, <levelType>, <experienceValue>) -- Client Side
TriggerEvent("tpz_leveling:AddLevelExperience", <targetSource>, <levelType>, experienceValue>) -- Server Side

```
