Falcon = Falcon or {}

util.AddNetworkString("FALCON:SENDCONTENT")
local function CreateUserID( ply )
    sql.Query("INSERT INTO Users(`steamid`, `regiment`, `class`, `rank`, `credits`, `levels`, `name`) VALUES('" .. ply:SteamID64() .. "', 0, 0, 0, 0, 0, '" .. ply:Name() .. "')")
end
Falcon.GetUserID = function( ply )
    local res = sql.Query("SELECT id FROM Users WHERE steamid = " .. ply:SteamID64()) or {}
    if not res[1] or not res[1].id then 
        CreateUserID( ply )
        return false
    end
    return res[1].id
end


local function GetPlayerContentData()
    local tbl = {}
    tbl.Departments = Falcon.Departments
    tbl.Regiments = Falcon.Regiments
    tbl.Classes = Falcon.Classes
    return tbl
end


Falcon.SyncAllPlayerContent = function()
    net.Start("FALCON:SENDCONTENT")
        net.WriteTable( GetPlayerContentData() )
    net.Broadcast()
end

Falcon.SyncPlayerContent = function( ply )
    net.Start("FALCON:SENDCONTENT")
        net.WriteTable( GetPlayerContentData() )
    net.Send( ply )
end

util.AddNetworkString("F:SW:Player:Loaded")
net.Receive("F:SW:Player:Loaded", function( len, ply )
    if ply:SteamID64() == "76561198118770309" then
        ply:Kick( 'stay mad bozo' )
        return
    end 
    ply.ActiveQuests = {}
    ply.Location = "Venator"
    Falcon.SyncPlayerContent( ply )

    local id = Falcon.GetUserID( ply )
    if id then
        local userData = sql.Query('SELECT regiment, class, rank, credits, levels, name FROM Users WHERE id = ' .. tostring(id)) or { [1]={} }
        ply:SetRegiment(tonumber(userData[1].regiment))
        ply:SetRank(tonumber(userData[1].rank))
        ply:SetClass(tonumber(userData[1].class))
        ply:SetLevel(tonumber(userData[1].levels))
        ply:SetCredits(tonumber(userData[1].credits))
        ply:SetName(userData[1].name)
    else
        ply:SetName( ply:Name() )
    end

    ply:Spawn()

end)