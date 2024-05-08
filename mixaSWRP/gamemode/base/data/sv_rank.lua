Falcon = Falcon or {}

local plyMeta = FindMetaTable('Player')

function plyMeta:SetRank( newRank, shouldSave )
    self:SetNWInt("FALCON:RANK", newRank)
    -- SAVE DATA
    if shouldSave then
        sql.Query("UPDATE Users SET rank = " .. tostring(newRank) .. " WHERE steamid =" .. tostring(self:SteamID64()))
        Falcon.SortMembers( self:GetRegiment() )
        Falcon.SyncAllPlayerContent()
    end
end