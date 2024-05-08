Falcon = Falcon or {}

local plyMeta = FindMetaTable("Player")
function plyMeta:GetLevel()
    return self:GetNWInt("Falcon:Level", 500)
end
function plyMeta:GetCredits()
    return self:GetNWInt("Falcon:Level", 0)
end