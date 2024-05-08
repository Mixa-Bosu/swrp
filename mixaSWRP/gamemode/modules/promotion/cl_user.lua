Falcon = Falcon or {}
Falcon.Promotion = Falcon.Promotion or {}
Falcon.Promotion[1] = {}
local f = Falcon.Promotion

local clText = { "ENLISTED", "NCO", "JO", "SO", "FO" }
f.OpenUser = function( content )
    local ply = LocalPlayer()
    local w, h = content:GetWide(), content:GetTall()
    local reg = ply:GetRegiment()
    f.GlobalModel.SortPlayers( function( ply )
        if ply:GetRegiment() == reg then
            return true
        end
    end )
    local invBtn = Falcon.UI.Presets.Buttons.CreateConditionalButton( content, function(self)
        return true
    end, 0.5, 0.06, 0.01, 0.015, {
        text = 'INVITE USER [UNSUPPORTED]'
    } )
    invBtn:SetPos( w * 0.01, (w * 0.015) )

    local ranks = vgui.Create( "DListView", content )
    ranks:SetSize( w * 0.5, (h * 0.45) - (w * 0.031) )
    ranks:SetPos( w * 0.01, (h * 0.065) + (w * 0.015) )
    ranks:SetMultiSelect( false )
    ranks:AddColumn( "ID" )
    ranks:AddColumn( "Rank" ):SetWidth( ranks:GetWide() * 0.45 )
    ranks:AddColumn( "Officer Type" ):SetWidth( ranks:GetWide() * 0.45 )

    local dep = GetRegimentDepartment( reg )
    for id, rank in SortedPairs( Falcon.Departments[ dep ].ranks, true ) do
        if ply:GetRank() <= id then continue end
        ranks:AddLine( id, rank.name .. " [" .. rank.abr .. "]", clText[rank.clearance] )
    end
    F4PaintListView( ranks )

    f[1].Rank = ranks

    local classes = vgui.Create( "DListView", content )
    classes:SetSize( w * 0.5, (h * 0.45) - (w * 0.031) )
    classes:SetPos( w * 0.01, (h * 0.475) + (w * 0.015) )
    classes:SetMultiSelect( false )
    classes:AddColumn( "ID" )
    classes:AddColumn( "Classes" ):SetWidth( ranks:GetWide() * 0.9 )
    classes:AddLine( 0, "NO CLASS" )
    for id, class in pairs( Falcon.Regiments[reg].classes or {} ) do
        local cl = Falcon.Classes[class.class]
        local row = classes:AddLine( id, cl.name )
        row.ClassID = id
    end
    F4PaintListView(classes)
    f[1].Class = classes

    local setRank = Falcon.UI.Presets.Buttons.CreateConditionalButton( content, function(self)
        return true
    end, 0.2475, 0.06, 0.01, 0.915, {
        text = 'SET RANK',
        click = function( self )
            net.Start("FALCON:USER:CLASS:SET")
                net.WriteEntity( f.HasPlayerSelected )
                net.WriteInt( classes:GetLines()[classes:GetSelectedLine()].ClassID, 32 )
            net.SendToServer()
        end
    } )

    local setClass = Falcon.UI.Presets.Buttons.CreateConditionalButton( content, function(self)
        return true
    end, 0.2475, 0.06, 0.262, 0.915, {
        text = 'SET CLASS',
        click = function( self )
            net.Start("FALCON:USER:RANK:SET")
                net.WriteEntity( f.HasPlayerSelected )
                net.WriteInt( classes:GetLines()[classes:GetSelectedLine()].ClassID, 32 )
            net.SendToServer()
        end
    } )
end