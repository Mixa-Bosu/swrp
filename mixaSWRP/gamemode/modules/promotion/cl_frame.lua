Falcon = Falcon or {}
Falcon.Promotion = Falcon.Promotion or {}

local f = Falcon.Promotion

f.OpenFrame = function()
    local content, fr = Falcon.UI.Presets.Frames.CreateBaseFrame( 0.75, 0.7, 0.125, 0.15, {
        shouldAnimate = true,
        animSpeed = 6,
        text = "FALCON'S WHITELIST",
    }  )
    Falcon.UI.Presets.Buttons.ExitButton( fr )
    f.CreateMain( content )
end

net.Receive("FALCON:F2:OPEN", function()
    f.OpenFrame()
end)