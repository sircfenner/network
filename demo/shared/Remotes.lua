local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Network)

return Network.register({
	testEvent = Network.Event,
	testFunction = Network.Function,
})
