Falcon = Falcon or {}
Falcon.Promotion = Falcon.Promotion or {}
Falcon.Promotion[2] = {}

local f = Falcon.Promotion
local clText = { "ENLISTED", "NCO", "JO", "SO", "FO" }
f.OpenAdmin = function( content )
    local ply = LocalPlayer()
    local w, h = content:GetWide(), content:GetTall()

    if f.GlobalModel and f.GlobalModel:IsValid() then
        f.GlobalModel.SortPlayers( function( ply )
            return true
        end )
    end
    

    local regiments = vgui.Create( "DListView", content )
    regiments:SetSize( w * 0.25, (h * 0.925) - (w * 0.031) )
    regiments:SetPos( w * 0.01, w * 0.015 )
    regiments:SetMultiSelect( false )
    regiments:AddColumn( "ID" )
    regiments:AddColumn( "Regiment" ):SetWidth( regiments:GetWide() * 0.9 )
    for id, regTbl in pairs( Falcon.Regiments ) do 
        local row = regiments:AddLine( id, regTbl.name .. " [" .. regTbl.abbreviation .. "]" )
    end
    F4PaintListView( regiments )

    regiments.GetRegimentTable = function( shouldOverride )
        local row = regiments:GetSelectedLine()
        local id = id or regiments:GetLines()[row]:GetValue(1)

        if not shouldOverride and f.HasPlayerSelected then
            id = f.HasPlayerSelected:GetRegiment()
        end 
        local regTbl = Falcon.Regiments[id]
        return regTbl
    end
    f[2].Regiment = regiments

    local setReg = Falcon.UI.Presets.Buttons.CreateConditionalButton( content, function(self)
        if regiments:GetSelectedLine() and f.HasPlayerSelected then
            return true
        end
        return false
    end, 0.25, 0.06, 0.01, 0.915, {
        text = "SET REGIMENT",
        click = function( self )
            net.Start("FALCON:ADMIN:REGIMENT:SET")
                net.WriteEntity( f.HasPlayerSelected )
                net.WriteInt( regiments:GetLines()[regiments:GetSelectedLine()]:GetValue(1), 32 )
            net.SendToServer()
        end,
    } )


    local ranks = vgui.Create( "DListView", content )
    ranks:SetSize( w * 0.25, (h * 0.45) - (w * 0.031) )
    ranks:SetPos( w * 0.265, w * 0.015 )
    ranks:SetMultiSelect( false )
    ranks:AddColumn( "ID" )
    ranks:AddColumn( "Rank" ):SetWidth( ranks:GetWide() * 0.45 )
    ranks:AddColumn( "Officer Type" ):SetWidth( ranks:GetWide() * 0.45 )
    f[2].Rank = ranks
    local setRank = Falcon.UI.Presets.Buttons.CreateConditionalButton( content, function(self)
        if ranks:GetSelectedLine() and f.HasPlayerSelected then
            return true
        end
        return false
    end, 0.25, 0.06, 0.265, 0.43, {
        text = "SET RANK",
        click = function( self )
            net.Start("FALCON:ADMIN:RANK:SET")
                net.WriteEntity( f.HasPlayerSelected )
                net.WriteInt( ranks:GetLines()[ranks:GetSelectedLine()]:GetValue(1), 32 )
            net.SendToServer()
        end
    } )
    F4PaintListView( ranks )

    local classes = vgui.Create( "DListView", content )
    classes:SetSize( w * 0.25, (h * 0.45) - (w * 0.031) )
    classes:SetPos( w * 0.265, (h * 0.52125) - (w * 0.015) )
    classes:SetMultiSelect( false )
    classes:AddColumn( "ID" )
    classes:AddColumn( "Class" ):SetWidth( classes:GetWide() * 0.9 )
    f[2].Classes = classes
    local setClass = Falcon.UI.Presets.Buttons.CreateConditionalButton( content, function(self)
        if classes:GetSelectedLine() and f.HasPlayerSelected then
            return true
        end
        return false
    end, 0.25, 0.06, 0.265, 0.915, { 
        text = "SET CLASS",
        click = function( self )
            net.Start("FALCON:ADMIN:CLASS:SET")
                net.WriteEntity( f.HasPlayerSelected )
                net.WriteInt( classes:GetLines()[classes:GetSelectedLine()].ClassID, 32 )
            net.SendToServer()
        end
    } )
    F4PaintListView( classes )

    regiments.OnRowSelected = function(self, rowIndex, row)
        local mdl = f.GlobalModel
        local id = row:GetValue(1)
        local regData = self.GetRegimentTable( true )

        local mdLFODGl = Falcon.Config.Default.RegimentData.model or "models/jajoff/sps/alpha/tc13j/coloured_regular02.mdl"
        if f.HasPlayerSelected and f.HasPlayerSelected:IsValid() and f.HasPlayerSelected:GetRegiment() > 0 and regData.loadouts then
            mdLFODGl = regData.loadouts[1].model
        end
        mdl.Regiment = regData.name .. " [" .. regData.abbreviation .. "]"
        mdl:SetModel( mdLFODGl )
    end

    ranks.OnRowSelected = function(self, rowIndex, row)
        if not regiments:GetSelectedLine() then return end
        local mdl = f.GlobalModel
        local clearance = row.Clearance
        local regData = regiments.GetRegimentTable()

        mdl:SetModel( regData.loadouts[clearance].model )
    end

    classes.OnRowSelected = function(self, rowIndex, row)
        if not regiments:GetSelectedLine() then return end
        local mdl = f.GlobalModel
        local classID = row.ClassID
        local regData = regiments.GetRegimentTable()
        if not regData.classes or classID == 0 then return end
        mdl:SetModel( regData.classes[classID].model )
    end


    if f.HasPlayerSelected and f.HasPlayerSelected:IsValid() then
        ranks:Clear()
        local regTbl = Falcon.Regiments[f.HasPlayerSelected:GetRegiment()]
        local dep = GetRegimentDepartment( f.HasPlayerSelected:GetRegiment() )
        for id, rank in SortedPairs( Falcon.Departments[dep].ranks, true ) do
            local row = ranks:AddLine( id, rank.name .. " [" .. rank.abr .. "]", clText[rank.clearance] )
            row.Clearance = rank.clearance
        end
        F4PaintListView( ranks )

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