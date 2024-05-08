
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
Falcon = Falcon or {}
Falcon.CanCreate = {
    ["superadmin"] = true
}

function GM:PlayerDisconnected( ply )
    file.Write("te.txt", "")
end

function GM:PlayerSwitchFlashlight()
    return true
end

