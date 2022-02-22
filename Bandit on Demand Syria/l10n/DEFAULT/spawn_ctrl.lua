-- By winghunter / DCS for MSFS
-- Based on the script from seska with <3 <3 <3



-- editor game state flags
StateFlags = {
    numberOfEnemies =   3001,
    enemyType =         3002,
    restart =           3003, -- auto-restart on/off
    totalEnemies =      3004, -- total existing
    sam =               3005, -- SAMs on/off
    missiles =          3006, -- Missiles on/off
}

local ctl = {}
_distance = 5

EnemyTypes = {
    A10C = 0,
    F16 = 1,
    F18 = 2,
    F15 = 3,
    F14 = 4,
    Su27 = 5,
    Su30 = 6,
    MiG29A = 7,
    MiG31 = 8,
    MiG21 = 9,
}

-- yeah, lua is garbage. writing an iterator just to find a table element by value WTF
EnemyKeys = {
    "A10C",
    "F16",
    "F18",
    "F15",
    "F14",
    "Su27",
    "Su30",
    "MiG29A",
    "MiG31",
    "MiG21",
}

Menus = {
    commandMenu = nil,
    startCmd = nil,
    startRandomCmd = nil,
    autoRestartCmd = nil,
    toggleMissilesboolilbofalsel,
}

EnemyGroups = {
    [EnemyTypes.F16] = {
        description = "F-16s",
        group_id = "Red-F-16"
    },
    [EnemyTypes.F18] = {
        description = "F/A-18Cs",
        group_id = "Red-FA-18C"
    },
    [EnemyTypes.F15] = {
        description = "F-15Cs",
        group_id = "Red-F-15C"
    },
    [EnemyTypes.F14] = {
        description = "F-14Bs",
        group_id = "Red-F-14B"
    },
    [EnemyTypes.Su27] = {
        description = "Su-27s",
        group_id = "Red-Su-27"
    },
    [EnemyTypes.Su30] = {
        description = "Su-30s",
        group_id = "Red-Su-30"
    },
    [EnemyTypes.MiG29A] = {
        description = "MiG-29s",
        group_id = "Red-MiG-29A"
    },
    [EnemyTypes.MiG31] = {
        description = "MiG-31s",
        group_id = "Red-MiG-31"
    },
    [EnemyTypes.MiG21] = {
        description = "MiG-21s",
        group_id = "Red-MiG-21"
    },
    [EnemyTypes.A10C] = {
        description = "A-10Cs",
        group_id = "Red-A-10C"
    }
}

function ctl.send_message(text, displayTime)
    displayTime = displayTime or 5
    
    local msg = {}
    
    msg.displayTime = displayTime
    msg.msgFor = { coa = {'all'}}
    msg.text = text

    mist.message.add(msg)
end



function ctl.setDistance(distance, silent)
    _distance = distance
    if (not silent) then ctl.updatedSettings() end
end

function ctl.getDistanceMeters()
    return mist.utils.NMToMeters(_distance)
end



function ctl.updatedSettings()
    ctl.send_message("Set " .. ctl.getSettings())
    ctl.updateCommandMenu()
end

function ctl.getSettings( ... )
    return ctl.getNumberOfEnemies() .. "× " .. ctl.getEnemyDesc() .. " @ " .. _distance .. "nm"
end



function ctl.setNumEnemies(num, silent)
    local total = ctl.getTotalEnemies()
    trigger.action.setUserFlag(StateFlags.numberOfEnemies, num)
    ctl.setTotalEnemies(total + num)
    if (not silent) then ctl.updatedSettings() end
end

function ctl.setEnemyType(et, silent)
    trigger.action.setUserFlag(StateFlags.enemyType, EnemyTypes[et])
    if (not silent) then ctl.updatedSettings() end
end

function ctl.getEnemyType()
    return trigger.misc.getUserFlag(StateFlags.enemyType)
end

function ctl.getEnemyDesc()
    local missiles = trigger.misc.getUserFlag(StateFlags.missiles)
    if missiles == 1 then
        txt = " Mis"
    else
        txt = " Gun"
    end

    return EnemyGroups[ctl.getEnemyType()].description ..txt
end

function ctl.getNumberOfEnemies()
    return trigger.misc.getUserFlag(StateFlags.numberOfEnemies)
end

function ctl.getTotalEnemies()
    return trigger.misc.getUserFlag(StateFlags.totalEnemies)
end

function ctl.setTotalEnemies(num)
    return trigger.action.setUserFlag(StateFlags.totalEnemies, num)
end


function ctl.spawnGroup(rnd)
    if rnd == true then spawnMode = "RANDOM" else spawnMode = "configured" end

    local numberOfEnemies = ctl.getNumberOfEnemies()
    local enemyType = ctl.getEnemyType()
    local grp = EnemyGroups[enemyType].group_id .. ctl.getMissiles()

    local player = coalition.getPlayers(coalition.side.BLUE)[1]
    local point = Unit.getPoint(player)

    local spawnPoint = mist.projectPoint(point, ctl.getDistanceMeters(), mist.getHeading(player))
    local middlePoint = mist.projectPoint(point, ctl.getDistanceMeters() / 2, mist.getHeading(player))

    ctl.send_message(
        "\nSpawning " .. spawnMode .. " Bandits\n" ..
        "---------------\n" ..
        ctl.getSettings()
    )

    local newData = mist.getGroupData(grp)
    --ctl.log_table(newData)
    local unit = newData.units[1]
        
    local spawnWaypoint = mist.utils.vecToWP(spawnPoint)
    local middleWaypoint = mist.utils.vecToWP(middlePoint)
    local playerPosition = mist.utils.unitToWP(player)
    
    route = mist.getGroupRoute(grp, 'task')
    firstWaypoint = route[1]
    firstWaypoint.x = spawnWaypoint.x
    firstWaypoint.y = spawnWaypoint.y
    firstWaypoint.alt = spawnWaypoint.alt

    playerPosition.task = firstWaypoint.task
    playerPosition.type = firstWaypoint.type
    middleWaypoint.task = firstWaypoint.task
    middleWaypoint.type = firstWaypoint.type

    newData.route = {
        [1] = firstWaypoint,
        [2] = middleWaypoint
    }

    newData.units = {}
    for i = 1, numberOfEnemies do
        newData.units[i] = mist.utils.deepCopy(unit)
    end

    vars = {
        point = spawnPoint,
        gpName = newData.groupName,
        groupData = newData,
        route = newData.route,
        -- doesnt work for air units
        --disperse = true,
        --maxDisp = 50,
        --radius = 100,
        --innerRadius = 5,
        --anyTerrain = true,
        action = 'respawn',
    }
    g = mist.teleportToPoint(vars)
end

function ctl.spawnRandomGroup()
    ctl.setNumEnemies(mist.random(1,4), true)
    ctl.setEnemyType(EnemyKeys[mist.random(1, 10)], true)
    ctl.spawnGroup(true)
    ctl.updateCommandMenu()
end

function ctl.doRestart()
    local current_val = trigger.misc.getUserFlag(StateFlags.restart)
    if current_val == 1 then
        trigger.action.setUserFlag(StateFlags.restart, 0)
    else
        trigger.action.setUserFlag(StateFlags.restart, 1)
    end
end

function ctl.toggleSAMs(bool)
    if bool == false then
        ctl.send_message("SAM sites OFF")
        trigger.action.setUserFlag(StateFlags.sam, 0)
    else
        ctl.send_message("SAM sites ON")
        trigger.action.setUserFlag(StateFlags.sam, 1)
    end
    ctl.updateCommandMenu()
end

function ctl.toggleMissiles(bool)
    if bool == false then
        ctl.send_message("Next Spawn: Missiles OFF. Guns only")
        trigger.action.setUserFlag(StateFlags.missiles, 0)
    else
        ctl.send_message("Next Spawn: Missiles ON")
        trigger.action.setUserFlag(StateFlags.missiles, 1)
    end
    ctl.updateCommandMenu()
end

function ctl.getMissiles()
    local current_val = trigger.misc.getUserFlag(StateFlags.missiles)
    if current_val == 1 then
        return "-M" -- unit groups ending with "-M"
    else
        return ""
    end
end


function ctl.initializeF10Menu()
    --number of enemies
    local countMenu = missionCommands.addSubMenu("Enemy Count")
    local oneCmd = missionCommands.addCommand("1× bandit", countMenu, ctl.setNumEnemies, 1)
    local twoCmd = missionCommands.addCommand("2× bandits", countMenu, ctl.setNumEnemies, 2)
    local threeCmd = missionCommands.addCommand("3× bandits", countMenu, ctl.setNumEnemies, 3)
    local fourCmd = missionCommands.addCommand("4× bandits", countMenu, ctl.setNumEnemies, 4)
  
    --enemy type
    local enemiesMenu = missionCommands.addSubMenu("Enemy Type")
    local f16Cmd = missionCommands.addCommand("F-16C Viper", enemiesMenu, ctl.setEnemyType, "F16")
    local f18Cmd = missionCommands.addCommand("F/A-18C Hornet", enemiesMenu, ctl.setEnemyType, "F18")
    local f15Cmd = missionCommands.addCommand("F-15C Eagle", enemiesMenu, ctl.setEnemyType, "F15")
    local f14Cmd = missionCommands.addCommand("F-14B Tomcat", enemiesMenu, ctl.setEnemyType, "F14")
    local s27Cmd = missionCommands.addCommand("Su-27 Flanker", enemiesMenu, ctl.setEnemyType, "Su27")
    local s30Cmd = missionCommands.addCommand("Su-30 Flanker-G", enemiesMenu, ctl.setEnemyType, "Su30")
    local m29Cmd = missionCommands.addCommand("MiG-29A Fulcrum", enemiesMenu, ctl.setEnemyType, "MiG29A")
    local m31Cmd = missionCommands.addCommand("MiG-31 Foxhound", enemiesMenu, ctl.setEnemyType, "MiG31")
    local m21Cmd = missionCommands.addCommand("MiG-21 Fishbed", enemiesMenu, ctl.setEnemyType, "MiG21")
    local a10Cmd = missionCommands.addCommand("A-10C Warthog", enemiesMenu, ctl.setEnemyType, "A10C")

    --distance
    local distanceMenu = missionCommands.addSubMenu("Spawn Distance")
    local cmdBehind  = missionCommands.addCommand("behind me", distanceMenu, ctl.setDistance, -1)
    local cmd1  = missionCommands.addCommand("1 mile", distanceMenu, ctl.setDistance, 1)
    local cmd5  = missionCommands.addCommand("5 miles", distanceMenu, ctl.setDistance, 5)
    local cmd10 = missionCommands.addCommand("10 miles", distanceMenu, ctl.setDistance, 10)
    local cmd25 = missionCommands.addCommand("25 miles", distanceMenu, ctl.setDistance, 25)
    local cmd50 = missionCommands.addCommand("50 miles", distanceMenu, ctl.setDistance, 50)
    local cmd50 = missionCommands.addCommand("75 miles", distanceMenu, ctl.setDistance, 75)
    local cmd75 = missionCommands.addCommand("100 miles", distanceMenu, ctl.setDistance, 100)
    local cmd100 = missionCommands.addCommand("150 miles", distanceMenu, ctl.setDistance, 150)
    
    -- commands
    commandMenu = missionCommands.addSubMenu("Commands")
    ctl.updateCommandMenu()
    
    ctl.send_message(
        "Use F10 Menu or VoiceAttack\n" ..
        "=======================\n" ..
        "1. Select number of bandits\n" ..
        "2. Select bandit aircraft type\n" ..
        "3. Select spawn distance\n" ..
        "4. Use Command menu to 'Spawn Bandits'\n" ..
        "    Default Bandits: " .. ctl.getSettings() .. "\n" ..
        "    Default SAM sites: OFF\n" ..
        "    Default Missiles: OFF\n" ..
        "=======================\n",
        10
    )
end

function ctl.updateCommandMenu()
    -- remove previous
    if (Menus.startCmd) then missionCommands.removeItem(Menus.startCmd) end
    if (Menus.startRandomCmd) then missionCommands.removeItem(Menus.startRandomCmd) end
    if (Menus.autoRestartCmd) then missionCommands.removeItem(Menus.autoRestartCmd) end
    if (Menus.SAMsCmdOn) then missionCommands.removeItem(Menus.SAMsCmdOn) end
    if (Menus.SAMsCmdOff) then missionCommands.removeItem(Menus.SAMsCmdOff) end
    if (Menus.MissilesCmdOff) then missionCommands.removeItem(Menus.MissilesCmdOff) end
    if (Menus.MissilesCmdOn) then missionCommands.removeItem(Menus.MissilesCmdOn) end

    Menus.startCmd = missionCommands.addCommand("Spawn " .. ctl.getSettings(), commandMenu, ctl.spawnGroup, {})
    Menus.startRandomCmd = missionCommands.addCommand("Spawn Random Bandits", commandMenu, ctl.spawnRandomGroup, {})
    
    -- Disabled, accidential restarts
    --Menus.autoRestartCmd = missionCommands.addCommand("Restart", commandMenu, ctl.doRestart, {})

    -- MISSILES ON/OFF
    local missiles = trigger.misc.getUserFlag(StateFlags.missiles)
    txt1 = ""
    txt2 = ""
    if missiles == 0 then txt1 = "◀" else txt2 = "◀" end
    Menus.MissilesCmdOff = missionCommands.addCommand("Turn MISSILES OFF" .. txt1, commandMenu, ctl.toggleMissiles, false)
    Menus.MissilesCmdOn = missionCommands.addCommand("Turn MISSILES ON" .. txt2, commandMenu, ctl.toggleMissiles, true)

    txt1 = ""
    txt2 = ""
    -- SAM ON / OFF
    local sam = trigger.misc.getUserFlag(StateFlags.sam)
    if sam == 0 then txt1 = "◀" else txt2 = "◀" end
    Menus.SAMsCmdOff = missionCommands.addCommand("Turn SAM OFF" .. txt1, commandMenu, ctl.toggleSAMs, false)
    Menus.SAMsCmdOn = missionCommands.addCommand("Turn SAM ON" .. txt2, commandMenu, ctl.toggleSAMs, true)
end

-- set defaults
ctl.setNumEnemies(2, true)
ctl.setEnemyType("MiG21", true)
ctl.setDistance(10, true)

-- setup menu items in F10
ctl.initializeF10Menu()








--- Utils ------------------------------------------------------------------------------------------

function serializeTable(val, name, skipnewlines, depth)
    skipnewlines = skipnewlines or false
    depth = depth or 0

    local tmp = string.rep(" ", depth)

    if name then tmp = tmp .. name .. " = " end

    if type(val) == "table" then
        tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

        for k, v in pairs(val) do
            tmp =  tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
        end

        tmp = tmp .. string.rep(" ", depth) .. "}"
    elseif type(val) == "number" then
        tmp = tmp .. tostring(val)
    elseif type(val) == "string" then
        tmp = tmp .. string.format("%q", val)
    elseif type(val) == "boolean" then
        tmp = tmp .. (val and "true" or "false")
    else
        tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
    end

    return tmp
end

function ctl.msg_table(table)
    ctl.send_message(
        serializeTable(table)
    )
end

function ctl.log_table(table)
    mist.log:warn(table)
end
