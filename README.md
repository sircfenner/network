# Motivation
Creating remotes from code facilitates keeping more of your project on your filesystem. It avoids the need to create the instances manually in Studio or use special files in external tools such as Rojo.

This is good for keeping a project clean, easy to maintain, and fast to iterate on, especially for workflows which mainly do not involve Roblox Studio.

<br>

# Installation

## Rojo

Either add this repository to your project as a submodule or build it from source using the `default.project.json`.

## Studio

Insert the latest .rbxm build from releases into Roblox Studio.

<br>

# Usage
Place the Network library in a shared location such as ReplicatedStorage.

## Registering remotes
Use `Network.register` to centrally define which RemoteEvents and RemoteFunctions the project uses. This will either create the instances (on the server) or wait for them to exist (on the client).

The `Network.Event` and `Network.Function` markers are used to indicate the type of remote object that should be created. Note that an event and a function cannot have the same name due to how Lua tables work.

The recommended workflow is to register events and functions in a ModuleScript in a shared location. 

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

## Examples
Check out the demo project in this repository to see a working example. This can be synced or built with `demo.project.json` found in this repository.