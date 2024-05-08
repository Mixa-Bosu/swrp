local w, h = ScrW(), ScrH()
local cash = Material("sr/cash.png")
local name = Material("sr/name.png")
local health = Material("sr/health.png")
local lvl = Material("sr/levels.png")
local weapon = Material("sr/weapon.png")
local ammo = Material("sr/ammo.png")

local color_white = Color(255, 255, 255)
local color_black = Color(0, 0, 0, 195)
local color_red = Color( 110, 0, 0, 155 )
local color_red_light = Color( 210, 100, 100, 255 )
local color_red_dark = Color( 210, 80, 80, 255 )
local color_yellow = Color( 110, 110, 0, 155 )
local color_yellow_light = Color( 195, 195, 0, 255 )
local color_yellow_dark = Color( 210, 210, 80, 255 )
local color_blue = Color( 0, 0, 165, 155 )
local color_blue_light = Color( 110, 110, 165, 255 )
local color_blue_dark = Color( 65, 65, 165, 255 )


function surface.DrawRectWithCorners( x, y, w, h, timingThingo )
    local newH = h * (timingThingo or 0.25)
    -- Falcon.UI.Presets.Other.DrawBlur( x, y, w, h, 4 )
    surface.SetDrawColor( color_black )
    surface.DrawRect( x, y, w, h )
    surface.SetDrawColor( color_white )
    surface.DrawRect( x, y, 2, newH )
    surface.DrawRect( x, y, newH, 2 )
    surface.DrawRect( x + w - newH, y, newH, 2 )
    surface.DrawRect( x + w - 2, y, 2, newH )
    surface.DrawRect( x + w - 2, y + h - newH, 2, newH )
    surface.DrawRect( x + w - newH, y + h - 2, newH, 2 )
    surface.DrawRect( x, y + h - 2, newH, 2 )
    surface.DrawRect( x, y + h - newH, 2, newH )
end

avatar = avatar
function GM:HUDPaint()
    local localPlayer = LocalPlayer()
    local newH = 0.835
    local newW = 0.0225
    
    surface.DrawRectWithCorners( w * newW, h * newH, w * 0.042, w * 0.042 )
    if avatar and avatar:IsValid() then
        avatar:SetPos( w * (newW + 0.0014), h * (newH + 0.003) )
        avatar:SetModel( localPlayer:GetModel() )

    else
        local av = vgui.Create( "DModelPanel" )
        av:SetSize( w * 0.03925, w * 0.03925 )
        av:SetFOV( 10 )
        av:SetLookAt( Vector(0, 0, 65) )
        av:SetCamPos( Vector(120, 0, 70) )
        function av:LayoutEntity() return end
        avatar = av
    end

    surface.DrawRectWithCorners( w * (newW + 0.043), h * (newH + 0.005), w * 0.018, w * 0.018 )
    surface.DrawRectWithCorners( w * (newW + 0.062), h * (newH + 0.008), w * 0.1325, w * 0.015 )
    draw.DrawText( string.upper(localPlayer:Nick()), "F13", w * (newW + 0.0635), h * (newH + 0.004), color_white, TEXT_ALIGN_LEFT )
    surface.SetMaterial( name )
    surface.DrawTexturedRect( w * (newW + 0.04575), h * (newH + 0.01), w * 0.0125, w * 0.0125 )

    surface.DrawRectWithCorners( w * (newW + 0.043), h * (newH + 0.0385), w * 0.018, w * 0.018 )
    surface.DrawRectWithCorners( w * (newW + 0.062), h * (newH + 0.041), w * 0.1325, w * 0.015 )
    draw.DrawText( string.upper("$"), "S8", w * (newW + 0.0635), h * (newH + 0.041), color_white, TEXT_ALIGN_LEFT )
    draw.DrawText( string.upper(localPlayer:GetCredits()), "F13", w * (newW + 0.0765), h * (newH + 0.0375), color_white, TEXT_ALIGN_LEFT )
    surface.SetMaterial( cash )
    surface.DrawTexturedRect( w * (newW + 0.044), h * (newH + 0.041), w * 0.016, w * 0.016 )

    surface.DrawRectWithCorners( w * (newW + 0.001), h * (newH + 0.077), h * 0.025, h * 0.025 )
    surface.DrawRectWithCorners( w * (newW + 0.017), h * (newH + 0.078525), w * 0.1775, h * 0.0225 )
    surface.SetMaterial( health )
    surface.DrawTexturedRect( w * (newW + 0.00275), h * (newH + 0.0805), w * 0.011, w * 0.011 )

    local hp = localPlayer:Health()
    local maxHp = localPlayer:GetMaxHealth()
    surface.SetDrawColor(color_red)
    surface.DrawRect( w * (newW + 0.019), h * (newH + 0.081), w * 0.1735, h * 0.0173 )
    surface.SetDrawColor(color_red_dark)
    surface.DrawRect( w * (newW + 0.019), h * (newH + 0.081), math.Clamp(hp / maxHp, 0, 1)*(w * 0.1735), h * 0.0173 )
    surface.SetDrawColor(color_red_light)
    surface.DrawRect( w * (newW + 0.019), h * (newH + 0.081), math.Clamp(hp / maxHp, 0, 1)*(w * 0.1735), h * 0.0075 )
    draw.SimpleTextOutlined( hp .. " | " .. maxHp, "F10", w * (newW + 0.1045), h * (newH + 0.0768), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black )

    surface.DrawRectWithCorners( w * (newW + 0.001), h * (newH + 0.104), h * 0.025, h * 0.025 )
    surface.DrawRectWithCorners( w * (newW + 0.017), h * (newH + 0.1057), w * 0.1775, h * 0.0225 )
    surface.SetMaterial( lvl )
    surface.DrawTexturedRect( w * (newW + 0.00275), h * (newH + 0.1065), w * 0.011, w * 0.011 )
    local lvl = localPlayer:GetLevel()
    local maxLvl = 500
    surface.SetDrawColor(color_yellow)
    surface.DrawRect( w * (newW + 0.019), h * (newH + 0.1084), w * 0.1735, h * 0.0173 )
    surface.SetDrawColor(color_yellow_light)
    surface.DrawRect( w * (newW + 0.019), h * (newH + 0.1084), math.Clamp(lvl / maxLvl, 0, 1)*(w * 0.1735), h * 0.0173 )
    surface.SetDrawColor(color_yellow_dark)
    surface.DrawRect( w * (newW + 0.019), h * (newH + 0.1084), math.Clamp(lvl / maxLvl, 0, 1)*(w * 0.1735), h * 0.0075 )
    draw.SimpleTextOutlined( lvl .. " | " .. maxLvl, "F10", w * (newW + 0.1045), h * (newH + 0.1035), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black )

    local wep = localPlayer:GetActiveWeapon()
    local weaponText = "NO WEAPON"
    local pecentageAmmo = 0

    if wep and wep:IsValid() then
        weaponText = wep:GetPrintName()
        local cl1 = wep:Clip1()
        if cl1 and cl1 > -1 then
            local maxCl1 = wep:GetMaxClip1()
            pecentageAmmo = cl1 / maxCl1
        end
    end
    local ammoW, ammoH = 0.9, 0.835
    surface.DrawRectWithCorners( w * (ammoW + 0.0635), h * (ammoH + 0.077), h * 0.025, h * 0.025 )
    surface.DrawRectWithCorners( w * (ammoW - 0.058), h * (ammoH + 0.077), w * 0.12, h * 0.025 )
    surface.SetMaterial( weapon )
    surface.DrawTexturedRect( w * (ammoW + 0.065125), h * (ammoH + 0.08), h * 0.019, h * 0.019 )
    draw.SimpleTextOutlined( string.upper(weaponText), "F10", w * (ammoW + 0.059), h * (ammoH + 0.0765), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, color_black )

    surface.DrawRectWithCorners( w * (ammoW + 0.0635), h * (ammoH + 0.104), h * 0.025, h * 0.025 )
    surface.DrawRectWithCorners( w * (ammoW - 0.058), h * (ammoH + 0.104), w * 0.12, h * 0.025 )
    surface.SetMaterial( ammo )
    surface.DrawTexturedRect( w * (ammoW + 0.065125), h * (ammoH + 0.10675), h * 0.019, h * 0.019 )

    if pecentageAmmo >= 0 and wep and wep:IsValid() and wep:Clip1() > -1 then
        surface.SetDrawColor( color_blue )
        surface.DrawRect( w * (ammoW - 0.057), h * (ammoH + 0.107), w * 0.11775, h * 0.02 )

        surface.SetDrawColor( color_blue_dark )
        surface.DrawRect( (w * (ammoW - 0.057) + w * 0.11775) - (pecentageAmmo * (w * 0.11775)), h * (ammoH + 0.107), (w * 0.11775) * pecentageAmmo, h * 0.02 )

        surface.SetDrawColor( color_blue_light )
        surface.DrawRect( (w * (ammoW - 0.057) + w * 0.11775) - (pecentageAmmo * (w * 0.11775)), h * (ammoH + 0.107), (w * 0.11775) * pecentageAmmo, h * 0.00775 )
        draw.SimpleTextOutlined( wep:Clip1() .. " / " .. wep:GetMaxClip1(), "F10", w * (ammoW + 0.059), h * (ammoH + 0.10325), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, color_black )
    else
        draw.SimpleTextOutlined( "NONE", "F10", w * (ammoW + 0.059), h * (ammoH + 0.10325), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, color_black )
    end
end

local lightRed = Color( 195, 100, 100 )
local lightGreen = Color( 130, 200, 130 )
local lightGrey = Color( 0, 0, 0 )
local icon = Material("icon32/unmuted.png")

hook.Add("PostDrawOpaqueRenderables", "FALCON:HUD", function()
    local localPlayer = LocalPlayer()
    local angle = EyeAngles()

	angle = Angle( 0, angle.y, 0 )

	angle:RotateAroundAxis( angle:Up(), -90 )
	angle:RotateAroundAxis( angle:Forward(), 90 )

	local trace = localPlayer:GetEyeTrace()
    if not trace.Entity or not trace.Entity:IsPlayer() then return end
    local ply = trace.Entity
    local tempPos = ply:GetBonePosition( ply:LookupBone("ValveBiped.Bip01_Head1") )

	local pos = tempPos - Vector( 0, 0, 30 )
    if localPlayer:GetPos():DistToSqr( pos ) > 80000 then return end

    local reg = Falcon.Regiments[ply:GetRegiment()]
    local rank = Falcon.Departments[reg.department or 0].ranks[ply:GetRank()].abr
    local hpText = "HP: " .. tostring(ply:Health())
    if ply:Armor() > 0 then
        hpText = hpText .. " [" .. ply:Armor() .. "]"
    end

    local classNme = "Rifleman"
    if ply:GetClass() > 0 then
        classNme = Falcon.Classes[ply:GetClass()].name
    end

    local wepName = "None"
    local clip = "None"
    local activewep = ply:GetActiveWeapon()
    if activewep and activewep:IsValid() then
        wepName = activewep:GetPrintName()
        local cl1 = activewep:Clip1()
        if cl1 and cl1 > -1 then
            local maxCl1 = activewep:GetMaxClip1()
            clip = maxCl1 .. " | " .. cl1
        end
    end

    
    cam.Start3D2D( pos, angle, 0.1 )

        surface.SetDrawColor( color_white )
        surface.DrawRect( 85, -330, 155, 3 )
        surface.DrawRect( 85 + 155, -360, 3, 60 )
        surface.DrawRect( 85 + 155, -360, 30, 3 )
        surface.DrawRect( 85 + 155, -300, 30, 3 )
        draw.DrawText( string.upper(rank .. " " .. ply:Nick()), "F18", 85 + 170, -357, color_white, TEXT_ALIGN_LEFT )

        surface.SetDrawColor( lightRed )
        surface.DrawRect( 160, -200, 155, 3 )
        surface.DrawRect( 160 + 155, -230, 3, 60 )
        surface.DrawRect( 160 + 155, -230, 30, 3 )
        surface.DrawRect( 160 + 155, -170, 30, 3 )
        draw.DrawText( string.upper(hpText), "F18", 160 + 170, -227, lightRed, TEXT_ALIGN_LEFT )

        surface.SetDrawColor( reg.color )
        surface.DrawRect( 160, -120, 155, 3 )
        surface.DrawRect( 160 + 155, -150, 3, 60 )
        surface.DrawRect( 160 + 155, -150, 30, 3 )
        surface.DrawRect( 160 + 155, -90, 30, 3 )
        draw.DrawText( string.upper(reg.name), "F18", 160 + 170, -147, reg.color, TEXT_ALIGN_LEFT )

        surface.SetDrawColor( lightGreen )
        surface.DrawRect( 160, -40, 155, 3 )
        surface.DrawRect( 160 + 155, -70, 3, 60 )
        surface.DrawRect( 160 + 155, -70, 30, 3 )
        surface.DrawRect( 160 + 155, -10, 30, 3 )
        draw.DrawText( string.upper(classNme), "F18", 160 + 170, -67, lightGreen, TEXT_ALIGN_LEFT )

        surface.SetDrawColor( lightGrey )
        surface.DrawRect( -310, -80, 155, 3 )
        surface.DrawRect( -310, -110, 3, 60 )
        surface.DrawRect( -340, -110, 30, 3 )
        surface.DrawRect( -340, -53, 30, 3 )
        draw.DrawText( string.upper(wepName), "F18", -320, -110, lightGrey, TEXT_ALIGN_RIGHT )

        surface.DrawRect( -310, 0, 155, 3 )
        surface.DrawRect( -310, -30, 3, 60 )
        surface.DrawRect( -340, -30, 30, 3 )
        surface.DrawRect( -340, 27, 30, 3 )
        draw.DrawText( string.upper(clip), "F18", -320, -30, lightGrey, TEXT_ALIGN_RIGHT )
        

    cam.End3D2D()

    
end)

local hide = {
	["CHudHealth"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudSquadStatus"] = true,
	["CHudHintDisplay"] = true,
	["CHudDeathNotice"] = true,
	["CHudCrosshair"] = true,
	["CHudBattery"] = true
}
hook.Add( "HUDShouldDraw", "F_HIDE_HUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
end )

f_voiceChatPnl = f_voiceChatPnl
-- f_voiceChatPnl:Remove()

local playersCurrentlySpeaking = {}
local w, h = ScrW(), ScrH()
local function addVoiceChat( ply )

    if f_voiceChatPnl and f_voiceChatPnl:IsValid() then 
        if not playersCurrentlySpeaking[ply] or not playersCurrentlySpeaking[ply]:IsValid() then
            local w, h = f_voiceChatPnl:GetSize()
            local test = vgui.Create('DPanel', f_voiceChatPnl)
            test:SetSize( w, h * 0.055 )
            test:Dock( BOTTOM )
            test:DockMargin( w * 0.025, w * 0.0125, w * 0.025, w * 0.0125)
            test:SetAlpha( 0 )
            test.VoiceData = {}
            for i = 1, 100 do
                test.VoiceData[i] = 0
            end
            test.Paint = function( self, w, h )
                surface.DrawRectWithCorners( 0, 0, w, h )
                draw.DrawText( ply:Nick(), "F15", w * 0.225, h * 0.1, color_whit, TEXT_ALIGN_LEFT )
            end 
            test.Think = function( self )
                if self.ShouldDelete then
                    self:SetAlpha( math.Clamp( self:GetAlpha() - ((FrameTime() * 12) * 255), 0, 255) )
                    if self:GetAlpha() == 0 then
                        self:Remove()
                        playersCurrentlySpeaking[ply] = nil
                    end
                else
                    self:SetAlpha( math.Clamp( self:GetAlpha() + ((FrameTime() * 12) * 255), 0, 255) )
                    table.insert( self.VoiceData, 1, ply:VoiceVolume() )
                    self.VoiceData[101] = nil
                end 
            end

            local w, h = test:GetSize()
            local playerModel = vgui.Create('SpawnIcon', test)
            playerModel:SetSize( h * 0.925, h * 0.925 )
            playerModel:SetPos( w * 0.01, h * 0.05 )
            playerModel:SetModel( ply:GetModel() )
            playersCurrentlySpeaking[ply] = test
        end
        playersCurrentlySpeaking[ply].ShouldDelete = false
        return 
    end
    local pnl = vgui.Create("DPanel")
    pnl:SetSize( w * 0.125, h * 0.85 )
    pnl:SetPos( w * 0.8525, h * 0.05 )
    pnl.Paint = nil
    f_voiceChatPnl = pnl
    addVoiceChat( ply )
end

hook.Add("PostDrawOpaqueRenderables", "ImageOnVoice", function()
    -- local angle = EyeAngles()

    -- angle = Angle( 0, angle.y, 0 )

    -- angle:RotateAroundAxis( angle:Up(), -90 )
    -- angle:RotateAroundAxis( angle:Forward(), 90 )

    -- local tempPos = ply:GetBonePosition( ply:LookupBone("ValveBiped.Bip01_Head1") ) or ply:GetPos()
    -- cam.Start3D2D( tempPos + Vector( 0, 0, 18 ), angle, 0.1 )
    --     surface.SetDrawColor(255, 255, 255)
    --     surface.SetMaterial(icon)
    --     surface.DrawTexturedRect(-30, 0, 60, 60)
    -- cam.End3D2D()
end )

hook.Add("PlayerStartVoice", "ImageOnVoice", function( ply )
    addVoiceChat( ply )
    return false
end)

hook.Add("PlayerEndVoice", "ImageOnVoice", function( ply )
    if playersCurrentlySpeaking[ply] and playersCurrentlySpeaking[ply]:IsValid() then
        playersCurrentlySpeaking[ply].ShouldDelete = true
    end
end)
