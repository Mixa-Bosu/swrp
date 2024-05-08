

function GM:PlayerSpawnEffect( ply )
    if ply:IsAdmin() then
        return true
    end
    return false
end
function GM:PlayerSpawnNPC( ply )
    if ply:IsAdmin() then
        return true
    end
    return false
end
function GM:PlayerSpawnObject( ply )
    if ply:IsAdmin() or ply:HasWeapon("gmod_tool") or ply:HasWeapon("weapon_physgun") then
        return true
    end
    return false
end 
function GM:PlayerSpawnProp( ply )
    if ply:IsAdmin() or ply:HasWeapon("gmod_tool") or ply:HasWeapon("weapon_physgun") then
        return true
    end
    return false
end
function GM:PlayerSpawnRagdoll( ply )
    if ply:IsAdmin() or ply:HasWeapon("gmod_tool") or ply:HasWeapon("weapon_physgun") then
        return true
    end
    return false
end
function GM:PlayerSpawnSENT( ply )
    if ply:IsAdmin() then
        return true
    end
    return false
end

hook.Add( "PlayerSpawnSWEP", "SpawnBlockSWEP", function( ply, class, info )
    print(ply:IsAdmin())
	if ( not ply:IsAdmin() ) then
		return false
	end
end )

hook.Add( "PlayerGiveSWEP", "BlockPlayerSWEPs", function( ply, class, swep )
	if ( not ply:IsAdmin() ) then
		return false
	end
end )

function GM:PlayerSpawnVehicle( ply )
    if ply:IsAdmin() then
        return true
    end
    return false
end