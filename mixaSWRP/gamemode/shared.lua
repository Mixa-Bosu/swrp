
GM.Name 	= "starwarsrp"
GM.Author 	= "Falcon"
GM.Email 	= "kota.casper.gould@gmail.com"

DeriveGamemode( "sandbox" )

function includeFiles( scanDirectory, isGamemode )
	isGamemode = isGamemode or false
	local queue = { scanDirectory }
	while #queue > 0 do
		for _, directory in pairs( queue ) do
			local files, directories = file.Find( directory .. "/*", "LUA" )
			for _, fileName in pairs( files ) do
				if fileName != "shared.lua" and fileName != "init.lua" and fileName != "cl_init.lua" then
					local relativePath = directory .. "/" .. fileName
					if isGamemode then
						relativePath = string.gsub( directory .. "/" .. fileName, GM.FolderName .. "/gamemode/", "" )
					end
					if string.match( fileName, "^sv" ) then
						if SERVER then
							include( relativePath )
						end
					end
					if string.match( fileName, "^sh" ) then
						AddCSLuaFile( relativePath )
						include( relativePath )
					end
					if string.match( fileName, "^cl" ) then
						AddCSLuaFile( relativePath )
						if CLIENT then
							include( relativePath )
						end
					end
				end
			end
			for _, subdirectory in pairs( directories ) do
				table.insert( queue, directory .. "/" .. subdirectory )
			end
			table.RemoveByValue( queue, directory )
		end
	end
end
includeFiles( GM.FolderName .. "/gamemode", true )

function SortNewData( data )
	local nextData = {}
	table.insert(nextData, data)
	while (#nextData > 0) do
		for id, tbl in pairs( nextData ) do
			for keys, vals in pairs( tbl ) do
				local dataType = type(vals)
				if dataType == "table" then
					table.insert(nextData, vals)
				elseif dataType == "string" then
					local result = util.JSONToTable( vals )
					if result then
						tbl[keys] = result
					end

					local checkNumber = tonumber( vals )
					if checkNumber then
						tbl[keys] = checkNumber
					end
				end
			end
			table.remove(nextData, id)
		end
	end
end

Falcon = Falcon or {}
Falcon.Config = {}
Falcon.Config.Default = {}

Falcon.Config.Default.RegimentData = {
	name = "Recruits",
	description = "The newborns.",
	color = Color( 220, 220, 220 ),
	abbreviation = "REC", 
	department = 0,
}

local entMeta = FindMetaTable("Entity")
local plyMeta = FindMetaTable("Player")

function plyMeta:Nick()
	return self:GetNWString('FALCON:NICK', "")
end

function plyMeta:GetName()
	return self:Nick()
end

function plyMeta:GetNick()
	return self:Nick()
end


if SERVER then
	function plyMeta:SetName( name )
		self:SetNWString('FALCON:NICK', name or '')
	end
end


function entMeta:GetAnglesTo( pos2 )
	local pos1 = self:GetPos()

	local diffX = pos2.x - pos1.x
	local diffY = pos2.y - pos1.y
	local doubleAng = math.atan2(diffY, diffX) * (180/math.pi)

	return Angle( 0, doubleAng, 0 )
end

function table.QuickSort( tbl )
	local newTbl = {}
	local runningI = 1
	for id, data in pairs( tbl ) do
		newTbl[id] = data
	end

	return newTbl
end

function entMeta:CalculateDistance( pos2 )
	local pos1 = self:GetPos()
	return math.sqrt( ((pos2.x - pos1.x) ^ 2) + ((pos2.y - pos1.y) ^ 2) )
end

function CalculateDistance( pos1, pos2 )
	return math.sqrt( ((pos2.x - pos1.x) ^ 2) + ((pos2.y - pos1.y) ^ 2) )
end

if CLIENT then
	local w, h = ScrW(), ScrH()
	local neededW = w * 0.05

	function plyMeta:IsLookingAt( otherEnt )
		if not otherEnt or not otherEnt:IsValid() then return false end
		local pos = otherEnt:GetPos()
		local mins, maxs = otherEnt:GetCollisionBounds()
		local newMins, newMaxs = pos + mins, pos + maxs
		local minsToScreen, maxsToScreen = newMins:ToScreen(), newMaxs:ToScreen()
		if not minsToScreen.visible and not maxsToScreen.visible then return false end
		local needW = (w/2)
		local needY = (h/2)
		if ((needW < minsToScreen.x + neededW) and (needW > maxsToScreen.x - neededW) or (needW > minsToScreen.x - neededW) and (needW < maxsToScreen.x + neededW)) and (needY < minsToScreen.y + neededW) and (needY > maxsToScreen.y - neededW) then
			return true
		end
		return false
	end	
end
