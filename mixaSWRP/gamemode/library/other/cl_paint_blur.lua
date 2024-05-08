Falcon = Falcon or {}
Falcon.UI = Falcon.UI or {}
Falcon.UI.Presets = Falcon.UI.Presets or {}
Falcon.UI.Presets.Other = Falcon.UI.Presets.Other or {}

local f = Falcon.UI.Presets.Other

-- COLORS
local color_white = Color( 255, 255, 255 )
local scrw, scrh = ScrW(), ScrH()

-- MATERIALS
local blur = Material( "pp/blurscreen" )

-- f.DrawBlur = function( x, y, w, h,  )
--     surface.SetMaterial( blur )
--     surface.SetDrawColor( color_white )

--     for i=0.33, 1, 0.33 do
--         blur:SetFloat( "$blur", (intensity or 8) * i ) -- Increase number 5 for more blur
--         blur:Recompute()
--         if ( render ) then render.UpdateScreenEffectTexture() end
--         surface.DrawTexturedRect( x, y, w, h )
--     end
-- end
local blurrrrr = Color(0,0,0,200)
local function DrawBlurRect(x, y, w, h, intensity)
	local X, Y = 0,0
     surface.SetDrawColor(255,255,255)
    surface.SetMaterial(blur)

    for i = 1, 5 do
        blur:SetFloat("$blur", (i / 4) * (intensity or 4))
        blur:Recompute()

        render.UpdateScreenEffectTexture()

        render.SetScissorRect(x, y, x+w, y+h, true)
            surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
        render.SetScissorRect(0, 0, 0, 0, false)
    end
   draw.RoundedBox( 0, x, y, w, h, blurrrrr )
   surface.SetDrawColor( 0, 0, 0 )
   
end

f.DrawBlur = DrawBlurRect