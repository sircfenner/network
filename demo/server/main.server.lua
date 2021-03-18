local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Remotes)

local testEvent = Remotes.getEvent("testEvent")
local testFunction = Remotes.getFunction("testFunction")

testEvent.OnServerEvent:Connect(function(player, message)
	print(string.format("%s [%i] sent: %q", player.Name, player.UserId, message))
end)

testFunction.OnServerInvoke = function(player, foo)
	return player.UserId + foo
end
