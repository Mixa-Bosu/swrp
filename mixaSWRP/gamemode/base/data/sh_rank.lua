Falcon = Falcon or {}
local plyMeta = FindMetaTable('Player')

function plyMeta:GetRank()
    return self:GetNWInt("FALCON:RANK", 0)
end

