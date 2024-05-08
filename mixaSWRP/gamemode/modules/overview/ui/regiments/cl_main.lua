Falcon = Falcon or {}
Falcon.Overview = Falcon.Overview or {}

local f = Falcon.Overview

local color_black = Color( 0, 0, 0 )
local whiteish = Color( 255, 255, 255 )

local seq = { "taunt_robot", "crab_dance", "dance_shoot", "dancing_girl", "epic_sax_guy", "goatdance", "groovejam", "guitar_walk", "f_zippy_dance", "kpop_dance03", "loser_dance", 
"f_cowboydance", "f_break_dance", "f_break_dance_v2", "f_flossdance", "f_goatdance", "f_gothdance", "f_indiadance", "f_jazz_dance", "f_lazerdance", "f_loser_dance", "f_pump_dance", 
"f_robotdance", "f_touchdown_dance", "f_treadmilldance", "f_wave_dance", "f_dance_worm", "dance_nobones", "f_dancemoves", "f_kpop_dance03", "f_warehousedance"
}
local mainSeq = { "calculated", "hi_five_slap", "iceking", "f_wave2", "f_golfclap" }
local menuIdleThings = {
    "menuidle",
    "menuidle_50ae",
    "menuidle_ar",
    "menuidle_gren_frag",
    "menuidle_knife",
    "menuidle_pistol",
    "menuidle_revolver",
    "menuidle_saa",
    "menuidle_sniper",
    "wos_aoc_axe_holsted_idle",
    "wos_aoc_boxing_holsted_idle",
    "wos_aoc_boxing_idle2",
}

local navBtns = { 
    {name = "Info", 
    click=function(pnl) 
        f.OpenOverview( pnl, pnl.data, pnl.regid )
    end},
    {name = "Members", 
    click=function(pnl) 
        f.OpenMembers( pnl, pnl.data, pnl.regid )
    end},
    {name = "Classes", 
    click=function(pnl) 
    end},
}

f.OpenRegimentMain = function( reg, regID )
    local fra = f.Frame
    fra.ShouldAnim = false
    
    local content, fr = Falcon.UI.Presets.Frames.CreateBaseFrame( 0.8, 0.75, 0, 0, {
        shouldAnimate = true,
        text = reg.name .. " - " .. "OVERVIEW",
    } )
    fr:Center()

    Falcon.UI.Presets.Buttons.ExitButton( fr, nil, function()
        fr.ShouldDelete = false
        fr.ShouldAnim = false
        fra:Show()
        fra.ShouldAnim = true
    end)

    local _, mODel, nigga = Falcon.UI.Presets.Models.CreateFullModel(content, 0.35, 0.9, 0.025, 0.05, {})
    nigga.Paint = function( self, w, h )
        surface.SetDrawColor( color_black.r, color_black.g, color_black.b, 175 )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( whiteish )
        surface.DrawRect( 0, 0, 2, h * 0.15 )
        surface.DrawRect( 0, 0, h * 0.15, 2 )

        surface.DrawRect( 0, h - 2, h * 0.15, 2 )
        surface.DrawRect( 0, h - (h * 0.15), 2, h * 0.15 )

        surface.DrawRect( w - 2, 0, 2, h * 0.15 )
        surface.DrawRect( w - (h * 0.15), 0, h * 0.15, 2 )

        surface.DrawRect( w - (h * 0.15), h - 2, h * 0.15, 2 )
        surface.DrawRect( w - 2, h - (h * 0.15), 2, h * 0.15 )
    end
    
    mODel:SetLookAt( Vector(0, 0, 35) )
    mODel:SetCamPos( Vector(120, 0, 40) )
    mODel:SetFOV( 38 )
    mODel:SetModel( reg.loadouts[1].model )

    local seq = math.random(1, #menuIdleThings)
    mODel.Entity:SetSequence(menuIdleThings[seq])
    function mODel:LayoutEntity( ent )
        if ent:GetCycle() >= 0.99 then
            ent:SetCycle( 0 )
        end
        mODel:RunAnimation()
    end

    local w, h = content:GetWide(), content:GetTall()
    local ov = vgui.Create('DPanel', content)
    ov:SetSize( w * 0.575, h * 0.9 )
    ov:SetPos( w * 0.4, h * 0.05 )
    ov.Paint = nil

    local w, h = ov:GetWide(), ov:GetTall()
    local nav = vgui.Create("DPanel", ov)
    nav:SetSize( w, h * 0.06 )
    nav.Paint = nil

    local contPnl = vgui.Create("DPanel", ov)
    contPnl:SetSize( w, h * 0.94 )
    contPnl:SetPos( 0, h * 0.06 )
    contPnl.Paint = nil
    contPnl.data = reg
    contPnl.regid = regID
    Falcon.UI.Presets.Buttons.CreateHorizontalButtons( nav, {
        w = 0.1,
        h = 0.4,
        font = "F13",
        dock = LEFT,
        fade = true,
        shouldStart = 1,
        click = function()
            contPnl:Clear()
        end
    }, navBtns, contPnl )

    
end

f.OpenRegimentInfo = function( content )
    content:Clear()

    local c = Falcon.UI.Presets.Panel.CreateHorizontalScroll( content, 1, 1, 0, 0, {} )

    local w, h = c:GetSize()
    for ijadgfijopdsag, reg in pairs( Falcon.Regiments ) do
        if ijadgfijopdsag == 0 then continue end

        local p = vgui.Create("DPanel", c)
        p:SetSize( w * 0.25, h )
        p.Paint = function( self, w, h )
            surface.SetDrawColor( reg.color.r, reg.color.g, reg.color.b, 40 )
            surface.DrawRect( 0, 0, w, h )
            surface.SetDrawColor( reg.color )
            surface.DrawOutlinedRect( 0, 0, w, h )
        end

        -- model
        local content, mdl = Falcon.UI.Presets.Models.CreateFullModel( p, 0.9, 0.85, 0.05, 0.03, {} )
        
        mdl:SetFOV( 30 )
        mdl:SetLookAt( Vector(0, 0, 35) )
        mdl:SetCamPos( Vector(120, 0, 40) )
        mdl:SetModel( reg.loadouts[1].model )
        content.OnCursorEntered = function( self )
            local e = mdl:GetEntity()

            local newAnim = math.random(1, 2)
            local newAnim = math.random(1, 1)

            if newAnim == 1 then
                local easterEgg = math.random(1, 1000)
                local easterEgg = math.random(1, 1)
                local newSeq = mainSeq[math.random(1, #mainSeq)]
                if easterEgg == 1 then
                    newSeq = seq[math.random(1, #seq)]
                end
                e:SetSequence( newSeq )
                e:SetPlaybackRate(1)
            end
        end
        content.OnCursorExited = function( self )
            local e = mdl:GetEntity()
            e:SetSequence("idle_all_01")
        end
        function mdl:LayoutEntity( ent )
            if ent:GetCycle() >= 1 then
                ent:SetCycle( 0 )
            end
            mdl:RunAnimation()
        end

        local w, h = p:GetSize()

        local btn = vgui.Create( "DButton", p )
        btn:SetSize( w * 0.9, h * 0.08 )
        btn:SetPos( w * 0.05, h * 0.9 )
        btn:SetFont( "F13" )
        btn:SetText( reg.name )
        btn:SetColor( color_white )
        btn.Paint = function( self, w, h )
            surface.SetDrawColor( color_black.r, color_black.g, color_black.b, 200 )
            surface.DrawRect( 0, 0, w, h )
        end

        btn:SetAlpha( 175 )
        btn.Think = function( self )
            local alpha = self:GetAlpha()
            if self:IsHovered() then
                if alpha < 255 then
                    self:SetAlpha( math.Clamp(alpha + ((FrameTime() * 6) * 255), 175, 255) )
                end
            else
                if alpha > 175 then 
                    self:SetAlpha( math.Clamp(alpha - ((FrameTime() * 6) * 255), 175, 255) )
                end
            end
        end

        btn.DoClick = function()
            f.OpenRegimentMain( reg, ijadgfijopdsag )
        end

        c:AddPanel( p )
    end


end