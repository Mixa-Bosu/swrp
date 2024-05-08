Falcon = Falcon or {}


util.AddNetworkString("FALCON:ADMIN:REGIMENT:SET")
net.Receive("FALCON:ADMIN:REGIMENT:SET", function( len, ply )
    if not ply:IsAdmin() then return end
    local ent = net.ReadEntity()
    local newReg = net.ReadInt( 32 )
    ent:SetRegiment( newReg, true )

    local pos = ent:GetPos()
    ent:Spawn()
    ent:SetPos( pos )
end)

util.AddNetworkString("FALCON:ADMIN:RANK:SET")
net.Receive("FALCON:ADMIN:RANK:SET", function( len, ply )
    if not ply:IsAdmin() then return end
    local ent = net.ReadEntity()
    local newRank = net.ReadInt( 32 )
    ent:SetRank( newRank, true )

    local pos = ent:GetPos()
    ent:Spawn()
    ent:SetPos( pos )
end)

util.AddNetworkString("FALCON:ADMIN:CLASS:SET")
net.Receive("FALCON:ADMIN:CLASS:SET", function( len, ply )
    if not ply:IsAdmin() then return end
    local ent = net.ReadEntity()
    local newClass = net.ReadInt( 32 )
    ent:SetClass( newClass, true )

    local pos = ent:GetPos()
    ent:Spawn()
    ent:SetPos( pos )
end)