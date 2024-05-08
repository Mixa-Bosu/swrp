Falcon = Falcon or {}
Falcon.Overview = Falcon.Overview or {}

local f = Falcon.Overview

f.OpenContent = function( content )
    local wC, hC = content:GetWide(), content:GetTall()
    local c = vgui.Create( "DPanel", content )
    c:SetSize( wC * 0.975, hC * 0.95 )
    c:SetPos( wC * 0.0125, hC * 0.025 )
    c.Paint = nil
    f.OpenRegimentInfo( c )

    return c
end
f.OpenOverviewFrame = function()
    local content, fr = Falcon.UI.Presets.Frames.CreateBaseFrame( 0.6, 0.5, 0, 0, {
        shouldAnimate = true,
        text = "REGIMENTS",
    } )
    fr:Center()

    Falcon.UI.Presets.Buttons.ExitButton( fr )

    local c = f.OpenContent( content )

    f.Frame = fr
end

net.Receive("FALCON:OPEN:F4MENU", function()
    f.OpenOverviewFrame()
end)