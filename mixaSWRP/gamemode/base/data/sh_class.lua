Falcon = Falcon or {}
local plyMeta = FindMetaTable('Player')

function plyMeta:GetClass()
    return self:GetNWInt("FALCON:CLASS", 0)
end