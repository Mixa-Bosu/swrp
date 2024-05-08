Falcon = Falcon or {}

f_scoreboardUI = f_scoreboardUI

local color_shao3w = Color( 45, 45, 52, 165 )
local color_shaow = Color( 23, 23, 29, 165 )
local color_shao2w = Color( 20, 20, 30, 240 )
local color_actual_white = Color( 240, 240, 240, 255 )

local color_white = Color( 185, 185, 185, 255 )
local color_grey = Color( 155, 155, 155, 255 )

local blackish_dark = Color( 20, 20, 25, 220 )
local blackish_light = Color( 35, 35, 40, 220 )
local tag = Material("sr/usergroup.png")
local info = Material("sr/info.png")

local function showUI()
    if IsValid( f_scoreboardUI ) then 
        f_scoreboardUI.ShouldShow = true
        return 
    end
    local f = vgui.Create("DFrame")
    f:SetSize( ScrW(), ScrH() )
    f:SetAlpha(0)
    f:SetMouseInputEnabled( true )
    gui.EnableScreenClicker( true )
    f.ShouldShow = true
    f.Paint = function( self, w, h )
        surface.SetDrawColor( color_shaow )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( color_actual_white )
        draw.NoTexture()
        surface.SetMaterial( theRepublicLogo )
        surface.DrawTexturedRect( w * 0.375, h * 0.09, w * 0.25, h * 0.09 )
    end 
    f.OnClose = function( self )
        gui.EnableScreenClicker( false )
    end
    f.Think = function( self )
        if self.ShouldShow then
            self:SetAlpha( math.Clamp( self:GetAlpha() + ((FrameTime() * 12) * 255), 0, 255) )
        else
            self:SetAlpha( math.Clamp( self:GetAlpha() - ((FrameTime() * 12) * 255), 0, 255) )
            if not self.ShouldShow and self:GetAlpha() == 0 then
                if IsValid( f_scoreboardUI ) then
                    f_scoreboardUI:Close()
                end
            end 
        end 
    end

    local w, h = f:GetSize()
    local bannerPlayer = vgui.Create('DPanel', f)
    bannerPlayer:SetSize( w * 0.7, h * 0.03 )
    bannerPlayer:SetPos( w * 0.15, h * 0.235 )
    bannerPlayer.Paint = function( self, w, h )
        draw.DrawText( "Name", "F14", w * 0.027, h * 0.0, color_actual_white, TEXT_ALIGN_LEFT )
        draw.DrawText( "Regiment", "F14", w * 0.5, h * 0.0, color_actual_white, TEXT_ALIGN_CENTER )
        draw.DrawText( "K", "F14", w * 0.875, h * 0.0, color_actual_white, TEXT_ALIGN_RIGHT )
        draw.DrawText( "D", "F14", w * 0.91, h * 0.0, color_actual_white, TEXT_ALIGN_RIGHT )
    end
    local players = vgui.Create("DScrollPanel", f)
    players:SetSize( w * 0.7, h * 0.5575 )
    players:SetPos( w * 0.15, h * 0.2675 )
    players.Paint = nil
    
    local regimentTableSorted = {}
    for reg, _ in pairs( Falcon.Regiments ) do
        regimentTableSorted[reg] = {}
    end
    local playerTable = player.GetAll()
    for _, ply in pairs( playerTable ) do
        table.insert(regimentTableSorted[ply:GetRegiment()], ply)
    end

    local w, h = players:GetSize()
    for _, reg in pairs( regimentTableSorted ) do
        if #reg == 0 then continue end
        local regTbl = Falcon.Regiments[_]
        for _, ply in pairs( reg ) do
            local regimentPnl = vgui.Create('DButton', players)
            regimentPnl:SetSize( w, h * 0.054 )
            regimentPnl:Dock( TOP )
            regimentPnl:SetText( "" )
            regimentPnl:SetContentAlignment( 5 )
            regimentPnl.Paint = function( self, w, h )
                surface.SetDrawColor( blackish_light )
                surface.DrawRect( 0, 0, w, h )
                surface.SetDrawColor( regTbl.color )
                surface.DrawRect( 0, 0, w * 0.002, h )
                surface.DrawRect( w - (w * 0.0016), 0, w * 0.002, h )
                
                draw.DrawText( regTbl.name .. " [" .. regTbl.abbreviation .. "]", "F10", w * 0.5, h * 0.065, color_white, TEXT_ALIGN_CENTER )
                draw.DrawText( ply:Nick(), "F10", w * 0.0275, h * 0.065, color_white, TEXT_ALIGN_LEFT )
                draw.DrawText( ply:Frags(), "F10", w * 0.874, h * 0.065, color_white, TEXT_ALIGN_RIGHT )
                draw.DrawText( ply:Deaths(), "F10", w * 0.9081, h * 0.065, color_white, TEXT_ALIGN_RIGHT )
                draw.DrawText( ply:Ping(), "F10", w * 0.98, h * 0.065, color_white, TEXT_ALIGN_RIGHT )

            end
            local steamImg = vgui.Create('AvatarImage', regimentPnl)
            steamImg:SetSize( regimentPnl:GetTall() * 0.9, regimentPnl:GetTall() * 0.9305 )
            steamImg:SetPos( regimentPnl:GetTall() * 0.1, regimentPnl:GetTall() * 0.05 )
            steamImg:SetPlayer( ply )

            
            local details = vgui.Create('DPanel', players)
            details:SetSize( w, 0 )
            details:Dock( TOP )
            details:DockMargin( 0, 0, 0, h * 0.004 )
            details.Paint = function(self, w, h)
                surface.SetDrawColor(color_shao2w)
                surface.DrawRect( 0, 0, w, h )
            end

            local information = vgui.Create('DPanel', details)
            information:Dock( FILL )
            local user = string.upper( ply:GetUserGroup() )
            information.Paint = function( self, w, h )
                surface.SetDrawColor( color_shao3w )
                draw.NoTexture()
                surface.SetMaterial( tag )
                surface.DrawTexturedRect( w * 0.005, h * 0.1, w * 0.015, w * 0.015 )
                draw.DrawText( user, "F7", w * 0.03, h * 0.12, color_white, TEXT_ALIGN_LEFT )
                
                surface.SetMaterial( info )
                surface.DrawTexturedRect( w * 0.005, h * 0.525, w * 0.015, w * 0.015 )
                draw.DrawText( "LVL " .. ply:GetLevel(), "F7", w * 0.03, h * 0.535, color_white, TEXT_ALIGN_LEFT )

                surface.SetDrawColor( color_actual_white )
                surface.SetMaterial( info )
                surface.DrawTexturedRect( (w * 0.5) - (h * 0.25), h * 0.25, h * 0.5, h * 0.5 )
            end
            
            information:SetAlpha( 0 )
            information.Think = function( self, w, h )
                if self.ShouldAnime then
                    self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime()*6)*255), 0, 255) )
                else
                    self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime()*6)*255), 0, 255) )
                    if self:GetAlpha() == 0 then
                        if details:GetTall() ~= 0 and not details.IsAnimating then
                            details:SizeTo( players:GetWide(), 0, 0.2, 0, -1, function()
                                details.IsAnimating = false
                            end)
                            details.IsAnimating = true

                        end
                    end
                end
            end

            regimentPnl.DoClick = function( self )
                if details:GetTall() == 0 then
                    details.IsAnimating = true
                    details:SizeTo( w, h * 0.1, 0.2, 0, -1, function( pnl, d )
                        information.ShouldAnime = true
                        details.IsAnimating = false
                    end)
                else
                    information.ShouldAnime = false
                end
            end 
        end
    end 
    -- players.Paint = nil


    f_scoreboardUI = f
end

local function ShowScoreboard( shouldShow )
    if shouldShow then
        showUI()
    else
        if not IsValid( f_scoreboardUI ) then return end
        f_scoreboardUI.ShouldShow = false
    end
end

hook.Add("ScoreboardShow", "F_SHOW_SCOREBOARD", function()
    ShowScoreboard(true)
    return false
end)

hook.Add("ScoreboardHide", "F_SHOW_SCOREBOARD", function()
    ShowScoreboard(false)
end)