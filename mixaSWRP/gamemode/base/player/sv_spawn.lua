Falcon = Falcon or {}

function GM:PlayerInitialSpawn( ply )
end

function GM:PlayerSpawn(ply, transition)
    ply:StripWeapons()
    ply:SetBloodColor( DONT_BLEED )
    ply:SetupHands()
    
    local reg = ply:GetRegiment()
    if reg <= 0 then
        ply:SetModel(Falcon.Config.Default.RegimentData.model or "models/jajoff/sps/alpha/tc13j/coloured_regular02.mdl")
        ply:SetArmor(Falcon.Config.Default.RegimentData.armor or 0)

        ply:SetHealth( Falcon.Config.Default.RegimentData.health or 100 )
        ply:SetMaxHealth( Falcon.Config.Default.RegimentData.health or 100 )

        ply:SetRunSpeed( Falcon.Config.Default.RegimentData.run or 250 )
        ply:SetWalkSpeed( (Falcon.Config.Default.RegimentData.run or 250) / 1.6 )

        local weps = Falcon.Config.Default.RegimentData.weapons or {}
        local count = #weps
        if count > 0 then
            for i = 1, #weps do
                ply:Give( weps[i] )
            end
        end
    else
        local class = ply:GetClass()
        local regTbl = Falcon.Regiments[reg]
        local weps = regTbl.weapons or {}
        local count = #weps
        if count > 0 then
            for i = 1, #weps do
                ply:Give( weps[i] )
            end
        end
        local rank = ply:GetRank()

        local departmentID = 0
        for id, rankData in pairs( Falcon.Departments ) do
            if rankData.id == regTbl.department then
                departmentID = id
            end
        end

        local rnkTbl = Falcon.Departments[departmentID].ranks[rank]
        local loadout = regTbl.loadouts[rnkTbl.clearance]

        if class ~= 0 then
            local classes = regTbl.classes
            local classData = classes[class]
            ply:SetModel(classData.model)

            local classTbldata = Falcon.Classes[classData.class]
            ply:SetHealth( classTbldata.health )
            ply:SetMaxHealth( classTbldata.health )
            ply:SetArmor( classTbldata.armor )
            ply:SetRunSpeed( classTbldata.run )
            ply:SetWalkSpeed( classTbldata.run / 1.6 )



            local weps = classTbldata.weapons or {}
            local count = #weps
            if count > 0 then
                for i = 1, #weps do
                    ply:Give( weps[i] )
                end
            end
        else
            ply:SetModel(loadout.model) 
            ply:SetHealth( loadout.health )
            ply:SetMaxHealth( loadout.health )
            ply:SetArmor( loadout.armor )
            ply:SetRunSpeed( loadout.run )
            ply:SetWalkSpeed( loadout.run / 1.6 )
        end

        local weps = loadout.weapons or {}
        local count = #weps

        if count > 0 then
            for i = 1, #weps do
                ply:Give( weps[i] )
            end
        end
    end

    if ply:IsAdmin() then
        ply:Give('weapon_physgun')
        ply:Give('gmod_tool')
    end
end

function GM:PlayerDeath( ply )
    ply.Location = "Venator"
end


function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end