
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
Falcon = Falcon or {}
Falcon.CanCreate = {
    ["superadmin"] = true
}

function GM:PlayerDisconnected( ply )
    file.Write("te.txt", "")
end

function GM:PlayerSwitchFlashlight()
    return true
end


-- -- GAYMODE 1
-- local battleTable = {}
-- battleTable.Battles = {}
-- battleTable.Participants = {
--     {
--         Name = "Global Elite Turtle",
--         Armies = { 
--             [0] = { name = "PLAYER", num = 5000, pos = Vector( 100, -150, 0 ), ang = Angle() }, 
--             [1] = { name = "NIGGA1", num = 1000, pos = Vector( 100, 0, 0 ), ang = Angle() }, 
--             [2] = { name = "NIGGA2", num = 1000, pos = Vector( 100, 150, 0 ), ang = Angle() }, 
--             [3] = { name = "NIGGA3", num = 1000, pos = Vector( 100, 300, 0 ), ang = Angle() }, 
--             [4] = { name = "NIGGA4", num = 1000, pos = Vector( 100, 450, 0 ), ang = Angle() } 
--         },
--     },
--     {
--         Name = "AI",
--         Armies = { 
--             [0] = { name = "PLAYER", num = 5000, pos = Vector( 2000, -150, 0 ), ang = Angle() }, 
--             [1] = { name = "NIGGA5", num = 300, pos = Vector( 2000, 0, 0 ), ang = Angle() }, 
--             [2] = { name = "NIGGA6", num = 300, pos = Vector( 2000, 150, 0 ), ang = Angle() }, 
--             [3] = { name = "NIGGA7", num = 300, pos = Vector( 2000, 300, 0 ), ang = Angle() }, 
--             [4] = { name = "NIGGA8", num = 300, pos = Vector( 2000, 450, 0 ), ang = Angle() } 
--         },
--     },
-- }

-- util.AddNetworkString("FALCON:GAYMODE2:SYNCDATA")
-- net.Start("FALCON:GAYMODE2:SYNCDATA")
--     net.WriteTable(battleTable.Participants)
-- net.Broadcast()

-- util.AddNetworkString("FALCON:GAYMODE2:STARTATTACK")
-- util.AddNetworkString("FALCON:GAYMODE2:ENDATTACK")

-- hook.Add("Think", "F:GAYMODE:THINK", function()
--     for id, battle in pairs( battleTable.Battles ) do
--         if battle.EndBattle > CurTime() then continue end
--         local forces = {}
--         forces.Total = 0
--         for i = 1, #battle do
--             forces[i] = 0
--             local activeForces = battle[i]
--             for armyID, _ in pairs( activeForces ) do
--                 forces[i] = forces[i] + battleTable.Participants[i].Armies[armyID].num
--             end
--             forces.Total = forces.Total + forces[i]
--         end

--         local whoWins = math.random( 1, forces.Total )
--         local participantsWon
--         print(id, "BATTLE!", whoWins)
--         PrintTable( forces )
--         for i = 1, #battle do
--             whoWins = whoWins - forces[i]
--             print(whoWins, i)
--             if whoWins > 0 then continue end
--             participantsWon = i
--             break
--         end

--         net.Start("FALCON:GAYMODE2:ENDATTACK")

--             local battleTbl = {}
--             for i = 1, #battle do
--                 if i == participantsWon then continue end
--                 battleTbl[i] = battle[i]
                
--                 local armies = battleTable.Participants[i].Armies
--                 PrintTable(armies)
--                 for armyID, _ in pairs( battle[i] ) do
--                     table.remove(armies, armyID)
--                 end

--                 -- SORT TABLES TO HAVE PROPER THINGOES
--                 battleTable.Participants[i].Armies = table.QuickSort( armies )
--                 PrintTable(battleTable.Participants[i].Armies)

--             end
--             net.WriteTable( battleTbl )
            
--         net.Broadcast()


--         table.remove( battleTable.Battles, id )
--     end
-- end)

-- net.Receive("FALCON:GAYMODE2:STARTATTACK", function( len, ply )
--     local friendly = net.ReadInt( 32 )
--     local enemy = net.ReadInt( 32 )

--     table.insert( battleTable.Battles, { {[friendly] = true}, {[enemy] = true}, EndBattle = CurTime()+1 } )
-- end)


-- util.AddNetworkString("FALCON:GAYMODE2:UPDATEMOVEMENT")
-- net.Receive("FALCON:GAYMODE2:UPDATEMOVEMENT", function( len, ply )
--     local vec = net.ReadVector()
--     local ang = net.ReadAngle()
--     local armyID = net.ReadInt( 32 )

--     local playerID = 1
--     -- for partID, d in pairs(battleTable.Participants) do
--     --     if d.Player == ply then
--     --         playerID = partID
--     --         break
--     --     end
--     -- end

--     if not playerID then return end

--     local armies = battleTable.Participants[playerID].Armies[armyID]
--     armies.pos = vec
--     armies.ang = ang

--     print(armies.pos, armies.ang)

--     for _, d in pairs(battleTable.Participants) do
--         -- if d.Player == ply then continue end
--         net.Start("FALCON:GAYMODE2:UPDATEMOVEMENT")
--             net.WriteVector( vec )
--             net.WriteInt( armyID, 32 )
--             net.WriteInt( playerID, 5 )
--         -- net.Send( d.Player )
--         net.Broadcast()
--     end
    
-- end)
