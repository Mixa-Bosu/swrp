Falcon = Falcon or {}


hook.Add("OnSpawnMenuOpen", "FALCON:RESTRICT:QMENU", function()
    local ply = LocalPlayer()
    if not ply:HasWeapon("gmod_tool") and not ply:HasWeapon("weapon_physgun") then
        return true
    end
end)