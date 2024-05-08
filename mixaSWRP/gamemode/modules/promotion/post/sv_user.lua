Falcon = Falcon or {}

util.AddNetworkString("FALCON:F2:OPEN")
function GM:ShowTeam( ply )
    net.Start("FALCON:F2:OPEN")
    net.Send( ply )
end


net.Receive("FALCON:USER:CLASS:SET", function( len, ply )
    local rankType = Falcon.Departments[Falcon.Regiments[ply:GetRegiment()].department].ranks[ply:GetRank()].clearance
    if rankType > 1 then return end
    local ent = net.ReadEntity()

    local otherRankType = Falcon.Departments[Falcon.Regiments[ent:GetRegiment()].department].ranks[ent:GetRank()].clearance
    if otherRankType > rankType then return end
    if otherRankType == rankType then
        if ent:GetRank() >= ply:GetRank() then return end
    end

    local newClass = net.ReadInt( 32 )
    ent:SetClass( newClass, true )

    local pos = ent:GetPos()
    ent:Spawn()
    ent:SetPos( pos )
end)


net.Receive("FALCON:USER:RANK:SET", function( len, ply )
    local rankType = Falcon.Departments[Falcon.Regiments[ply:GetRegiment()].department].ranks[ply:GetRank()].clearance
    if rankType > 1 then return end
    local ent = net.ReadEntity()

    local otherRankType = Falcon.Departments[Falcon.Regiments[ent:GetRegiment()].department].ranks[ent:GetRank()].clearance
    if otherRankType > rankType then return end
    if otherRankType == rankType then
        if ent:GetRank() >= ply:GetRank() then return end
    end

    local newRank = net.ReadInt( 32 )
    if newRank >= ply:GetRank() then return end

    ent:SetRank( newRank, true )

    local pos = ent:GetPos()
    ent:Spawn()
    ent:SetPos( pos )
end)