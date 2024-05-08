Falcon = Falcon or {}

local plyMeta = FindMetaTable('Player')

function plyMeta:SetClass( newClass, shouldSave )
    self:SetNWInt("FALCON:CLASS", newClass)
    -- SAVE DATA

    if shouldSave then
        sql.Query("UPDATE Users SET class = " .. tostring(newClass) .. " WHERE steamid =" .. tostring(self:SteamID64()))
        Falcon.SortMembers( self:GetRegiment() )
        Falcon.SyncAllPlayerContent()
    end
end