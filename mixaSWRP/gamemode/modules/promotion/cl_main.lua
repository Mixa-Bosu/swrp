Falcon = Falcon or {}
Falcon.Promotion = Falcon.Promotion or {}
local f = Falcon.Promotion

local color_black = Color( 0, 0, 0 )
local navBtns = { 
    {name = "User", 
    check = function()
        local ply = LocalPlayer()
        if ply:GetRegiment() > 0 then
            local department = GetRegimentDepartment( ply:GetRegiment() )
            local rankType = Falcon.Departments[department].ranks[ply:GetRank()].clearance
            if rankType > 1 then
                return true
            end
            return false
        end
        return false
    end,
    click=function(pnl) 
        f.OpenUser( pnl )
    end},
    {name = "Admin", 
    check = function()
        local ply = LocalPlayer()
        if ply:IsAdmin() then
            return true
        end
        return false
    end,
    click=function(pnl) 
        f.OpenAdmin( pnl )
    end},
}
local clText = { "ENLISTED", "NCO", "JO", "SO", "FO" }
f.CreateMain = function( parent )
    f.HasPlayerSelected = false
    local ply = LocalPlayer()
    local w, h = parent:GetWide(), parent:GetTall()
    local nav = vgui.Create("DPanel", parent)
    nav:SetSize( w * 0.95, h * 0.05 )
    nav:SetPos( w * 0.014, h * 0.025 )
    nav.Paint = nil

    local content = vgui.Create("DPanel", parent)
    content:SetSize( w * 0.972, (h * 0.93) - (w * 0.015) )
    content:SetPos( w * 0.014, h * 0.075 )
    content.Paint = function( self, w, h )
        surface.SetDrawColor( color_black.r, color_black.g, color_black.b, 200 )
        surface.DrawRect( 0, 0, w, h )
    end

    local w, h = parent:GetWide(), content:GetTall()
    local players = vgui.Create( "DListView", content )
    players:SetSize( w * 0.2675, (h) - (w * 0.02) )
    players:SetPos( w * 0.01, w * 0.01 )
    players:SetMultiSelect( false )
    players:AddColumn( "ID" ):SetWidth( players:GetWide() / 1000 )
    players:AddColumn( "Name" )
    players:AddColumn( "Rank" )
    players:AddColumn( "Regiment" )
    players:AddColumn( "Class" )

        
    local otherContentPnl = vgui.Create("DPanel", parent)
    otherContentPnl:SetSize( w * 0.685, h )
    otherContentPnl:SetPos( w * 0.3, content:GetY() )
    otherContentPnl.Paint = nil
    Falcon.UI.Presets.Buttons.CreateHorizontalButtons( nav, {
        w = 0.1,
        h = 0.4,
        font = "F13",
        dock = LEFT,
        fade = true,
        shouldStart = 2,
        click = function()
            otherContentPnl:Clear()
        end
    }, navBtns, otherContentPnl )

    local mdle, mdl = Falcon.UI.Presets.Models.CreateFullModel( content, 0.315, 0.9525, 0.675, 0.0225)
    f.GlobalModel = mdl
    mdle.Paint = function( self, w, h )
        draw.DrawText( mdl.Text or "", "F30", w * 0.5, h * 0.675, Color(255,255,255,255), TEXT_ALIGN_CENTER )
        draw.DrawText( mdl.Regiment or "", "F18", w * 0.5, h * 0.775, Color(255,255,255,255), TEXT_ALIGN_CENTER )
    end
    mdl:SetModel( ply:GetModel() )
    mdl.SortPlayers = function( check )
        players:Clear()
        for id, ply in pairs( player.GetAll() ) do 
            if check then
                local c = check( ply )
                if not c then continue end
            end

            local name = 'NO CLASS'
            if ply:GetClass() > 0 then
                name = Falcon.Classes[Falcon.Regiments[ply:GetRegiment()].classes[ply:GetClass()].class].name
            end

            local department = GetRegimentDepartment( ply:GetRegiment() )
            local row = players:AddLine( id, ply:Nick(), Falcon.Departments[department].ranks[ply:GetRank()].name, Falcon.Regiments[ply:GetRegiment()].name, name )
            row.Entity = ply
        end
        F4PaintListView( players )
    end
    mdl.SortPlayers()
    function mdl:LayoutEntity( ent )
    end
    mdl:SetCamPos( Vector( 50, 0, 60 ) )

    players.OnRowSelected = function(self, rowIndex, row)
        local ply = row.Entity
        local buttonindex = nav.CurrentActiveButton
        mdl.Text = ply:Nick()
        f.HasPlayerSelected = ply

        if buttonindex then
            local id = buttonindex.ID
            if id == 1 then
                mdl:SetModel( ply:GetModel() )
            elseif id == 2 then
                local ranks = f[2].Rank
                ranks:Clear()
                local regTbl = Falcon.Regiments[ply:GetRegiment()]
                local dep = GetRegimentDepartment( ply:GetRegiment() )

                for id, rank in SortedPairs( Falcon.Departments[dep].ranks, true ) do
                    local row = ranks:AddLine( id, rank.name .. " [" .. rank.abr .. "]", clText[rank.clearance] )
                    row.Clearance = rank.clearance
                end
                F4PaintListView( ranks )
    
                local classes = f[2].Classes
                classes:Clear()
                local row = classes:AddLine( 0, "NO CLASS" )
                row.ClassID = 0
                local runningI = 1
                for id, class in pairs( regTbl.classes or {} ) do
                    local cl = Falcon.Classes[class.class]
                    local row = classes:AddLine( runningI, cl.name )
                    row.ClassID = id
                    runningI = runningI + 1
                end
                F4PaintListView( classes )
            end
        end 
        
    end
end


PrintTable(Falcon.Regiments)