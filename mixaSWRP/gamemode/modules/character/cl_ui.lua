Falcon = Falcon or {}
Falcon.Character = Falcon.Character or {}

local f = Falcon.Character
local startingCamLookAt = Vector(0, -30, 55)
local startingCamPos = Vector(120, 65, 50)
local currentCamLookAt = startingCamLookAt
local currentCamPos = startingCamPos

local color_white = Color( 255, 255, 255, 255 )
local color_white_2 = Color( 177, 177, 177, 255 )
local color_grey = Color( 110, 110, 110, 255 )
local color_grey2 = Color( 65, 65, 65, 255 )

local color_black = Color( 35, 35, 35, 255 )
local color_orange = Color( 195, 155, 0 )
local color_orange2 = Color( 210, 178, 0 )
local color_shadow = Color( 0, 0, 0, 245 )
local color_shadow2 = Color( 0, 0, 0, 200 )
local color_actblack = Color( 0, 0, 0 )

-- f.MakeNavigation = function( par, bodyPos, w, h )
--     local nav = vgui.Create('DPanel', par)
--     nav:SetSize(w, h * 0.2)
--     nav:Dock( BOTTOM )

--     local w, h = nav:GetSize()
--     local back = vgui.Create('DButton', nav)
--     back:SetSize(w * 0.5, h)
--     back:Dock( LEFT )
--     back:SetText( "BACK" )
--     back.DoClick = function()
--         local actualPar = par:GetParent()
--         f.OpenEditing( actualPar, bodyPos - 1, actualPar:GetSize()  )
--     end

--     local next = vgui.Create('DButton', nav)
--     next:SetSize(w * 0.5, h)
--     next:Dock( RIGHT )
--     next:SetText( "NEXT" )
--     next.DoClick = function()
--         local actualPar = par:GetParent()
--         f.OpenEditing( actualPar, bodyPos + 1, actualPar:GetSize()  )
--     end

-- end

local rep = Material( 'sr/republic.png' )
local civL = Material( 'sr/civi.png' )
f.OpenStart = function( content, w, h )

    local cont = vgui.Create('DPanel', content)
    cont:SetSize( w * 0.7, h )
    cont:SetPos( w * 0.05, 0 )
    cont.Paint = function( self, w, h )
        surface.SetDrawColor(color_white)
        surface.SetMaterial( theRepublicLogo )
        surface.DrawTexturedRect( 0, 0, w * 0.8, h * 0.1 )
    end

    -- -- FACTION
    local wC, hC = cont:GetSize()
    local factions = vgui.Create('DPanel', cont)
    factions:SetSize( wC, hC * 0.2 )
    factions:SetPos( 0, hC * 0.11 )
    factions.Paint = function( self, w, h )
        draw.DrawText( "CHARACTER CREATION", "F24", 0, 0, color_white, TEXT_ALIGN_LEFT )
        draw.DrawText( "$CHARACTER CREATION", "S5", 0, h * 0.25, color_white_2, TEXT_ALIGN_LEFT )
        draw.DrawText( "FACTION", "F17", w * 0.06, h * 0.31, color_white, TEXT_ALIGN_LEFT )
    end
    local w, h = factions:GetSize()
    local gar = vgui.Create('DButton', factions)
    gar:SetSize( w * 0.15, w * 0.15 )
    gar:SetPos( w * 0.22, h * 0.4 )
    gar:SetAlpha( 80 )
    gar.Paint = function( self, w, h )
        surface.SetDrawColor(color_white)
        draw.NoTexture()
        surface.SetMaterial( rep )
        surface.DrawTexturedRect( 0, 0, w, h )
    end
    gar.Think = function( self )
        if self:IsHovered() then
            self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 10) * 255), 80, 255) )
        else
            self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 10) * 255), 80, 255) )
        end
    end
    local jedi = vgui.Create('DButton', factions)
    jedi:SetSize( w * 0.15, w * 0.15 )
    jedi:SetPos( w * 0.4, h * 0.4 )
    jedi.Paint = function( self, w, h )
        surface.SetDrawColor(color_white)
        draw.NoTexture()
        surface.SetMaterial( jediOrder )
        surface.DrawTexturedRect( 0, 0, w, h )
    end
    jedi.Think = function( self )
        if self:IsHovered() then
            self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 10) * 255), 80, 255) )
        else
            self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 10) * 255), 80, 255) )
        end
    end
    -- ALIAS
    local activeColor = color_orange2
    local alias = vgui.Create('DPanel', cont)
    alias:SetSize( wC, hC * 0.16 )
    alias:SetPos( 0, hC * 0.24 )
    alias.Paint = function( self, w, h )
        draw.DrawText( "ALIAS", "F17", w * 0.06, h * 0.31, color_white, TEXT_ALIGN_LEFT )
    end

    local w, h = alias:GetSize()
    local entryPnl = vgui.Create('DPanel', alias)
    local aliasEntry = vgui.Create('DTextEntry', entryPnl)
    entryPnl:SetSize( w * 0.575, h * 0.35 )
    entryPnl:SetPos( w * 0.104, h * 0.6 )
    entryPnl.Paint = function( self, w, h )
        surface.SetDrawColor( activeColor )
        draw.RoundedBox( 5, 0, 0, w, h, activeColor )
        draw.RoundedBox( 5, h * 0.075, h * 0.075, w - (h * 0.15), h * 0.85, color_black )
    end
    entryPnl.Think = function( self )
        if aliasEntry:IsEditing() then
            activeColor = color_orange2
        else
            activeColor = color_white_2
        end
    end

    local w, h = entryPnl:GetSize()
    aliasEntry:SetSize( w * 0.95, h * 0.95 )
    aliasEntry:SetPos( w * 0.025, h * 0.025 )
    aliasEntry:SetFont( "F16" )
    aliasEntry:SetContentAlignment( 5 )
    aliasEntry:SetTextColor( color_white )
    aliasEntry.Paint = function( self, w, h )
        if activeColor == color_orange2 then
            self:DrawTextEntryText( color_orange, color_white_2, color_white )
        else
            self:DrawTextEntryText( activeColor, color_white_2, color_white )
        end
    end
    f.MakeNavigation( test, bodyPos, w, h )
end

local activeUniform = 1
local activeSpecies = "abednedo"
local activeBodygroups = {}
local activeSkin = 0
local bossktext = { "", "black", "blue", "green", 'red' }

local body = {
    {
        Vector(55, 0, 60),
        Vector( 120, 10, 55 ),
        18,
        Options = {
            {title="Abednedo", id="abednedo", skins={0, 1, 2}},
            {title="Dressellian", bodygroups={['head'] = 3}, id="abednedo", skins={3, 4, 5}},
            {title="Aqualish", id="aqualish", skins={0, 1, 2}},
            {title="Human", id="human_male", skins={0, 1, 2}},
            {title="Ishitib", id="ishitib", skins={0, 1, 2}},
            {title="Quarren", id="quarren", skins={0, 1, 2}},
            {title="Duros", id="rodian", skins={0, 1, 2}},
            {title="Rodian", bodygroups={['head'] = 3}, id="rodian", skins={3, 4, 5}},
            {title="Sullustan", id="sullustan", skins={0, 1, 2}},
            {title="Weequay", bodygroups={['head'] = 3}, id="sullustan", skins={3, 4, 5}},
            {title="Zabrak", id="zabrak", skins={0, 1, 2}},
            {title = "Bossk", id="bossk", skins={0, 1, 2}},
        },
        Background = "sr/kamino.png",
        Title = "Religion [RACE]",
        onApply = function( optionData )
            activeSkin = 0
            activeSpecies = optionData.id
            if optionData.bodygroups then
                activeBodygroups = table.Copy( optionData.bodygroups )
            else
                activeBodygroups = {}
            end
            f.frame:AdvancedSetModel()
        end,
        displayModel = function( optionData )
            local testLolXDFucket = optionData.id
            if testLolXDFucket == "human_male" then
                testLolXDFucket = "human"
            end

            return "models/hcn/starwars/bf/" .. testLolXDFucket .. "/" .. optionData.id .. ".mdl", optionData.bodygroups or {}
        end
    },
    {
        Vector(0, -30, 40),
        Vector(120, 65, 35),
        35,
        Options = {
            {uniform=1, title = "Wool"},
            {uniform=2, title = "Cloth"},
            {uniform=3, title = "Leather"},
            {uniform=4, title="Padding"},
            {uniform=5, title="Robe"},
        },
        Background = "sr/kamino.png",
        Title = "Uniform",
        onApply = function( optionData )
            activeUniform = optionData.uniform
            f.frame:AdvancedSetModel()
        end,
        displayModel = function( optionData )
            local uniformText = ""
            if optionData.uniform > 1 then
                uniformText = "_" .. optionData.uniform
                if activeSpecies == "bossk" then
                    uniformText = "_" .. bossktext[optionData.uniform]
                end
            end
            local testLolXDFucket = activeSpecies
            if testLolXDFucket == "human_male" then
                testLolXDFucket = "human"
            end
            return "models/hcn/starwars/bf/" .. testLolXDFucket .. "/" .. activeSpecies .. uniformText .. ".mdl", activeBodygroups or {}
        end
    },
}
local bodyPosIdk = 1
f.MakeNavigation = function( par, contentPnl, w, h )
    local nav = vgui.Create('DPanel', par)
    nav:SetSize(w, h * 0.2)
    nav:Dock( BOTTOM )

    local w, h = nav:GetSize()
    local back = vgui.Create('DButton', nav)
    back:SetSize(w * 0.5, h)
    back:Dock( LEFT )
    back:SetText( "BACK" )
    back.DoClick = function()
        if bodyPosIdk <= 1 then 
            --
            return 
        end
        bodyPosIdk = bodyPosIdk - 1
        local data = body[bodyPosIdk]
        f.frame.NextLookAt = data[1]
        f.frame.NextCamPos = data[2]
        f.frame.NextFOV = data[3]
        contentPnl:MoveTo(contentPnl:GetWide() * -1.025, 0, 0.5, 0, -1, function()
            f.OpenEditing( contentPnl, contentPnl:GetSize()  )
            contentPnl:MoveTo(0, 0, 0.75 )
        end )
    end

    local next = vgui.Create('DButton', nav)
    next:SetSize(w * 0.5, h)
    next:Dock( RIGHT )
    next:SetText( "NEXT" )
    next.DoClick = function()
        if bodyPosIdk == #body then return end
        bodyPosIdk = bodyPosIdk + 1
        local data = body[bodyPosIdk]
        f.frame.NextLookAt = data[1]
        f.frame.NextCamPos = data[2]
        f.frame.NextFOV = data[3]

        contentPnl:MoveTo(contentPnl:GetWide() * -1.025, 0, 0.5, 0, -1, function()
            f.OpenEditing( contentPnl, contentPnl:GetSize()  )
            contentPnl:MoveTo(0, 0, 0.75 )
        end )
    end


end
f.OpenEditing = function( par, w, h )
    par:Clear()

    local data = body[bodyPosIdk]

    local test = vgui.Create('DPanel', par)
    test:SetSize( w * 0.4, h * 0.4 )
    test:SetPos( w * 0.09, h * 0.23 )
    test.Paint = function( self, w, h )
        surface.DrawRectWithCorners( 0, 0, w, h  )
    end
    local w, h = test:GetSize()

    local runningY = 0
    local skinsColor = vgui.Create('DPanel', test)
    skinsColor:SetSize( w * 0.95, h * 0.2 )
    skinsColor:SetPos( w * 0.025, h * 0.75 )
    skinsColor.Paint = function( self, w, h )
        surface.DrawRectWithCorners( 0, 0, w, h  )
    end

    for id, op in pairs( data.Options ) do
        local pnl = vgui.Create('DPanel', test)
        pnl:SetSize( h * 0.27, h * 0.27 )
        pnl:SetPos( w * (0.025 + ((id-(1 + (runningY*6))) * 0.16)), h * (0.025 + (runningY * 0.355)) )
        pnl.Paint = function( self, w, h )
            surface.DrawRectWithCorners( 0, 0, w, h  )
        end
        local modal, bodygroups = data.displayModel( op )
        local mdl = vgui.Create('DModelPanel', pnl)
        mdl:SetSize( pnl:GetWide() * 0.97, pnl:GetTall() * 0.98 )
        mdl:SetPos( pnl:GetWide() * 0.015, pnl:GetTall() * 0.01 )
        mdl:SetModel( modal )
        function mdl:LayoutEntity() return end
        mdl:SetFOV( 10 )
        mdl:SetLookAt( Vector(0, 0, 65) )
        mdl:SetCamPos( Vector(120, 0, 70) )
        if not table.IsEmpty(bodygroups) then
            for bodygroupID, value in pairs( bodygroups ) do
                mdl.Entity:SetBodygroup( mdl.Entity:FindBodygroupByName(bodygroupID), value )
            end
        else
            for _, value in pairs( mdl.Entity:GetBodyGroups() ) do
                mdl.Entity:SetBodygroup( value.id, -1 )
            end
        end

        local btn = vgui.Create('DButton', pnl)
        btn:Dock( FILL )
        btn:SetText( '' )
        btn.Paint = nil
        btn.DoClick = function( self )
            data.onApply( op )
            local ent = f.frame.Entity
             if bodyPosIdk == 1 then
                skinsColor:Clear()
                for _, skin in pairs( op.skins or {} ) do
                    local s = vgui.Create("DPanel", skinsColor)
                    s:SetSize( skinsColor:GetWide() * 0.125, skinsColor:GetTall() )
                    s:Dock( LEFT )

                    local mdl = vgui.Create('DModelPanel', s)
                    mdl:SetSize( s:GetWide() * 0.98, s:GetTall() * 0.98 )
                    mdl:SetPos( s:GetWide() * 0.01, s:GetTall() * 0.01 )

                    mdl:SetModel( modal )
                    function mdl:LayoutEntity() return end
                    mdl:SetFOV( 10 )
                    mdl:SetLookAt( Vector(0, 0, 65) )
                    mdl:SetCamPos( Vector(120, 0, 70) )

                    if not table.IsEmpty(bodygroups) then
                        for bodygroupID, value in pairs( bodygroups ) do
                            mdl.Entity:SetBodygroup( mdl.Entity:FindBodygroupByName(bodygroupID), value )
                        end
                    else
                        for _, value in pairs( mdl.Entity:GetBodyGroups() ) do
                            mdl.Entity:SetBodygroup( value.id, -1 )
                        end
                    end

                    if activeSpecies == "bossk" then
                        mdl.Entity:SetSkin( skin )
                    else
                        mdl.Entity:SetBodygroup( mdl.Entity:FindBodygroupByName('head'), skin )
                    end


                    local btn = vgui.Create("DButton", s)
                    btn:Dock( FILL )
                    btn:SetText('')
                    btn.Paint = nil
                    btn.DoClick = function( self )
                        if op.id == "bossk" then
                            ent:SetSkin( skin )
                            activeSkin = skin
                        else
                            ent:SetBodygroup( ent:FindBodygroupByName('head'), skin )
                            activeBodygroups['head'] = skin
                        end
                    end
                end
            end
        end
        if activeSpecies == op.id and activeBodygroups['head'] == (op.bodygroups or {})['head'] then
            local ent = f.frame.Entity
            for _, skin in pairs( op.skins or {} ) do
                local s = vgui.Create("DPanel", skinsColor)
                s:SetSize( skinsColor:GetWide() * 0.125, skinsColor:GetTall() )
                s:Dock( LEFT )

                local mdl = vgui.Create('DModelPanel', s)
                mdl:SetSize( s:GetWide() * 0.98, s:GetTall() * 0.98 )
                mdl:SetPos( s:GetWide() * 0.01, s:GetTall() * 0.01 )

                mdl:SetModel( modal )
                function mdl:LayoutEntity() return end
                mdl:SetFOV( 10 )
                mdl:SetLookAt( Vector(0, 0, 65) )
                mdl:SetCamPos( Vector(120, 0, 70) )

                if not table.IsEmpty(bodygroups) then
                    for bodygroupID, value in pairs( bodygroups ) do
                        mdl.Entity:SetBodygroup( mdl.Entity:FindBodygroupByName(bodygroupID), value )
                    end
                else
                    for _, value in pairs( mdl.Entity:GetBodyGroups() ) do
                        mdl.Entity:SetBodygroup( value.id, -1 )
                    end
                end

                if activeSpecies == "bossk" then
                    mdl.Entity:SetSkin( skin )
                else
                    mdl.Entity:SetBodygroup( mdl.Entity:FindBodygroupByName('head'), skin )
                end


                local btn = vgui.Create("DButton", s)
                btn:Dock( FILL )
                btn:SetText('')
                btn.Paint = nil
                btn.DoClick = function( self )
                    if op.id == "bossk" then
                        ent:SetSkin( skin )
                        activeSkin = skin
                    else
                        ent:SetBodygroup( ent:FindBodygroupByName('head'), skin )
                        activeBodygroups['head'] = skin
                    end
                end
            end
        end

        if id == 6 then
            runningY = 1
        end
    end
end

f.OpenCreation = function( fr, w, h )
    local img = vgui.Create("DImage", fr)
    img:SetSize( w, h )
    img:SetImage( 'sr/kamino.png' )
    img:SetKeepAspect( true )


    local model = vgui.Create("DModelPanel", fr)
    model:Dock( FILL )
    model:SetFOV( 18 )
    model:SetLookAt( Vector(55, 0, 60) )
    model:SetCamPos( Vector( 120, 10, 55 ) )
    model.CurrentLerp = 1
    function model:LayoutEntity( ent )
        ent:FrameAdvance()
    end
    function model:Think()
        if not self.NextCamPos or not self.NextLookAt or not self.NextFOV then return end
        if not self.CurrentCamPos then
            self.CurrentCamPos = self:GetCamPos()
            self.CurrentLookAt = self:GetLookAt()
            self.CurrentFOV = self:GetFOV()
            self.CurrentLerp = 0
        end
        self.CurrentLerp = math.Clamp( self.CurrentLerp + FrameTime(), 0, 1 )

        local lerpingStuff = LerpVector( self.CurrentLerp, self.CurrentCamPos, self.NextCamPos )
        local lerpingStuff2 = LerpVector( self.CurrentLerp, self.CurrentLookAt, self.NextLookAt )
        local newFOV = Lerp( self.CurrentLerp, self.CurrentFOV, self.NextFOV )
        self:SetCamPos( lerpingStuff )
        self:SetLookAt( lerpingStuff2 )
        self:SetFOV( newFOV )

        if self.CurrentLerp == 1 then
            self.CurrentCamPos = nil
            self.CurrentLookAt = nil
            self.CurrentFOV = nil
            self.NextCamPos = nil
            self.NextLookAt = nil
            self.NextFOV = nil
            self.CurrentLerp = 0
        end
    end
    function model:AdvancedSetModel()
        local testLolXDFucket = activeSpecies
        if testLolXDFucket == "human_male" then
            testLolXDFucket = "human"
        end

        local uniformText = ""
        if activeUniform > 1 then
            uniformText = "_" .. activeUniform
            if activeSpecies == "bossk" then
                uniformText = "_" .. bossktext[activeUniform]
            end
        end

        if not self.Entity then
            self:SetModel("models/hcn/starwars/bf/" .. testLolXDFucket .. "/" .. activeSpecies .. uniformText .. ".mdl")
        else
            self.Entity:SetModel("models/hcn/starwars/bf/" .. testLolXDFucket .. "/" .. activeSpecies .. uniformText .. ".mdl")
        end
        if not table.IsEmpty(activeBodygroups) then
            for bodygroupID, value in pairs( activeBodygroups ) do
                self.Entity:SetBodygroup( self.Entity:FindBodygroupByName(bodygroupID), value )
            end
        else
            for _, value in pairs( self.Entity:GetBodyGroups() ) do
                self.Entity:SetBodygroup( value.id, -1 )
            end
        end
        self.Entity:SetSkin( activeSkin )
        -- self.Entity:SetSequence( 'menuidle')
    end
    model:AdvancedSetModel()

    f.frame = model

    local newContent = vgui.Create('DPanel', model)
    newContent:SetSize( w, h )
    newContent.Paint = nil

    
    local nav = vgui.Create('DPanel', model)
    nav:SetSize( w, h * 0.1 )
    nav:SetPos( 0, h - (h * 0.1) )
    f.MakeNavigation( nav, newContent, w, h )

    f.OpenEditing( newContent, w, h )
end

local color_lightblue = Color( 81, 81, 155, 255 )
local color_lightpurple = Color( 100, 0, 155, 255 )

f.OpenEditor = function( content, w, h )
    local fadePnl = vgui.Create("DPanel", content)
    fadePnl:SetSize( w, h )
    fadePnl:SetAlpha( 0 )
    fadePnl.Paint = function( self, w, h )
        surface.SetDrawColor( color_shadow.r, color_shadow.g, color_shadow.b, 180 )
        surface.DrawRect( 0, 0, w, h )
    end
    fadePnl.Think = function( self )
        if self.ShouldFade then
            self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 4) * 255), 0, 255) )
        else
            self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 4) * 255), 0, 255) )
        end
    end
    
    local gar = vgui.Create('DPanel', fadePnl)
    gar:SetSize( w * 0.29, h * 0.725 )
    gar:SetPos( w * 0.195, h * 0.115 )
    gar.activeColor = color_white
    gar.Paint = function( self, w, h )
        surface.SetDrawColor( color_shadow.r, color_shadow.g, color_shadow.b, 180 )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( self.activeColor )
        draw.NoTexture()
        surface.SetMaterial( rep )
        surface.DrawTexturedRect( w * 0.225, w * 0.1, w * 0.55, w * 0.55 )
        surface.DrawOutlinedRect( 0, 0, w, h )
        draw.DrawText( 'REPUBLIC', "S6", w * 0.03, h * 0.58, color_grey, TEXT_ALIGN_LEFT )
        draw.DrawText( 'GRAND ARMY OF THE REPUBLIC', "F22", w * 0.03, h * 0.59, self.activeColor, TEXT_ALIGN_LEFT )

        surface.SetDrawColor( color_grey )
        surface.DrawLine( w * 0.035, h * 0.675, w * 0.1, h * 0.675 )

        draw.DrawText( 'The Galactic Republic, also known as the Grand Republic (or simply as the Republic)', "F10", w * 0.03, h * 0.7, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( 'was a democratic union comprised of various member worlds spread across', "F10", w * 0.03, h * 0.73, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( 'light-years of space. The Grand Army of the Republic was organized under the', "F10", w * 0.03, h * 0.76, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( 'leadership of Jedi Generals who led the Republic Military against the', "F10", w * 0.03, h * 0.79, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( 'Separatist Droid Army during the Clone Wars. ', "F10", w * 0.03, h * 0.82, color_grey2, TEXT_ALIGN_LEFT )
    end
    local selectGAR = vgui.Create('DButton', gar)
    selectGAR:SetSize( gar:GetWide() * 0.94, gar:GetTall() * 0.04 )
    selectGAR:SetPos( gar:GetWide() * 0.03, gar:GetTall() * 0.9 )
    selectGAR:SetText('')
    selectGAR:SetAlpha( 35 )
    selectGAR.Paint = function( self, w, h )
        surface.SetDrawColor( color_white )
        surface.DrawLine( 0, h * 0.05, w, h * 0.05 )
        surface.DrawLine( 0, h * 0.95, w, h * 0.95 )
        draw.DrawText( 'SELECT FACTION', "F12", w * 0.5, 0, color_white, TEXT_ALIGN_CENTER )
    end
    selectGAR.Think = function( self )
        if fadePnl:GetAlpha() ~= 255 then return end
        if self:IsHovered() then
            self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 6) * 255), 35, 255) )
        else
            self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 6) * 255), 35, 255) )
        end
    end
    selectGAR.DoClick = function()
        fadePnl.ShouldFade = true
        timer.Simple(2, function()
            local content = f.frame:GetParent()
            content.next = function()
                content:Clear()
                timer.Simple(1, function()
                    f.OpenEditor( content, content:GetSize() )
                    content.ShouldFadeOut = false
                end )
            end 
            content.ShouldFadeOut = true
        end)
    end
    gar.Think = function( self )
        if fadePnl:GetAlpha() ~= 255 then return end
        if self:IsHovered() or selectGAR:IsHovered() then
            self.activeColor = color_lightblue
        else
            self.activeColor = color_white
        end
    end

    local civ = vgui.Create('DPanel', fadePnl)
    civ:SetSize( w * 0.29, h * 0.725 )
    civ:SetPos( w * 0.515, h * 0.115 )
    civ.activeColor = color_white
    civ.Paint = function( self, w, h )
        surface.SetDrawColor( color_shadow.r, color_shadow.g, color_shadow.b, 180 )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( self.activeColor )
        draw.NoTexture()
        surface.SetMaterial( civL )
        surface.DrawTexturedRect( w * 0.225, w * 0.1, w * 0.55, w * 0.55 )
        surface.DrawOutlinedRect( 0, 0, w, h )
        draw.DrawText( 'CIVILIAN', "S6", w * 0.03, h * 0.58, color_grey, TEXT_ALIGN_LEFT )
        draw.DrawText( 'FORCE SENSITIVE [CIVILIAN]', "F22", w * 0.03, h * 0.59, self.activeColor, TEXT_ALIGN_LEFT )

        surface.SetDrawColor( color_grey )
        surface.DrawLine( w * 0.035, h * 0.675, w * 0.1, h * 0.675 )

        draw.DrawText( 'Force Sensitives are civilians who have obtained powers of the force', "F10", w * 0.03, h * 0.7, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( 'through birth. Unlike alot of individuals, these force sensitive users', "F10", w * 0.03, h * 0.73, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( 'become significantly more powerful than standard non-force users.', "F10", w * 0.03, h * 0.76, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( 'Depending on the person, they determine the path they would like to lead via the', "F10", w * 0.03, h * 0.79, color_grey2, TEXT_ALIGN_LEFT )
        draw.DrawText( '"good" side or the "dark" side.', "F10", w * 0.03, h * 0.82, color_grey2, TEXT_ALIGN_LEFT )

    end
    local selectCIV = vgui.Create('DButton', civ)
    selectCIV:SetSize( civ:GetWide() * 0.94, civ:GetTall() * 0.04 )
    selectCIV:SetPos( civ:GetWide() * 0.03, civ:GetTall() * 0.9 )
    selectCIV:SetText('')
    selectCIV:SetAlpha( 35 )
    selectCIV.Paint = function( self, w, h )
        surface.SetDrawColor( color_white )
        surface.DrawLine( 0, h * 0.05, w, h * 0.05 )
        surface.DrawLine( 0, h * 0.95, w, h * 0.95 )
        draw.DrawText( 'SELECT FACTION', "F12", w * 0.5, 0, color_white, TEXT_ALIGN_CENTER )
    end
    selectCIV.Think = function( self )
        if fadePnl:GetAlpha() ~= 255 then return end
        if self:IsHovered() then
            self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 6) * 255), 35, 255) )
        else
            self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 6) * 255), 35, 255) )
        end
    end
    selectCIV.DoClick = function()
        fadePnl.ShouldFade = true
        timer.Simple(2, function()
            local content = f.frame:GetParent()
            content.next = function()
                content:Clear()
                timer.Simple(1, function()
                    f.OpenCreation( content, content:GetSize() )
                    content.ShouldFadeOut = false
                end )
            end 
            content.ShouldFadeOut = true
        end)
    end
    civ.Think = function( self )
        if fadePnl:GetAlpha() ~= 255 then return end
        if self:IsHovered() or selectCIV:IsHovered() then
            self.activeColor = color_lightpurple
        else
            self.activeColor = color_white
        end
    end
end

local cat = { 
    {
        {Name='PLAY',Click=function( nav )
            nav.next = function()
                f.SortNav( nav, 2 )
                nav.ShouldFadeOut = false
            end
            nav.ShouldFadeOut = true
        end}, 
        {Name='SETTINGS',Click=function()
        end}, 
        {Name='DISCORD',Click=function()
        end}, 
        {Name='FORUMS',Click=function()
        end}, 
        {Name='DISCONNECT',Click=function()RunConsoleCommand('disconnect')end} 
    },
    {
        {Name='CREATE',Click=function( nav )
            -- nav.next = function()
            --     nav:Remove()
            --     local content = f.frame:GetParent()
            --     timer.Simple(2, function()
            --         content.next = function()
            --             content:Clear()
            --             timer.Simple(1, function()
            --                 f.OpenEditor( content, content:GetSize() )
            --                 content.ShouldFadeOut = false
            --             end )
            --         end 
            --         content.ShouldFadeOut = true
            --     end)
            -- end
            -- nav.ShouldFadeOut = true
            -- nav.ui.FadeOut = true
            nav.next = function()
                timer.Simple(1.5, function()
                    local content = f.frame:GetParent()
                    f.OpenEditor( content, content:GetSize() )
                end)
            end
            nav.ShouldFadeOut = true
            nav.ui.FadeOut = true
        end}, 
        {Name='LOAD',Click=function()
        end}, 
        {Name='BACK',Click=function( nav )
            nav.next = function()
                f.SortNav( nav, 1 )
                nav.ShouldFadeOut = false
            end
            nav.ShouldFadeOut = true
        end}, 
    }
}
f.SortNav = function( nav, id )
    nav:Clear()
    for i, data in pairs( cat[id] ) do
        local bt = Falcon.UI.Presets.Buttons.TextButton( nav, 1, 0.135, 0, 0, {
            fade = true,
            font = 'F14',
            text = data.Name or "UNTITLED",
            click = function( self )
                data.Click( nav )
            end
        })
        bt:Dock( TOP )
        bt:SetContentAlignment( 4 )
    end
end

local galaxyMat = Material('sr/test_galaxy3.png')
local starMat = Material('sr/space_text1.jpg')
f.OpenMainMenu = function( content, w, h )
    local img = vgui.Create("DImage", content)
    img:SetSize( w, h )
    img:SetImage( 'sr/space_text1.jpg' )
    img:SetKeepAspect( true )
    f.frame = img
    f.img = img

    local pnl = vgui.Create("DModelPanel", content)
    pnl:SetSize( w, h )
    pnl:SetModel('models/props_borealis/bluebarrel001.mdl')
    function pnl:Paint( w, h )
        if ( !IsValid( self.Entity ) ) then return end
        local x, y = self:LocalToScreen( 0, 0 )

        self:LayoutEntity( self.Entity )

        local ang = self.aLookAngle
        if ( !ang ) then
            ang = ( self.vLookatPos - self.vCamPos ):Angle()
        end

        cam.Start3D( Vector( 50, 28, 22 ), Vector( -50, -50, -30 ):Angle(), self.fFOV, x, y, w, h, 5, self.FarZ )

        render.SetMaterial( galaxyMat )
        render.DrawQuadEasy( Vector( 0, 0, 0 ), Vector( 0, 0, 1 ), 84, 84, color_white, (CurTime() * 2) % 360 )

        cam.End3D()

        self.LastPaint = RealTime()
    end

 
    local idk = vgui.Create("DPanel", content)
    idk:SetSize( content:GetSize() )
    idk.Paint = function( self, w, h )
        draw.NoTexture()
        draw.TexturedQuad({
            texture = surface.GetTextureID("vgui/gradient-u"),
            color = color_actblack,
            x = 0,
            y = 0,
            w = w,
            h = h * 0.5
        })

        draw.TexturedQuad({
            texture = surface.GetTextureID("vgui/gradient-d"),
            color = color_actblack,
            x = 0,
            y = h * 0.905,
            w = w,
            h = h * 0.1
        })
        draw.TexturedQuad({
            texture = surface.GetTextureID("vgui/gradient-r"),
            color = color_actblack,
            x = w * 0.9,
            y = 0,
            w = w * 0.1,
            h = h
        })

        draw.TexturedQuad({
            texture = surface.GetTextureID("vgui/gradient-l"),
            color = color_actblack,
            x = 0,
            y = 0,
            w = w * 0.5,
            h = h
        })
        draw.TexturedQuad({
            texture = surface.GetTextureID("vgui/gradient-l"),
            color = color_actblack,
            x = 0,
            y = 0,
            w = w * 0.75,
            h = h
        })

        draw.NoTexture()
        surface.SetDrawColor(color_white)
        surface.SetMaterial( theRepublicLogo )
        surface.DrawTexturedRect( w * 0.08, h * 0.05, w * 0.18, h * 0.065 )

        draw.DrawText( "A COPY OF STAR", "S4", w * 0.098, h * 0.25, color_grey, TEXT_ALIGN_LEFT )
        draw.DrawText( "MAIN MENU", "F35", w * 0.096, h * 0.24, color_white, TEXT_ALIGN_LEFT )
        draw.DrawText( "STAR WARS ROLEPLAY", "F13", w * 0.0975, h * 0.301, color_white_2, TEXT_ALIGN_LEFT )

        surface.SetDrawColor(color_grey)
        surface.DrawLine( w * 0.055, 0, w * 0.055, h * 0.15)
        surface.DrawLine( w * 0.06, 0, w * 0.06, h * 0.15)
        
        surface.DrawLine( w * 0.055, h * 0.15, w * 0.085, h * 0.225 )
        surface.DrawLine( w * 0.06, h * 0.15, w * 0.09, h * 0.225 )

        surface.DrawLine( w * 0.09, h * 0.225, w * 0.09, h )
        surface.DrawLine( w * 0.085, h * 0.225, w * 0.085, h * 0.55 )

        surface.DrawLine( w * 0.085, h * 0.55, w * 0.05, h * 0.65 )
        surface.DrawLine( w * 0.05, h * 0.65, w * 0.05, h )
    end
    idk.Think = function( self )
        if self.FadeOut then
            self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 1) * 255), 0, 255) )
        end
    end 
    
    local w, h = idk:GetSize()
    local nav = vgui.Create('DPanel', idk)
    nav:SetSize( w * 0.15, h * 0.45 )
    nav:SetPos( w * 0.0975, h * 0.375 )
    nav.Paint = nil
    nav.Think = function( self )
        if self.ShouldFadeOut then
            self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 1) * 255), 0, 255) )
            if self:GetAlpha() == 0 then
                if self.next then
                    local shouldCancel = self.next()
                    self.next = nil
                end
            end
        else
            self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 1) * 255), 0, 255) )
        end
    end
    nav.ui = idk

    f.SortNav( nav, 1 )
end

f.OpenFrame = function()
    if f.frame and f.frame:IsValid() then return end
    local fr = vgui.Create("DFrame")
    fr:SetSize( ScrW(), ScrH() )
    fr:MakePopup()
    fr.Paint = nil

    local otherPnl = vgui.Create("DPanel", fr)
    otherPnl:SetSize( fr:GetSize() )


    local w, h = fr:GetSize()
    local contentPnl = vgui.Create('DPanel', otherPnl)
    contentPnl:SetSize( w, h )
    contentPnl:SetPos( 0, 0 )
    contentPnl.Paint = nil
    contentPnl.Think = function( self )
        if contentPnl.ShouldFadeOut then
            contentPnl:SetAlpha( math.Clamp(contentPnl:GetAlpha() - ((FrameTime() * 1.5) * 255), 0, 255) )
            if contentPnl:GetAlpha() == 0 then
                if contentPnl.next then
                    contentPnl.next()
                    contentPnl.next = nil
                end
            end
        else
            contentPnl:SetAlpha( math.Clamp(contentPnl:GetAlpha() + ((FrameTime() * 1.5) * 255), 0, 255) )
        end
    end
    Falcon.UI.Presets.Buttons.ExitButton( fr )

    otherPnl.Paint = function( self, w, h )
        if contentPnl:GetAlpha() ~= 255  then
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.DrawRect( 0, 0, w, h )
        else
        end
        -- surface.SetDrawColor(color_white)
        -- draw.NoTexture()
        -- surface.SetMaterial( theRepublicLogo )
        -- surface.DrawTexturedRect( w * 0.07, h * 0.06, w * 0.14, h * 0.0525 )
        -- draw.DrawText( "CHARACTER CREATION", "F24", w * 0.07, h * 0.12, color_white, TEXT_ALIGN_LEFT )
        -- draw.DrawText( "CHARACTER CREATION", "S5", w * 0.07, h * 0.165, color_white_2, TEXT_ALIGN_LEFT )
        -- draw.DrawText( body[bodyPosIdk].Title, "F17", w * 0.09, h * 0.1785, color_white, TEXT_ALIGN_LEFT )
    end
    
    f.OpenMainMenu( contentPnl, contentPnl:GetSize() )
end