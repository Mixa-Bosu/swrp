-- Falcon = Falcon or {}
-- Falcon.Character = Falcon.Character or {}

-- local f = Falcon.Character
-- local startingCamLookAt = Vector(0, -30, 55)
-- local startingCamPos = Vector(120, 65, 50)
-- local currentCamLookAt = startingCamLookAt
-- local currentCamPos = startingCamPos
-- local body = {
--     {
--         Vector(55, 0, 60),
--         Vector( 120, 10, 55 ),
--         18,
--         Options = { "models/illusion/head/dressellian.mdl", "models/illusion/head/duros.mdl" },
--         Title = "Head",
--         onApply = function( ent, model )
--             local head = ent.Head
--             head:SetModel( model )
--         end,
--     },
--     {
--         Vector(55, 0, 60),
--         Vector( 120, 10, 55 ),
--         18,
--         Options = {},
--         Title = "Clothes",
--     },
-- }

-- local color_white = Color( 255, 255, 255, 255 )
-- local color_white_2 = Color( 195, 195, 195, 255 )
-- local color_black = Color( 35, 35, 35, 255 )
-- local color_orange = Color( 195, 155, 0 )
-- local color_orange2 = Color( 210, 178, 0 )

-- -- f.MakeNavigation = function( par, bodyPos, w, h )
-- --     local nav = vgui.Create('DPanel', par)
-- --     nav:SetSize(w, h * 0.2)
-- --     nav:Dock( BOTTOM )

-- --     local w, h = nav:GetSize()
-- --     local back = vgui.Create('DButton', nav)
-- --     back:SetSize(w * 0.5, h)
-- --     back:Dock( LEFT )
-- --     back:SetText( "BACK" )
-- --     back.DoClick = function()
-- --         local actualPar = par:GetParent()
-- --         f.OpenEditing( actualPar, bodyPos - 1, actualPar:GetSize()  )
-- --     end

-- --     local next = vgui.Create('DButton', nav)
-- --     next:SetSize(w * 0.5, h)
-- --     next:Dock( RIGHT )
-- --     next:SetText( "NEXT" )
-- --     next.DoClick = function()
-- --         local actualPar = par:GetParent()
-- --         f.OpenEditing( actualPar, bodyPos + 1, actualPar:GetSize()  )
-- --     end

-- -- end

-- -- local rep = Material( 'sr/rep.png' )
-- -- local jediOrder = Material( 'sr/jOrder.png' )
-- -- f.OpenStart = function( leftPnl, rightPnl, w, h )
-- --     leftPnl:Clear()
-- --     rightPnl:Clear()

-- --     local cont = vgui.Create('DPanel', leftPnl)
-- --     cont:SetSize( w * 0.7, h )
-- --     cont:SetPos( w * 0.05, 0 )
-- --     cont.Paint = function( self, w, h )
-- --         surface.SetDrawColor(color_white)
-- --         surface.SetMaterial( theRepublicLogo )
-- --         surface.DrawTexturedRect( 0, 0, w * 0.8, h * 0.1 ) 
-- --     end

-- --     -- FACTION
-- --     local wC, hC = cont:GetSize()
-- --     local factions = vgui.Create('DPanel', cont)
-- --     factions:SetSize( wC, hC * 0.2 )
-- --     factions:SetPos( 0, hC * 0.11 )
-- --     factions.Paint = function( self, w, h )
-- --         draw.DrawText( "CHARACTER CREATION", "F24", 0, 0, color_white, TEXT_ALIGN_LEFT )
-- --         draw.DrawText( "$CHARACTER CREATION", "S5", 0, h * 0.25, color_white_2, TEXT_ALIGN_LEFT )
-- --         draw.DrawText( "FACTION", "F17", w * 0.06, h * 0.31, color_white, TEXT_ALIGN_LEFT )
-- --     end 
-- --     local w, h = factions:GetSize()
-- --     local gar = vgui.Create('DButton', factions)
-- --     gar:SetSize( w * 0.15, w * 0.15 )
-- --     gar:SetPos( w * 0.22, h * 0.4 )
-- --     gar:SetAlpha( 80 )
-- --     gar.Paint = function( self, w, h )
-- --         surface.SetDrawColor(color_white)
-- --         draw.NoTexture()
-- --         surface.SetMaterial( rep )
-- --         surface.DrawTexturedRect( 0, 0, w, h ) 
-- --     end
-- --     gar.Think = function( self )
-- --         if self:IsHovered() then
-- --             self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 10) * 255), 80, 255) )
-- --         else
-- --             self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 10) * 255), 80, 255) )
-- --         end
-- --     end
-- --     local jedi = vgui.Create('DButton', factions)
-- --     jedi:SetSize( w * 0.15, w * 0.15 )
-- --     jedi:SetPos( w * 0.4, h * 0.4 )
-- --     jedi.Paint = function( self, w, h )
-- --         surface.SetDrawColor(color_white)
-- --         draw.NoTexture()
-- --         surface.SetMaterial( jediOrder )
-- --         surface.DrawTexturedRect( 0, 0, w, h ) 
-- --     end
-- --     jedi.Think = function( self )
-- --         if self:IsHovered() then
-- --             self:SetAlpha( math.Clamp(self:GetAlpha() + ((FrameTime() * 10) * 255), 80, 255) )
-- --         else
-- --             self:SetAlpha( math.Clamp(self:GetAlpha() - ((FrameTime() * 10) * 255), 80, 255) )
-- --         end
-- --     end
-- --     -- ALIAS
-- --     local activeColor = color_orange2
-- --     local alias = vgui.Create('DPanel', cont)
-- --     alias:SetSize( wC, hC * 0.16 )
-- --     alias:SetPos( 0, hC * 0.24 )
-- --     alias.Paint = function( self, w, h )
-- --         draw.DrawText( "ALIAS", "F17", w * 0.06, h * 0.31, color_white, TEXT_ALIGN_LEFT )
-- --     end 

-- --     local w, h = alias:GetSize()
-- --     local entryPnl = vgui.Create('DPanel', alias)
-- --     local aliasEntry = vgui.Create('DTextEntry', entryPnl)
-- --     entryPnl:SetSize( w * 0.575, h * 0.35 )
-- --     entryPnl:SetPos( w * 0.104, h * 0.6 )
-- --     entryPnl.Paint = function( self, w, h )
-- --         surface.SetDrawColor( activeColor )
-- --         draw.RoundedBox( 5, 0, 0, w, h, activeColor )
-- --         draw.RoundedBox( 5, h * 0.075, h * 0.075, w - (h * 0.15), h * 0.85, color_black )
-- --     end
-- --     entryPnl.Think = function( self )
-- --         if aliasEntry:IsEditing() then
-- --             activeColor = color_orange2
-- --         else
-- --             activeColor = color_white_2
-- --         end 
-- --     end

-- --     local w, h = entryPnl:GetSize()
-- --     aliasEntry:SetSize( w * 0.95, h * 0.95 )
-- --     aliasEntry:SetPos( w * 0.025, h * 0.025 )
-- --     aliasEntry:SetFont( "F16" )
-- --     aliasEntry:SetContentAlignment( 5 )
-- --     aliasEntry:SetTextColor( color_white )
-- --     aliasEntry.Paint = function( self, w, h )
-- --         if activeColor == color_orange2 then
-- --             self:DrawTextEntryText( color_orange, color_white_2, color_white )
-- --         else
-- --             self:DrawTextEntryText( activeColor, color_white_2, color_white )
-- --         end
-- --     end
-- --     -- f.MakeNavigation( test, bodyPos, w, h )
-- -- end 


-- local body = {
--     {
--         Vector(55, 0, 60),
--         Vector( 120, 10, 55 ),
--         18,
--         Options = { "models/illusion/head/dressellian.mdl", "models/illusion/head/duros.mdl" },
--         Title = "Head",
--         onApply = function( ent, model )
--             local head = ent.Head
--             head:SetModel( model )
--         end,
--     },
--     {
--         Vector(55, 0, 60),
--         Vector( 120, 10, 55 ),
--         18,
--         Options = { "models/player/jedi_general_male_09.mdl", "models/player/jedi_male_09_noanim.mdl", "models/templeguard/jedi_temple_07.mdl" },
--         Title = "Clothes",
--         onApply = function( ent, model )
--             local body = ent.Body
--             body:SetModel( model )
--             body:ManipulateBoneScale( body:LookupBone( "ValveBiped.Bip01_Head1" ), Vector(0, 0, 0) )
--             body:AddEffects(EF_BONEMERGE)
--         end,
--     },
-- }
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
-- f.OpenEditing = function( par, bodyPos, w, h )
--     par:Clear()
                                                                                                                                                                                                                                                  
--     local data = body[bodyPos]

--     local test = vgui.Create('DPanel', par)
--     test:SetSize( w * 0.3, h * 0.5 )

--     local w, h = test:GetSize()
--     for _, op in pairs( data.Options ) do
--         local btn = vgui.Create('DButton', test)
--         btn:SetSize( w, h * 0.15 )
--         btn:Dock( TOP )
--         btn:SetText( op )
--         btn.DoClick = function( self )
--             data.onApply( f.frame.Entity, op )
--         end     
--     end 
--     f.MakeNavigation( test, bodyPos, w, h )
-- end 

-- f.OpenFrame = function()
--     if f.frame and f.frame:IsValid() then return end
--     local fr = vgui.Create("DFrame")
--     fr:SetSize( ScrW(), ScrH() )
--     fr:MakePopup()
    

--     local model = vgui.Create("DModelPanel", fr)
--     model:Dock( FILL )
--     model:SetModel( "models/hcn/starwars/bf/sullustan/sullustan.mdl" )
--     model:SetFOV( 35 )
--     model:SetLookAt( currentCamLookAt )
--     model:SetCamPos( currentCamPos )
    
--     function model:LayoutEntity( ent )
--         ent:FrameAdvance()
--     end
--     local ent = model.Entity


--     ent.Body = ClientsideModel('models/hcn/starwars/bf/sullustan/sullustan.mdl')
--     local body = ent.Body
--     body:SetParent( ent )
--     body:SetupBones()
--     body:AddEffects( EF_BONEMERGE )
--     body:ManipulateBoneScale( ent:LookupBone('ValveBiped.Bip01_Neck1'), Vector(0,0,0) )
--     body:ManipulateBoneScale( ent:LookupBone('ValveBiped.Bip01_Head1'), Vector(0,0,0) )

--     ent.Head = ClientsideModel('models/illusion/head/sullustan.mdl')
--     local head = ent.Head
--     head:SetParent( ent )
--     head:SetupBones()
--     head:AddEffects( EF_BONEMERGE )
--     function model:OnRemove()
--         body:Remove()
--         head:Remove()
--     end 

--     function model:Paint( w, h )

--         local ent = self.Entity
-- 		if ( !IsValid( ent ) ) then return end

-- 		local x, y = self:LocalToScreen( 0, 0 )

-- 		self:LayoutEntity( ent )

-- 		local ang = self.aLookAngle
-- 		if ( !ang ) then
-- 			ang = ( self.vLookatPos - self.vCamPos ):Angle()
-- 		end

-- 		cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )

-- 			render.SuppressEngineLighting( true )
-- 			render.SetLightingOrigin( ent:GetPos() )
-- 			render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
-- 			render.SetColorModulation( self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255 )
-- 			render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) ) -- * surface.GetAlphaMultiplier()

-- 			for i = 0, 6 do
-- 				local col = self.DirectionalLight[ i ]
-- 				if ( col ) then
-- 					render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
-- 				end
-- 			end

--             if IsValid( ent.Body ) then
--                 local ent = ent.Body
--                 local normal = ent:GetUp() + Vector(0, 0, -1.4)
--                 local position = normal:Dot( ent:GetBonePosition( ent:LookupBone('ValveBiped.Bip01_Neck1') ) + Vector( 0, 0, 2 ) )
    
--                 local oldEC = render.EnableClipping( true )
--                 render.PushCustomClipPlane( normal, position )

--                 ent:DrawModel()

--                 render.PopCustomClipPlane()
--                 render.EnableClipping( oldEC )
    
--                 render.SuppressEngineLighting( false )
--             end

--             if IsValid( ent.Head ) then
--                 local head = ent.Head
--                 local normal = head:GetForward() + Vector(0, 0, -0)
--                 local position = normal:Dot( head:GetBonePosition( head:LookupBone('ValveBiped.Bip01_Neck1') ) )

--                 local oldEC = render.EnableClipping( true )
--                 render.PushCustomClipPlane( normal, position )

--                 head:DrawModel()

--                 render.PopCustomClipPlane()
--                 render.EnableClipping( oldEC )
                
--                 self:PostDrawModel( self.Entity )
--             end

            
-- 		cam.End3D()

-- 		self.LastPaint = RealTime()

-- 	end
--     model.Entity:SetSequence( 'menuidle')

--     local w, h = fr:GetSize()
--     local contentPnl = vgui.Create('DPanel', model)
--     contentPnl:SetSize( w, h )
--     contentPnl:SetPos( 0, 0 )
--     contentPnl.Paint = nil


--     local leftPnl = vgui.Create('DPanel', contentPnl)
--     leftPnl:SetSize( w * 0.45, h * 0.9 )
--     leftPnl:SetPos( w * 0.025, h * 0.04 )
--     leftPnl.Paint = nil
    
--     local r = vgui.Create('DPanel', contentPnl)
--     r:SetSize( w * 0.45, h * 0.9 )
--     r:SetPos( w * 0.525, h * 0.04 )
--     r.Paint = nil
--     local w, h = r:GetSize()

--     -- f.OpenStart( leftPnl, r, w, h )
--     f.OpenEditing( contentPnl, 1, w, h )

    
--     f.frame = model
-- end
-- f.OpenFrame()