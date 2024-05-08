Falcon = Falcon or {}

local plyMeta = FindMetaTable('Player')

function plyMeta:SetRegiment( newRegiment, shouldSave )
    local newReg
    if shouldSave then
        if newRegiment ~= 0 and Falcon.Regiments[newRegiment] then
            newReg = newRegiment
            self:SetRank( 1, true )
            self:SetClass( 0, true )
            sql.Query("UPDATE Users SET regiment = " .. tostring(newRegiment) .. " WHERE steamid =" .. tostring(self:SteamID64()))
        else
            newReg = 0
            self:SetRank(0, true)
            self:SetClass(0, true)
            sql.Query("UPDATE Users SET regiment = 0 WHERE steamid =" .. tostring(self:SteamID64()))
        end
        Falcon.SortMembers( newReg )
        Falcon.SyncAllPlayerContent()
    else
        newReg = newRegiment
    end
    
    self:SetNWInt("FALCON:REGIMENT", newReg)
end

-- PrintTable(sql.Query("SELECT * FROM Users"))

Falcon.SortMembers = function( regID )
    if regID == 0 then return end
    local mem = sql.Query("SELECT rank, class, name FROM Users WHERE regiment = " .. tostring(regID)) or {}

    Falcon.Regiments[regID].members = {}

    for _, member in pairs( mem ) do
        Falcon.Regiments[regID].members[member.name] = member
    end
end
