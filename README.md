# Usage
Place the Network library in a shared location such as ReplicatedStorage.

## Registering remotes
Use `Network.register` to centrally define which RemoteEvents and RemoteFunctions the project uses. This will either create the instances (on the server) or wait for them to exist (on the client).

The recommended workflow is to register events and functions within a single ModuleScript in a shared location. 

```Lua
-- ReplicatedStorage/Remotes
local Network = require(Vendor.Network)

return Network.register({
	fooEvent = Network.Event,
	barFunction = Network.Function,
})
```

## Accessing remotes
`Network.register` returns a table with two functions: `getEvent` and `getFunction`. These are used to access the RemoteEvents and RemoteFunctions.

```Lua
-- ServerScriptService/main
local Remotes = require(ReplicatedStorage.Remotes)
local fooEvent = Remotes.getEvent("fooEvent")

fooEvent.OnServerEvent:Connect(function(player, ...)
	print(player, ...)
end)
```
```Lua
-- StarterPlayerScripts/main
local Remotes = require(ReplicatedStorage.Remotes)
local fooEvent = Remotes.getEvent("fooEvent")

fooEvent:FireServer("Hello, world!")
```
<br>

# Installation

