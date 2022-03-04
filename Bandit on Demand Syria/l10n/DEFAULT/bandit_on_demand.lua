-- Bandit on Demand™ - spawn bandits with your voice, anywhere, any map.
-- By winghunter
-- github https://github.com/fyyyyy/Bandit-on-Demand
-- Discussion thread https://forums.eagle.ru/topic/293643-bandit-on-demand-spawn-bandits-with-your-voice-anywhere-any-map-bfmbvr/
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
_angels = -1


function log_table(table, name)
    if name then
        name = name .. ': '
    else
        name = ''
    end
    mist.log:warn(name .. mist.utils.oneLineSerialize(table))
end


SkillLevels = {
    EXEL = "Excellent",
    HIGH = "High",
    GOOD = "Good",
    AVRG = "Average",
    RAND = "Random",
}

SkillDesc = {
    Excellent = "A+",
    High = "B+",
    Good = "C+",
    Average = "D+",
    Random = "RND",
}

_skill = SkillLevels.EXEL


EnemyTypes = {
    A10C = 1,
    F16 = 2,
    F18 = 3,
    F15 = 4,
    F14 = 5,
    Su27 = 6,
    Su30 = 7,
    MiG29A = 8,
    MiG31 = 9,
    MiG21 = 10,
    Bf109 = 11,
    AJS37 = 12,
    F5E = 13,
    Fw190 = 14,
    I16 = 15,
    MiG15 = 16,
    MiG19 = 17,
    Mosquito = 18,
    P51D = 19,
    Spitfire = 20,
}

EnemyKeys = {}
-- reverse keys and values for inverse lookup
for i,v in pairs(EnemyTypes) do
    EnemyKeys[v] = i
end


Menus = {
    commandMenu = nil,
    startCmd = nil,
    startRandomCmd = nil,
    autoRestartCmd = nil,
    MissilesCmdOn = nil,
    MissilesCmdOff = nil,
}


-- If bandits dont have a missile configuration, just set the 
-- same group name for missiles_id and guns_id
EnemyGroups = {
    [EnemyKeys[1]] = {
        description = "A-10C's",
        guns_id = "Red-A-10C",
        missiles_id = "Red-A-10C-M",    
    },
    [EnemyKeys[2]] = {
        description = "F-16's",
        guns_id = "Red-F-16",
        missiles_id = "Red-F-16-M",    
    },
    [EnemyKeys[3]] = {
        description = "F/A-18C's",
        guns_id = "Red-FA-18C",
        missiles_id = "Red-FA-18C-M",    
    },
    [EnemyKeys[4]] = {
        description = "F-15C's",
        guns_id = "Red-F-15C",
        missiles_id = "Red-F-15C-M",    
    },
    [EnemyKeys[5]] = {
        description = "F-14B's",
        guns_id = "Red-F-14B",
        missiles_id = "Red-F-14B-M",    
    },
    [EnemyKeys[6]] = {
        description = "Su-27's",
        guns_id = "Red-Su-27",
        missiles_id = "Red-Su-27-M",    
    },
    [EnemyKeys[7]] = {
        description = "Su-30's",
        guns_id = "Red-Su-30",
        missiles_id = "Red-Su-30-M",    
    },
    [EnemyKeys[8]] = {
        description = "MiG-29's",
        guns_id = "Red-MiG-29A",
        missiles_id = "Red-MiG-29A-M",    
    },
    [EnemyKeys[9]] = {
        description = "MiG-31's",
        guns_id = "Red-MiG-31",
        missiles_id = "Red-MiG-31-M",    
    },
    [EnemyKeys[10]] = {
        description = "MiG-21's",
        guns_id = "Red-MiG-21",
        missiles_id = "Red-MiG-21-M",    
    },
    [EnemyKeys[11]] = {
        description = "Bf-109's",
        guns_id = "Red-Bf-109",
        missiles_id = "Red-Bf-109",    
    },
    [EnemyKeys[12]] = {
        description = "AJS 37's",
        guns_id = "Red-AJS37",
        missiles_id = "Red-AJS37-M",    
    },
    [EnemyKeys[13]] = {
        description = "F-5's",
        guns_id = "Red-F5-E",
        missiles_id = "Red-F5-E-M",    
    },
    [EnemyKeys[14]] = {
        description = "Fw-190's",
        guns_id = "Red-Fw-190",
        missiles_id = "Red-Fw-190",    
    },
    [EnemyKeys[15]] = {
        description = "I-16's",
        guns_id = "Red-I-16",
        missiles_id = "Red-I-16",    
    },
    [EnemyKeys[16]] = {
        description = "MiG-15's",
        guns_id = "Red-Mig-15",
        missiles_id = "Red-Mig-15",    
    },
    [EnemyKeys[17]] = {
        description = "MiG-19's",
        guns_id = "Red-Mig-19",
        missiles_id = "Red-Mig-19-M",    
    },    
    [EnemyKeys[18]] = {
        description = "Mosquito's",
        guns_id = "Red-Mosquito",
        missiles_id = "Red-Mosquito",    
    },    
    [EnemyKeys[19]] = {
        description = "P-51D's",
        guns_id = "Red-P51",
        missiles_id = "Red-P51",    
    },    
    [EnemyKeys[20]] = {
        description = "Spitfire's",
        guns_id = "Red-Spitfire",
        missiles_id = "Red-Spitfire",    
    },    
}

function ctl.send_message(text, displayTime)
    displayTime = displayTime or 5
    
    local msg = {}
    
    msg.displayTime = displayTime
    msg.msgFor = { coa = {'all'}}
    msg.text = text

    mist.message.add(msg)
end




function ctl.getPlayerGroupData(unit)
    local playerGroup = Unit.getGroup(unit)
    -- log_table(playerGroup, "playerGroup")
    playerGroupData = mist.DBs.groupsById[playerGroup.id_]
    return playerGroupData
end

local MarkHandler = {}
-- remember in case player dies but wants to respawn
local player = coalition.getPlayers(coalition.side.BLUE)[1]
local lastPlayerGroupName = ctl.getPlayerGroupData(player).groupName

function MarkHandler:onEvent(event)
    if event.id == 25 then --marker added
        local playerGroupData = nil

        --if player dead, no initiator
        if event.initiator then
            playerGroupData = ctl.getPlayerGroupData(event.initiator)
        end

        if not playerGroupData then
            if lastPlayerGroupName then
                playerGroupData = mist.getGroupData(lastPlayerGroupName)
            else
                ctl.send_message("playerGroupData not found!")
                return
            end
        end

        -- prevent CTD when skill is "Client"
        playerGroupData.units[1].skill = "Player"

        lastPlayerGroupName = playerGroupData.groupName
        
        local pos = mist.utils.deepCopy(event.pos)
        local alt = playerGroupData.units[1].alt
        if pos.y < alt then pos.y = alt else pos.y = pos.y + 300 end

        ctl.teleport(playerGroupData, lastPlayerGroupName, pos)
        log_table('Respawned ' .. playerGroupData.groupName)
        ctl.send_message('Respawned ' .. playerGroupData.groupName)
    end       
end
world.addEventHandler(MarkHandler)



function ctl.setDistance(distance, silent)
    _distance = distance
    if (not silent) then ctl.updatedSettings() end
end

function ctl.getDistanceMeters()
    return mist.utils.NMToMeters(_distance)
end


function ctl.setAngels(angels, silent)
    _angels = angels
    if (not silent) then ctl.updatedSettings() end
end

function ctl.getAngels()
    if _angels > -1 then
        return _angels .. 'k'
    else
        return "eq"
    end
end


function ctl.setSkillLevel(skill, silent)
    _skill = skill
    if (not silent) then ctl.updatedSettings() end
end

function ctl.getSkillDesc(s)
    return SkillDesc[s or _skill]
end



function ctl.updatedSettings()
    ctl.send_message("Set " .. ctl.getSettings(), 2)
    ctl.updateCommandMenu()
end

function ctl.getSettings( ... )
    return ctl.getNumberOfEnemies() .. "× " .. ctl.getSkillDesc() .. ' ' .. ctl.getEnemyDesc() .. " @ " .. _distance .. "nm alt:" .. ctl.getAngels()
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
    et = trigger.misc.getUserFlag(StateFlags.enemyType)
    enemyType = EnemyKeys[et]
    if (enemyType) then
        return enemyType
    else
        return "Error: " .. et
    end
end

function ctl.getEnemyDesc()
    local missiles = trigger.misc.getUserFlag(StateFlags.missiles)
    if missiles == 1 then
        txt = " Mis"
    else
        txt = " Gun"
    end

    enemyType = ctl.getEnemyType()
    if (enemyType and EnemyGroups[enemyType]) then
        return EnemyGroups[enemyType].description ..txt
    else
        return "Error: " .. enemyType
    end
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

    local grp = ctl.getBanditGroupName()
    if (not grp) then return end

    local player = coalition.getPlayers(coalition.side.BLUE)[1]
    local point = Unit.getPoint(player)

    local spawnPoint = mist.projectPoint(point, ctl.getDistanceMeters(), mist.getHeading(player))
    -- direct AI to meet half way between spawnPoint and player aircraft
    local middlePoint = mist.projectPoint(point, ctl.getDistanceMeters() / 2, mist.getHeading(player))

    ctl.send_message(
        "\nSpawning " .. spawnMode .. " Bandits\n" ..
        "---------------\n" ..
        ctl.getSettings(),
        2
    )

    local newData = mist.getGroupData(grp)
    if (not newData) then
        ctl.send_message("Error: group not in editor: " .. grp)
        return
    end

    local unit = newData.units[1]
    unit.skill = _skill
    log_table(newData)
    
    local spawnWaypoint = mist.utils.vecToWP(spawnPoint)
    local middleWaypoint = mist.utils.vecToWP(middlePoint)
    --alternative: direct AI to player position
    --local playerPosition = mist.utils.unitToWP(player)
    
    route = mist.getGroupRoute(grp, 'task')
    firstWaypoint = route[1]
    firstWaypoint.x = spawnWaypoint.x
    firstWaypoint.y = spawnWaypoint.y

    if _angels > -1 then
        local altInMeters = mist.utils.feetToMeters(_angels * 1000)
        spawnPoint.y = altInMeters
        firstWaypoint.alt = altInMeters
        middleWaypoint.alt = altInMeters
        unit.alt = altInMeters
    end

    --playerPosition.task = firstWaypoint.task
    --playerPosition.type = firstWaypoint.type
    middleWaypoint.task = firstWaypoint.task
    middleWaypoint.type = firstWaypoint.type

    newData.route = {
        [1] = firstWaypoint,
        [2] = middleWaypoint
    }

    -- Spawn enemies as individuals rather than inside a group. This improves AI behaviour in a guns/IR missiles dogfight.
    -- The group AI works OK with radar missiles, but not with guns or IR. As only one aircraft in the group will get on your six.
    local spawnAsGroup = false

    if (spawnAsGroup) then
        newData.units = {}
        for i = 1, numberOfEnemies do
            newData.units[i] = mist.utils.deepCopy(unit)
            newData.units[i].unitName = string.sub(grp, 5) .. '@' .. _skill .. '-' .. i
        end
        ctl.teleport(newData, newData.groupName, spawnPoint)
    else -- spawn each aircraft as individual group - improves AI behaviour for dogfights
        newData.units = {[1] = unit}
        point = mist.utils.deepCopy(spawnPoint)
        for i = 1, numberOfEnemies do
            singleUnit = mist.utils.deepCopy(newData)
            singleUnit.units[1].unitName = string.sub(grp, 5) .. '@' .. _skill .. '-' .. i
            ctl.teleport(singleUnit, singleUnit.groupName .. '_' .. i, ctl.disperseUnit(point, i * 50))
        end
    end
end

function ctl.disperseUnit( point , offset)
    point.x = point.x + (offset)
    point.z = point.z + (offset)
    point.y = point.y + (offset / 2) -- altitude
    return point
end

function ctl.teleport( group, groupName , spawnPoint)
    vars = {
        point = spawnPoint,
        gpName = groupName,
        groupData = group,
        route = group.route,
        action = 'respawn',
    }
    g = mist.teleportToPoint(vars)
    -- log_table(g)
end

function ctl.spawnRandomGroup()
    ctl.setNumEnemies(mist.random(1,4), true)
    ctl.setEnemyType(EnemyKeys[mist.random(1, 20)], true)
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
        ctl.send_message("SAM sites OFF", 2)
        trigger.action.setUserFlag(StateFlags.sam, 0)
    else
        ctl.send_message("SAM sites ON", 2)
        trigger.action.setUserFlag(StateFlags.sam, 1)
    end
    ctl.updateCommandMenu()
end

function ctl.toggleMissiles(bool)
    if bool == false then
        ctl.send_message("Next Spawn: Missiles OFF. Guns only", 2)
        trigger.action.setUserFlag(StateFlags.missiles, 0)
    else
        ctl.send_message("Next Spawn: Missiles ON", 2)
        trigger.action.setUserFlag(StateFlags.missiles, 1)
    end
    ctl.updateCommandMenu()
end

function ctl.getBanditGroupName()
    local missiles = trigger.misc.getUserFlag(StateFlags.missiles)
    local enemyType = ctl.getEnemyType()
    local enemyGroup = EnemyGroups[enemyType]
    if (not enemyGroup) then
        ctl.send_message("Error: enemyGroup not found: " .. enemyGroup)
        return ""
    end

    local groupId =nil
    if missiles == 1 then
        -- unit groups ending with "-M"
        groupId = enemyGroup.missiles_id
    else
        groupId = enemyGroup.guns_id
    end

    if (not groupId) then
        ctl.send_message("Error: groupId not found: " .. groupId)
        return ""
    else
        return groupId
    end
end


function ctl.initializeF10Menu()
    --number of enemies
    local countMenu = missionCommands.addSubMenu("Enemy Count")
    local Cmd1 = missionCommands.addCommand("1× bandit", countMenu, ctl.setNumEnemies, 1)
    local Cmd2 = missionCommands.addCommand("2× bandits", countMenu, ctl.setNumEnemies, 2)
    local Cmd3 = missionCommands.addCommand("3× bandits", countMenu, ctl.setNumEnemies, 3)
    local Cmd4 = missionCommands.addCommand("4× bandits", countMenu, ctl.setNumEnemies, 4)
    local Cmd5 = missionCommands.addCommand("5× bandits", countMenu, ctl.setNumEnemies, 5)
    local Cmd6 = missionCommands.addCommand("6× bandits", countMenu, ctl.setNumEnemies, 6)
    local Cmd7 = missionCommands.addCommand("7× bandits", countMenu, ctl.setNumEnemies, 7)
    local Cmd8 = missionCommands.addCommand("8× bandits", countMenu, ctl.setNumEnemies, 8)
    
    --enemy type
    local enemiesMenu = missionCommands.addSubMenu("Enemy Type")
    local modernMenu = missionCommands.addSubMenu("Modern", enemiesMenu)
    local f16Cmd = missionCommands.addCommand("F-16C Viper", modernMenu, ctl.setEnemyType, "F16")
    local f18Cmd = missionCommands.addCommand("F/A-18C Hornet", modernMenu, ctl.setEnemyType, "F18")
    local f15Cmd = missionCommands.addCommand("F-15C Eagle", modernMenu, ctl.setEnemyType, "F15")
    local f14Cmd = missionCommands.addCommand("F-14B Tomcat", modernMenu, ctl.setEnemyType, "F14")
    local s27Cmd = missionCommands.addCommand("Su-27 Flanker", modernMenu, ctl.setEnemyType, "Su27")
    local s30Cmd = missionCommands.addCommand("Su-30 Flanker-G", modernMenu, ctl.setEnemyType, "Su30")
    local m29Cmd = missionCommands.addCommand("MiG-29A Fulcrum", modernMenu, ctl.setEnemyType, "MiG29A")
    local m31Cmd = missionCommands.addCommand("MiG-31 Foxhound", modernMenu, ctl.setEnemyType, "MiG31")
    local m21Cmd = missionCommands.addCommand("MiG-21 Fishbed", modernMenu, ctl.setEnemyType, "MiG21")
    local a10Cmd = missionCommands.addCommand("A-10C Warthog", modernMenu, ctl.setEnemyType, "A10C")

    local historicMenu = missionCommands.addSubMenu("Historic", enemiesMenu)
    local Bf109Cmd = missionCommands.addCommand("BF-109", historicMenu, ctl.setEnemyType, "Bf109")
    local A4ECmd = missionCommands.addCommand("AJS 37 Viggen", historicMenu, ctl.setEnemyType, "AJS37")
    local F5ECmd = missionCommands.addCommand("F-5E Tiger", historicMenu, ctl.setEnemyType, "F5E")
    local Fw190Cmd = missionCommands.addCommand("Fw-190", historicMenu, ctl.setEnemyType, "Fw190")
    local I16Cmd = missionCommands.addCommand("I-16 Ishak", historicMenu, ctl.setEnemyType, "I16")
    local MiG15Cmd = missionCommands.addCommand("MiG-15 Fagot", historicMenu, ctl.setEnemyType, "MiG15")
    local MiG19Cmd = missionCommands.addCommand("MiG-19 Farmer", historicMenu, ctl.setEnemyType, "MiG19")
    local MosquitoCmd = missionCommands.addCommand("Mosquito FB", historicMenu, ctl.setEnemyType, "Mosquito")
    local P51DCmd = missionCommands.addCommand("P-51D Mustang", historicMenu, ctl.setEnemyType, "P51D")
    local SpitfireCmd = missionCommands.addCommand("Spitfire LF", historicMenu, ctl.setEnemyType, "Spitfire")

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

    --angels / altitude
    local angelsMenu = missionCommands.addSubMenu("Altitude")
    local cmdMyAlt  = missionCommands.addCommand("my altitude", angelsMenu, ctl.setAngels, -1)
    local cmd1  = missionCommands.addCommand("1,000 feet", angelsMenu, ctl.setAngels, 1)
    local cmd5  = missionCommands.addCommand("5,000 feet", angelsMenu, ctl.setAngels, 5)
    local cmd10 = missionCommands.addCommand("10k feet", angelsMenu, ctl.setAngels, 10)
    local cmd15 = missionCommands.addCommand("15k feet", angelsMenu, ctl.setAngels, 15)
    local cmd20 = missionCommands.addCommand("20k feet", angelsMenu, ctl.setAngels, 20)
    local cmd25 = missionCommands.addCommand("25k feet", angelsMenu, ctl.setAngels, 25)
    local cmd30 = missionCommands.addCommand("30k feet", angelsMenu, ctl.setAngels, 30)
    local cmd40 = missionCommands.addCommand("40k feet", angelsMenu, ctl.setAngels, 40)
    local cmd50 = missionCommands.addCommand("50k feet", angelsMenu, ctl.setAngels, 50)

    --enemy skill
    local skillMenu = missionCommands.addSubMenu("Enemy Skill")
    local AvrgCmd = missionCommands.addCommand(SkillLevels.AVRG .. ' (' .. ctl.getSkillDesc(SkillLevels.AVRG) .. ')', skillMenu, ctl.setSkillLevel, SkillLevels.AVRG)
    local GoodCmd = missionCommands.addCommand(SkillLevels.GOOD .. ' (' .. ctl.getSkillDesc(SkillLevels.GOOD) .. ')', skillMenu, ctl.setSkillLevel, SkillLevels.GOOD)
    local HighCmd = missionCommands.addCommand(SkillLevels.HIGH .. ' (' .. ctl.getSkillDesc(SkillLevels.HIGH) .. ')', skillMenu, ctl.setSkillLevel, SkillLevels.HIGH)
    local ExelCmd = missionCommands.addCommand(SkillLevels.EXEL .. ' (' .. ctl.getSkillDesc(SkillLevels.EXEL) .. ')', skillMenu, ctl.setSkillLevel, SkillLevels.EXEL)
    local RandCmd = missionCommands.addCommand(SkillLevels.RAND .. ' (' .. ctl.getSkillDesc(SkillLevels.RAND) .. ')', skillMenu, ctl.setSkillLevel, SkillLevels.RAND)

    -- commands
    commandMenu = missionCommands.addSubMenu("Commands")
    ctl.updateCommandMenu()
    
    ctl.send_message(
        "Teleport: Open F10 map. Add a marker to respawn / teleport to this location instantly.\n\n" ..
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
        5
    )
end

function ctl.updateCommandMenu()
    -- Remove previous commands
    if (Menus.startCmd) then missionCommands.removeItem(Menus.startCmd) end
    if (Menus.startRandomCmd) then missionCommands.removeItem(Menus.startRandomCmd) end
    if (Menus.autoRestartCmd) then missionCommands.removeItem(Menus.autoRestartCmd) end
    if (Menus.SAMsCmdOn) then missionCommands.removeItem(Menus.SAMsCmdOn) end
    if (Menus.SAMsCmdOff) then missionCommands.removeItem(Menus.SAMsCmdOff) end
    if (Menus.MissilesCmdOff) then missionCommands.removeItem(Menus.MissilesCmdOff) end
    if (Menus.MissilesCmdOn) then missionCommands.removeItem(Menus.MissilesCmdOn) end

    -- Add new commands
    Menus.startCmd = missionCommands.addCommand("Spawn " .. ctl.getSettings(), commandMenu, ctl.spawnGroup, {})
    Menus.startRandomCmd = missionCommands.addCommand("Spawn Random Bandits", commandMenu, ctl.spawnRandomGroup, {})
    
    -- missiles ON/OFF
    local missiles = trigger.misc.getUserFlag(StateFlags.missiles)
    txt1 = ""
    txt2 = ""
    if missiles == 0 then txt1 = "◀" else txt2 = "◀" end
    Menus.MissilesCmdOff = missionCommands.addCommand("Turn MISSILES OFF" .. txt1, commandMenu, ctl.toggleMissiles, false)
    Menus.MissilesCmdOn = missionCommands.addCommand("Turn MISSILES ON" .. txt2, commandMenu, ctl.toggleMissiles, true)

    -- Sam ON / OFF
    txt1 = ""
    txt2 = ""
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

function ctl.msg_table(table)
    ctl.send_message(
        mist.utils.oneLineSerialize(table)
    )
end

