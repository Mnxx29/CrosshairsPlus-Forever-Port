local _, CPlusNS = ...

local function IsHostile(unit)
    return UnitCanAttack("player", unit) or UnitIsEnemy("player", unit)
end

function CPlusNS.ShouldShowCrosshair(unit)
    if not unit or not UnitExists(unit) then
        return false
    end

    if UnitIsDead(unit) then
        return false
    end

    local db = CPlusNS.db

    local isHostile = IsHostile(unit)

    if UnitIsPlayer(unit) then
        if isHostile then
            return db.showEnemy and db.showEnemyPlayers
        else
            return db.showFriendly and db.showFriendlyPlayers
        end
    else
        local classification = UnitClassification(unit)
        local isCritter = (classification == "trivial" or classification == "minus")

        if isHostile then
            if isCritter then
                return db.showEnemy and db.showEnemyCritters
            end
            return db.showEnemy and db.showEnemyNPCs
        else
            if isCritter then
                return db.showFriendly and db.showFriendlyCritters
            end
            return db.showFriendly and db.showFriendlyNPCs
        end
    end
end

function CPlusNS.CheckNameplateCVars()
    local warnings = {}
    local db = CPlusNS.db

    local showAll = GetCVar("nameplateShowAll")
    if showAll ~= nil and showAll ~= "1" then
        table.insert(warnings, "Nameplates are disabled (Ctrl+V to toggle, or Interface > Names > Always Show Nameplates)")
        return warnings
    end

    local missing = {}

    local showEnemies = GetCVar("nameplateShowEnemies")
    if db.showEnemy and (db.showEnemyPlayers or db.showEnemyNPCs or db.showEnemyCritters)
        and showEnemies ~= nil and showEnemies ~= "1" then
        table.insert(missing, "Enemy Units")
    end
    local showFriends = GetCVar("nameplateShowFriends")
    if db.showFriendly and db.showFriendlyPlayers
        and showFriends ~= nil and showFriends ~= "1" then
        table.insert(missing, "Friendly Players")
    end
    local showFriendlyNPCs = GetCVar("nameplateShowFriendlyNPCs")
    if db.showFriendly and (db.showFriendlyNPCs or db.showFriendlyCritters)
        and showFriendlyNPCs ~= nil and showFriendlyNPCs ~= "1" then
        table.insert(missing, "Friendly NPCs")
    end

    if #missing > 0 then
        table.insert(warnings, "WoW nameplates disabled for: " .. table.concat(missing, ", ")
            .. ". Enable in Interface > Names")
    end

    return warnings
end

function CPlusNS.GetActiveUnit()
    if UnitExists("target") and CPlusNS.ShouldShowCrosshair("target") then
        return "target"
    end
    if CPlusNS.db.enableActionTargeting and UnitExists("softenemy") and CPlusNS.ShouldShowCrosshair("softenemy") then
        return "softenemy"
    end
    return nil
end

local function GetReactionColor(unit)
    local reaction = UnitReaction("player", unit)

    if not CPlusNS.IsSecret(reaction) then
        if reaction == 4 then
            local threat = UnitThreatSituation("player", unit)
            if not CPlusNS.IsSecret(threat) and threat ~= nil then
                local color = FACTION_BAR_COLORS[2]
                return color.r, color.g, color.b
            end
        end

        if reaction and FACTION_BAR_COLORS[reaction] then
            local color = FACTION_BAR_COLORS[reaction]
            return color.r, color.g, color.b
        end
    end

    if IsHostile(unit) then
        return 1, 0, 0
    end

    return 0, 1, 0
end

function CPlusNS.GetUnitColor(unit)
    if not unit or not UnitExists(unit) then
        return 1, 1, 1
    end

    local db = CPlusNS.db

    local tapDenied = UnitIsTapDenied(unit)
    if not CPlusNS.IsSecret(tapDenied) and tapDenied then
        return 0.5, 0.5, 0.5
    end

    local mode = db.colorMode or "class"

    if mode == "custom" then
        local isHostile = IsHostile(unit)
        if isHostile then
            local c = db.customEnemyColor
            return c.r, c.g, c.b
        else
            local c = db.customFriendlyColor
            return c.r, c.g, c.b
        end
    end

    if mode == "class" and UnitIsPlayer(unit) then
        local _, class = UnitClass(unit)
        if not CPlusNS.IsSecret(class) and class and RAID_CLASS_COLORS[class] then
            local color = RAID_CLASS_COLORS[class]
            return color.r, color.g, color.b
        end
    end

    return GetReactionColor(unit)
end
