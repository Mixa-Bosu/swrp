
include( 'shared.lua' )

Falcon = Falcon or {}
Falcon.Player = Falcon.Player or {}
Falcon.Departments = Falcon.Departments or {}
Falcon.Regiments = Falcon.Regiments or {}
Falcon.Classes = Falcon.Classes or {}

theRepublicLogo = Material('sr/tr.png')

function GM:InitPostEntity()
	local ply = LocalPlayer()
	if ply.Loaded then return end

    net.Start("F:SW:Player:Loaded")
    net.SendToServer()

	local maxStamina = ply:GetMaxSprint()
    ply.CurStaminaLeft = maxStamina

end

for i = 1, 60 do
	surface.CreateFont( "F" .. tostring(i), {
		font = "Teko",
		size = ScreenScale( i )
	})
end

for i = 1, 60 do
	surface.CreateFont( "S" .. tostring(i), {
		font = "Aurek-Besh",
		size = ScreenScale( i )
	})
end

-- for i = 1, 60 do
-- 	surface.CreateFont( "F" .. tostring(i), {
-- 		font = "Arial",
-- 		size = ScreenScale( i * 0.5 )
-- 	})
-- end

net.Receive("FALCON:SENDCONTENT", function()
	local newTbl = net.ReadTable()
	local ply = LocalPlayer()
	
	SortNewData( newTbl )
	Falcon.Departments = newTbl.Departments
	Falcon.Regiments = newTbl.Regiments
	Falcon.Classes = newTbl.Classes

	for _, reg in pairs( Falcon.Regiments ) do
		for _, lod in pairs( reg.loadouts or {} ) do
			util.PrecacheModel( lod.model )
		end	
		for _, classes in pairs( reg.classes or {} ) do
			util.PrecacheModel( classes.model )
		end
	end	

	if not ply.Loaded then
		Falcon.Character.OpenFrame()
		ply.Loaded = true
	end

end)

local lightGray = Color( 120, 120, 120 )
local lightishGray = Color( 100, 100, 100 )
local lightisherGray = Color( 80, 80, 80 )
local lightishererGray = Color( 60, 60, 60 )
local color_white = Color( 255, 255, 255 )
local hallowNIg = Color( 12, 12, 12, 195 )
function F4PaintListView( listview )
	listview.Paint = function( self, w, h )
		surface.SetDrawColor( hallowNIg )
		surface.DrawRect( 0, 0, w, h )
	end
	for _, lines in pairs( listview:GetLines() ) do
		lines.Paint = function( self, w, h )
			if self:IsSelected() then
				color = lightGray
			elseif self:IsHovered() then
				color = lightishGray
			elseif self:GetAltLine() then
				color = lightisherGray
			else
				color = lightishererGray
			end
			surface.SetDrawColor( color )
			surface.DrawRect( 0, 0, w, h )
		end
		for _, text in pairs( lines.Columns ) do
			text:SetFont("F5")
			text:SetTextColor( color_white )
			text:SetContentAlignment( 5 )
		end
	end

	for _, tabs in pairs( listview["Columns"] ) do
		tabs.Header:SetFont( "F7" )
		tabs.Header:SetTextColor( Color( 255, 255, 255 ) )
		tabs.Header.Paint = function( self, w, h )
			draw.TexturedQuad
			{
				texture = surface.GetTextureID "vgui/gradient-u",
				color = Color(35, 35, 35, 255),
				x = 0,
				y = 0,
				w = w,
				h = h
			}
		end
	end
end


