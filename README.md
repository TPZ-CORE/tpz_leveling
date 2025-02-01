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

## Server Side Development API

### Get API Object

```lua
local LevelingAPI = exports.tpz_leveling:getAPI()
```

```lua

-- Level Types: hunting, fishing, lumberjack, mining, farming.

LevelingAPI.AddPlayerLevelExperience(<targetSource>, <levelType>, <experienceValue>)
LevelingAPI.AddPlayerLevel(<targetSource>, <levelType>, <levelValue>)

local LevelData = LevelingAPI.GetLevelExperience(<targetSource>, <levelType>)
print(LevelData.level, LevelData.experience)
```

## Events

The specified event below is triggered when player **leveling** data loaded after a player is selecting a character.

```lua
AddEventHandler("tpz_leveling:playerDataLoaded", function ()
	-- todo - nothing (Can be used for HUD)
end)
```
