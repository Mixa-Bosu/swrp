Falcon = Falcon or {}

net.Receive("FALCON:MESSAGE:GLOBAL", function()
	local message = net.ReadTable()

	local sortedMessage = {}

	for _, msgPart in pairs( message ) do
		table.insert( sortedMessage, msgPart[1] )
		table.insert( sortedMessage, msgPart[2] )
	end	
	chat.AddText( unpack(sortedMessage) )
end	)