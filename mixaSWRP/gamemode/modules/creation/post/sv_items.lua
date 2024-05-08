Falcon = Falcon or {}
Falcon.Items = Falcon.Items or {}

local function ICS( string )
    return sql.SQLStr(string) .. ", "
end

local types = {
    ["COSMETIC"] = 1,
    ["WEAPON"] = 2,
    ["ABILITY"] = 3,
}
Falcon.CreateNewItem = function( name, type )
    local robin = "`name`, `type`, `health`, `armor`, `stamina`, `bulletprotection`, `fireprotection`, `fallprotection`, `blastprotection`, `poisonprotection`, `damage`, `firerate`, `function`, `minrarity`, `maxrarity`"

    local seer = ICS(name) .. tostring(types[type]) .. ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 5"

    local str = "INSERT INTO Items( " .. robin .. " ) VALUES( " .. seer .. " )"
    sql.Query(str)

    Falcon.Items = sql.Query("SELECT * FROM Items") or {}
    SortNewData( Falcon.Items )
end

util.AddNetworkString("FALCON:ITEMS:CREATE")
net.Receive("FALCON:ITEMS:CREATE", function( len, ply )
    if not Falcon.CanCreate[ply:GetUserGroup()] then return end
    local namae = net.ReadString()
    local abr = net.ReadString()

    Falcon.CreateNewItem( namae, abr )
    Falcon.SyncAllPlayerContent()
end)
