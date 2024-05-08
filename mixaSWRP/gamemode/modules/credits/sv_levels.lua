Falcon = Falcon or {}

local plyMeta = FindMetaTable("Player")
function plyMeta:SetLevel( newLevel, shouldSave )
    self:GetNWInt("Falcon:Level", newLevel)
end
function plyMeta:SetCredits( creditu, shouldSave )
    self:GetNWInt("Falcon:Credit", creditu)
end