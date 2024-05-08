Falcon = Falcon or {}

util.AddNetworkString("FALCON:PLAYER:DAMAGE")
function GM:PlayerShouldTakeDamage( ply, attacker )
    net.Start("FALCON:PLAYER:DAMAGE")
        net.WriteString( ply:Nick() )
    net.Broadcast()
    return true
end

function GM:OnNPCKilled(npc, attacker, inflictor)
    if attacker:IsPlayer() then
        attacker:AddFrags( 1 )
    end 
end 

function GM:GetFallDamage(ply, speed)
    return ((speed / 12)/100) * ply:GetMaxHealth()
end