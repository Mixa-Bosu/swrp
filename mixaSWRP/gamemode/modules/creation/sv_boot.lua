Falcon = Falcon or {}

local function SQLInitialize()
    sql.Query([[CREATE TABLE IF NOT EXISTS Users
        (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            steamid TEXT,
            regiment NUMBER,
            rank NUMBER,
            class NUMBER,
            credits NUMBER,
            levels NUMBER,
            name TEXT
        ) 
    ]])
    print("Users: ", sql.TableExists("Users"))

    sql.Query([[CREATE TABLE IF NOT EXISTS Departments
        (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            ranks TEXT
        ) 
    ]])
    print("Departments: ", sql.TableExists("Departments"))

    sql.Query([[CREATE TABLE IF NOT EXISTS Regiments
        (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            abbreviation TEXT,
            model TEXT,
            color TEXT,
            loadouts TEXT,
            description TEXT,
            department NUMBER,
            hidden BOOLEAN,
            spawn TEXT,
            faction NUMBER
        ) 
    ]])
    print("Regiments: ", sql.TableExists("Regiments"))

    sql.Query([[CREATE TABLE IF NOT EXISTS Classes
        (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            weapons TEXT,
            health NUMBER,
            armor NUMBER,
            run NUMBER,
            engineer BOOLEAN,
            medic BOOLEAN,
            hidden BOOLEAN,
            description TEXT
        ) 
    ]])
    print("Classes: ", sql.TableExists("Classes"))

    sql.Query([[CREATE TABLE IF NOT EXISTS Classes_Regiments
        (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            class NUMBER,
            regiment NUMBER,
            model TEXT
        ) 
    ]])
    print("Class Regiments: ", sql.TableExists("Classes_Regiments"))

    sql.Query([[CREATE TABLE IF NOT EXISTS Spawns_Regiments
        (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            regiment NUMBER,
            x NUMBER,
            y NUMBER,
            z NUMBER
        ) 
    ]])
    print("Spawns Regiments: ", sql.TableExists("Spawns_Regiments"))

    print("SWRP Database has been connected!")

    -- Ranks
    Falcon.Departments = sql.Query("SELECT * FROM Departments") or {}
    Falcon.Departments[0] = {
        ranks = {
            [0] = {
                name = "Recruit",
                abr = "REC",
                clearance = 1,
            }
        }
    }
    SortNewData( Falcon.Departments )
    
    Falcon.Regiments = sql.Query("SELECT * FROM Regiments") or {}
    for id, reg in pairs( Falcon.Regiments ) do
        local classTbl = {}
        local c = sql.Query("SELECT * FROM Classes_Regiments WHERE regiment = " .. reg.id ) or {}
        for _, class in pairs( c ) do
            classTbl[tonumber(class.class)] = class
        end
        reg.classes = classTbl
        
        Falcon.SortMembers( id )

        team.SetUp( id, reg.Name, util.JSONToTable(reg.color) )
    end 
    Falcon.Regiments[0] = Falcon.Config.Default.RegimentData
    team.SetUp( 0, "Recruits", Color( 220, 220, 200 ) )

    SortNewData( Falcon.Regiments )

    local classes = sql.Query("SELECT * FROM Classes") or {}
    SortNewData( classes )

    local actualTbl = {}
    for _, class in pairs( classes ) do
        actualTbl[class.id] = class
    end
    Falcon.Classes = actualTbl

    Falcon.Items = sql.Query("SELECT * FROM Items") or {}
    SortNewData( Falcon.Items )
end

-- sql.Query("DROP TABLE Users")
-- SQLInitialize()

hook.Add("Initialize", "F_SQL_INIT", SQLInitialize)
