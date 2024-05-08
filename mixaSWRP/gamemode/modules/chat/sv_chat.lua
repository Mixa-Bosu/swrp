Falcon = Falcon or {}


local chatCommands = {}
chatCommands["/ooc"] = {
    text = {
        { Color(240, 240, 240), "[OOC] " },
        { 
        function( ply )             
            return Falcon.Regiments[ply:GetRegiment()].color 
        end, 
        function( ply ) 
            local dep = GetRegimentDepartment( ply:GetRegiment() )
            return Falcon.Departments[dep].ranks[ply:GetRank()].abr .. " " .. ply:Nick() .. ":" 
        end },
        { Color(230, 230, 230), "TEXT" },
    },
    check = function( targetPly, ply )
        -- if targetPly:GetPos():DistToSqr( ply:GetPos() ) > 5000000 then
            -- return false
        -- end
        return true
    end
}
chatCommands["//"] = "/ooc"
chatCommands["!ooc"] = "/ooc"

chatCommands["/comms"] = {
    text = {
        { Color(240, 240, 240), "[COMMS] " },
        { 
        function( ply ) 
            local dep = GetRegimentDepartment( ply:GetRegiment() )
            
            return Falcon.Regiments[ply:GetRegiment()].color 
        end,
        function( ply ) 
            local dep = GetRegimentDepartment( ply:GetRegiment() )

            return Falcon.Departments[dep].ranks[ply:GetRank()].abr .. " " .. ply:Nick() .. ":" 
        end },
        { Color(230, 230, 230), "TEXT" },
    },
    check = function( targetPly, ply )
        return true
    end
}

util.AddNetworkString("FALCON:MESSAGE:GLOBAL")
local color_white = Color( 230, 230, 230 )
local color_grey = Color( 25, 25, 25 )
local color_blue = Color( 25, 105, 195 )

function GM:PlayerSay( ply, text, team )
    local message = {}

    local newCommand = string.Explode(" ", text) or {}
    local commandText = string.lower( newCommand[1] )
    local valueText = ""

    if not string.find(commandText,"/") and not string.find(commandText,"!") then
        valueText = " " .. commandText
    end

    for id, text in pairs( newCommand ) do
        if id == 1 then continue end

        valueText = valueText .. " " .. text
    end

    if valueText == "" then return false end

    if team then
        if string.find(commandText,"/") or string.find(commandText,"!") then return false end
        local reg = Falcon.Regiments[ply:GetRegiment()]
        local dep = GetRegimentDepartment( ply:GetRegiment() )
        local rank = Falcon.Departments[dep].ranks[ply:GetRank()]
        table.insert( message, { color_blue, "[REGIMENTAL COMMS] " } )
        table.insert( message, { reg.color, rank.abr .. " " .. ply:Nick() .. ":" } )
        table.insert( message, { color_white, valueText } )

        for _, play in pairs( player.GetAll() ) do
            if play:GetRegiment() ~= ply:GetRegiment() then continue end
            net.Start( "FALCON:MESSAGE:GLOBAL" )
                net.WriteTable( message )
            net.Send( play )
        end
    else
        local chatCommand = chatCommands[commandText]
        local commandData = chatCommand

        if not chatCommand then
            if string.find(commandText,"/") or string.find(commandText,"!") then return false end
            local reg = Falcon.Regiments[ply:GetRegiment()]
            local dep = GetRegimentDepartment( ply:GetRegiment() )
            local rank = Falcon.Departments[dep].ranks[ply:GetRank()]
            table.insert( message, { color_grey, "[LOCAL] " } )
            table.insert( message, { reg.color, rank.abr .. " " .. ply:Nick() .. ":" } )
            table.insert( message, { color_white, valueText } )

            for _, play in pairs( player.GetAll() ) do
                if play:GetPos():DistToSqr( ply:GetPos() ) > 5000000 then continue end
                net.Start( "FALCON:MESSAGE:GLOBAL" )
                    net.WriteTable( message )
                net.Send( play )
            end

            return false
        else
            if type(chatCommand) == "string" then
                commandData = chatCommands[chatCommand]
            end
            local textRequirements = commandData.text
            for _, textNeeded in pairs( textRequirements ) do
                local stringMessage = ""
                local colorOfMessage = color_white
                if type(textNeeded[1]) == "function" then
                    colorOfMessage = textNeeded[1]( ply )
                else
                    colorOfMessage = textNeeded[1]
                end

                if type(textNeeded[2]) == "function" then
                    stringMessage = textNeeded[2]( ply )
                else
                    stringMessage = textNeeded[2]
                    if stringMessage == "TEXT" then
                        stringMessage = valueText
                    end 
                end

                table.insert( message, { colorOfMessage, stringMessage } )
            end 
        end

        if not table.IsEmpty( message ) then
            for _, play in pairs( player.GetAll() ) do
                local check = commandData.check( play, ply )
                if not check then continue end
                net.Start( "FALCON:MESSAGE:GLOBAL" )
                    net.WriteTable( message )
                net.Send( play )
            end
        end
    end 
    
    return false
end 

util.AddNetworkString("FALCON:REPORT:OPEN")
hook.Add("PlayerSay", "Ayo!Commands!", function( ply, text, team )
    print(ply:SteamID(), ply:Name(), ply:Nick(), text )
    local textExplodedNword = string.Explode(" ", text)
    local lower = string.lower( textExplodedNword[1] or "" )
    if string.find(lower,"/") or string.find(lower,"!") or string.find(lower,"@") then 
        local para2String = ""
        for i = 2, #textExplodedNword do
            local addSpace = true
            if i == #textExplodedNword then
                addSpace = false
            end
            para2String = para2String .. textExplodedNword[i]

            if addSpace then
                para2String = para2String .. " "
            end
        end
        -- if lower == "/report" or lower == "!report" or lower == "@" then
        --     net.Start("FALCON:REPORT:OPEN")
        --         if lower == "@" and para2String ~= "" then
        --             net.WriteString( para2String )
        --         end
        --     net.Send( ply )
        --     return false
        -- end
        if lower == "/name" or lower == "!name" then
            if ply.nextNameDelay and ply.nextNameDelay > CurTime() then return end
            local name = para2String
            if #name > 32 or #name < 0 then return end
            sql.Query("UPDATE Users SET name = '" .. tostring(name) .. "' WHERE steamid = " .. ply:SteamID64())
            ply:SetName( name )

            ply.nextNameDelay = CurTime() + 10

            return false
        end
        if lower == "/setspawn" or lower == "!setspawn" then
            local pos = ply:GetPos() - Vector( 0, 0, 15 )
            if #para2String < 3 then
                local message = {
                    {color_white, "'".. tostring(para2String) .. "' IS NOT DESCRIPTIVE ENOUGH. PLEASE TRY AGAIN."}
                }
                net.Start( "FALCON:MESSAGE:GLOBAL" )
                    net.WriteTable( message )
                net.Send( ply )
                return
            end
            local regimentId
            local regimentName = ""
            for is, reg in pairs( Falcon.Regiments ) do
                if string.find( string.lower(reg.name), string.lower(para2String) ) then
                    regimentId = reg.id
                    regimentName = reg.name
                    break
                end
            end
            if not regimentId then
                local message = {
                    {color_white, "WE FAILED TO CREATE A SPAWN POINT FOR '".. tostring(para2String) .. "'"}
                }
                net.Start( "FALCON:MESSAGE:GLOBAL" )
                    net.WriteTable( message )
                net.Send( ply )
                return
            end
            local spawn = sql.Query('SELECT * FROM Spawns_Regiments WHERE regiment = ' .. tostring(regimentId)) or {}
            if spawn[1] then

            else
                sql.Query( 'INSERT INTO Spawns_Regiments(`x`, `y`, `z`, `regiment`) VALUES(' .. pos.x .. ', ' .. pos.y .. ', ' .. pos.z .. ', ' .. regimentId .. ')')
                local message = {
                    {color_white, "YOU HAVE SUCCESSFULLY MADE A SPAWN FOR '" .. tostring(regimentName) .. "'"}
                }
                net.Start( "FALCON:MESSAGE:GLOBAL" )
                    net.WriteTable( message )
                net.Send( ply )
            end
            return false
        end
        if not chatCommands[lower] then
            return false
        end 
    end
end)
-- local heal = ulx.command( "Chat", "ulx asay", function()end, "@" )
