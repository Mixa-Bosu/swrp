Falcon = Falcon or {}
Falcon.Overview = Falcon.Overview or {}

local f = Falcon.Overview

local color_black = Color( 0, 0, 0 )
local whiteish = Color( 255, 255, 255 )
local color_grey = Color( 155, 155, 155, 255 )

f.OpenOverview = function( contentPnl, reg, regid )
    local w, h = contentPnl:GetWide(), contentPnl:GetTall()
    
    local desc = vgui.Create('DPanel', contentPnl)
    desc:SetSize( w * 0.7, h * 0.4 )
    desc:SetPos( 0, h * 0.025 )
    desc.Paint = function( self, w, h )
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

        draw.DrawText( "DESCRIPTION", "F17", w * 0.5, h * 0.01, whiteish, TEXT_ALIGN_CENTER )
    end
    local descText = vgui.Create('DLabel', desc)
    descText:SetSize( desc:GetWide() * 0.98, desc:GetTall() * 0.8 )
    descText:SetPos( desc:GetWide() * 0.01, desc:GetTall() * 0.2 )
    descText:SetWrap( true )
    descText:SetContentAlignment( 7 )
    descText:SetFont( "F8" )
    descText:SetText( reg.description )



    local commander = vgui.Create("DPanel", contentPnl)
    commander:SetSize( w * 0.29, h * 0.4 )
    commander:SetPos( w * 0.71, h * 0.025 )
    commander.Paint = function( self, w, h )
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

        draw.DrawText( "COMMANDER", "F17", w * 0.5, h * 0.01, whiteish, TEXT_ALIGN_CENTER )
    end

    local dep = GetRegimentDepartment( regid )
    local rankTblForRank = Falcon.Departments[dep].ranks
    local highestOfficer = {}
    local officersOnlineC = 0
    for _, mem in pairs( reg.members ) do
        if table.IsEmpty(highestOfficer) or highestOfficer.rank < mem.rank then
            highestOfficer = mem
        end

        if rankTblForRank[mem.rank].clearance >= 3 then
            officersOnlineC = officersOnlineC + 1
        end
    end

    if highestOfficer and not table.IsEmpty(highestOfficer) then
        local mdlCont, mdl, mdlBack = Falcon.UI.Presets.Models.CreateHeadModel( commander, 0.95, 0.95, 0.025, 0.025, {} )
        mdlBack.Paint = nil
        local _, mdl2, mdlBack = Falcon.UI.Presets.Models.CreateHeadModel( commander, 0.95, 0.95, 0.025, 0.025, {} )
        mdlBack.Paint = nil
        function mdl:LayoutEntity() return end
        mdl:SetFOV( 10 )
        mdl:SetLookAt( Vector(0, 0, 65) )
        mdl:SetCamPos( Vector(120, 0, 70) )

        function mdl2:LayoutEntity() return end
        mdl2:SetFOV( 10 )
        mdl2:SetLookAt( Vector(0, 0, 65) )
        mdl2:SetCamPos( Vector(120, 0, 70) )

        if highestOfficer.class == 0 then
            local rank = highestOfficer.rank
            local cl = Falcon.Departments[dep].ranks[highestOfficer.rank].clearance
            mdl:SetModel( reg.loadouts[cl].model )
            mdl2:SetModel( reg.loadouts[cl].model )
            mdl2.Entity:SetMaterial("ace/sw/hologram")
        else
            local clModel = reg.classes[highestOfficer.class].model
            mdl:SetModel( clModel )
            mdl2:SetModel( clModel )
            mdl2.Entity:SetMaterial("ace/sw/hologram")
        end

        local text = vgui.Create("DPanel", commander)
        text:SetSize( commander:GetWide() * 0.95, commander:GetTall() * 0.125 )
        text:SetPos( commander:GetWide() * 0.025, commander:GetTall() * 0.865 )
        text.Paint = function( self, w, h )
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
    
            draw.DrawText( highestOfficer.name, "F12", w * 0.5, h * 0.01, whiteish, TEXT_ALIGN_CENTER )
        end
    end

    local totalMembersC = table.Count( reg.members )
    local onlineCount = {}

    for _, playe in pairs( player.GetAll() ) do
        if reg.members[playe:Nick()] then
            table.insert(onlineCount, playe)
        end
    end
    
    local totalMembers = vgui.Create("DLabel", contentPnl)
    totalMembers:SetSize( w * 0.495, h * 0.075 )
    totalMembers:SetPos( 0, h * 0.45 )
    totalMembers:SetFont( "F18" )
    totalMembers:SetText('URMORM1')
    totalMembers:SetContentAlignment(8)
    totalMembers:SetText( tostring(totalMembersC) .. " MEMBER[S]" )
    totalMembers.Paint = function( self, w, h )
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

    local officersOnline = vgui.Create("DLabel", contentPnl)
    officersOnline:SetSize( w * 0.495, h * 0.075 )
    officersOnline:SetPos( w * 0.505, h * 0.45 )
    officersOnline:SetFont( "F18" )
    officersOnline:SetContentAlignment(8)
    officersOnline:SetText( tostring(officersOnlineC) .. " OFFICER[S]" )
    officersOnline.Paint = function( self, w, h )
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



    local onlineMembers = vgui.Create('DPanel', contentPnl)
    onlineMembers:SetSize( w * 0.32, h * 0.446 )
    onlineMembers:SetPos( 0, h * 0.555 )
    onlineMembers.Paint = function( self, w, h )
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

        draw.DrawText( "ONLINE MEMBERS", "F17", w * 0.5, h * 0.01, whiteish, TEXT_ALIGN_CENTER )
    end

    local onlinePlayers = vgui.Create('DScrollPanel', onlineMembers)
    onlinePlayers:SetSize( onlineMembers:GetWide() * 0.989, onlineMembers:GetTall() * 0.825 )
    onlinePlayers:SetPos( onlineMembers:GetWide() * 0.005, onlineMembers:GetTall() * 0.165 )

    local oMW, oMH = onlineMembers:GetWide(), onlineMembers:GetTall()
    for _, ply in SortedPairsByMemberValue(onlineCount, "rank", true) do
        local member = vgui.Create("DPanel", onlinePlayers)
        member:SetSize( oMW, oMH * 0.18 )
        member:Dock( TOP )
        member:DockMargin( oMW * 0.01, oMH * 0.01, oMW * 0.01, 0 )
        member.Paint = function( self, w, h )
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
    
            draw.DrawText( ply:Nick(), "F15", w * 0.5, h * 0.005, whiteish, TEXT_ALIGN_CENTER )
            draw.DrawText( Falcon.Departments[dep].ranks[ply:GetRank()].name, "F8", w * 0.5, h * 0.55, color_grey, TEXT_ALIGN_CENTER )
        end
    end 

    local challenges = vgui.Create('DPanel', contentPnl)
    challenges:SetSize( w * 0.66, h * 0.446 )
    challenges:SetPos( w * 0.34, h * 0.555 )
    challenges.Paint = function( self, w, h )
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

        draw.DrawText( "CHALLENGES", "F17", w * 0.5, h * 0.01, whiteish, TEXT_ALIGN_CENTER )
        draw.DrawText( "COMING SOON", "F14", w * 0.5, h * 0.4, whiteish, TEXT_ALIGN_CENTER )

    end

    local oMW, oMH = challenges:GetWide(), challenges:GetTall()

    -- for i = 1, 4 do
    --     local challenge = vgui.Create("DPanel", challenges)
    --     challenge:SetSize( oMW, oMH * 0.19 )
    --     challenge:Dock( TOP )
    --     challenge:DockMargin( oMW * 0.01, oMH * 0.0175, oMW * 0.01, 0 )
        
    -- end 
end

f.OpenMembers = function( contentPnl, reg, regid )
    local w, h = contentPnl:GetWide(), contentPnl:GetTall()
    local dep = GetRegimentDepartment( regid )

    local members = vgui.Create('DPanel', contentPnl)
    members:SetSize( w * 0.5, h * 0.975 )
    members:SetPos( 0, h * 0.0125 )
    members.Paint = nil

    if not table.IsEmpty(reg.members) then
        local modelOfPlayer, actualModel, backPnlModel = Falcon.UI.Presets.Models.CreateFullModel(contentPnl, 0.4875, 0.9, 0.51, 0.05, {})
        function actualModel:LayoutEntity() return end
        actualModel:SetFOV( 30 )
        actualModel:SetLookAt( Vector(0, 0, 35) )
        actualModel:SetCamPos( Vector(120, 0, 40) )
        actualModel:SetModel( reg.loadouts[1].model )
        modelOfPlayer.Paint = nil

        backPnlModel.Paint = function( self, w, h )
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

        local w, h = members:GetWide(), members:GetTall()
        for _, mem in SortedPairsByMemberValue(reg.members, "rank", true) do
            local memberPnl = vgui.Create('DPanel', members)
            memberPnl:SetSize( w, h * 0.1 )
            memberPnl:Dock( TOP )
            memberPnl:DockMargin( 0, 0, 0, h * 0.004 )
            memberPnl.Paint = function( self, w, h )
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

                draw.DrawText(mem.name, "F17", w * 0.133, h * 0.025, color_white, TEXT_ALIGN_LEFT)
                local rannk = "Recruit [REC]"
                print(Falcon.Departments[dep])
                if mem.rank > 0 then
                    rannk = Falcon.Departments[dep].ranks[mem.rank].name .. " [" .. Falcon.Departments[dep].ranks[mem.rank].abr .. "]"
                end
                draw.DrawText(rannk, "F9", w * 0.133, h * 0.52, color_grey, TEXT_ALIGN_LEFT)
                
                local class = ""
                if mem.class > 0 then
                    class = Falcon.Classes[mem.class].name
                end 
                draw.DrawText(class, "F9", w * 0.5565, h * 0.52, color_grey, TEXT_ALIGN_CENTER)
                -- draw.DrawText(Falcon.Departments[reg.department].ranks[mem.rank].name .. " [" .. Falcon.Departments[reg.department].ranks[mem.rank].abr .. "]", "F9", w * 0.99, h * 0.52, color_grey, TEXT_ALIGN_RIGHT)

            end
            memberPnl.OnCursorEntered = function( self )
                if mem.class == 0 then
                    local rank = mem.rank
                    local cl = Falcon.Departments[dep].ranks[mem.rank].clearance
                    actualModel:SetModel( reg.loadouts[cl].model )
                else
                    local clModel = reg.classes[mem.class].model
                    actualModel:SetModel( clModel )
                end
            end 
        end
    end
end