Falcon = Falcon or {}
local plyMeta = FindMetaTable('Player')

function plyMeta:GetRegiment()
    local reg = self:GetNWInt("FALCON:REGIMENT", 0)
    if not Falcon.Regiments[reg] then
        self:SetRegiment(0, true)
    end
    return reg
end

function GetRegimentDepartment( reg )
    print(reg)
    local reg = reg
    if not reg then return 0 end
    for _, testStuff in pairs( Falcon.Departments ) do
        if testStuff.id == Falcon.Regiments[reg].department then
            return _
        end
    end
end