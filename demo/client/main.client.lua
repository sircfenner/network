local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Remotes)

local testEvent = Remotes.getEvent("testEvent")
local testFunction = Remotes.getFunction("testFunction")

testEvent:FireServer("hello world")

local value = testFunction:InvokeServer(5)
print(string.format("got %i", value))
