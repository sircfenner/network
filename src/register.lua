local RunService = game:GetService("RunService")

local Event = require(script.Parent.Event)
local Function = require(script.Parent.Function)

local DIR = script.Parent
local DIR_NAME_EVENTS = "RemoteEvents"
local DIR_NAME_FUNCTIONS = "RemoteFunctions"

local ERR_NO_EVENT = "RemoteEvent `%s` was not registered"
local ERR_NO_FUNCTION = "RemoteFunction `%s` was not registered"
local ERR_INVALID_KIND = "Invalid remote type registered for key `%s`"

local function register(remotes)
	local remoteEventsFolder
	local remoteFunctionsFolder

	if RunService:IsServer() then
		remoteEventsFolder = Instance.new("Folder")
		remoteEventsFolder.Name = DIR_NAME_EVENTS
		remoteEventsFolder.Parent = DIR
		remoteFunctionsFolder = Instance.new("Folder")
		remoteFunctionsFolder.Name = DIR_NAME_FUNCTIONS
		remoteFunctionsFolder.Parent = DIR
	else
		remoteEventsFolder = DIR:WaitForChild(DIR_NAME_EVENTS)
		remoteFunctionsFolder = DIR:WaitForChild(DIR_NAME_FUNCTIONS)
	end

	if RunService:IsServer() then
		for name, kind in pairs(remotes) do
			if kind == Event then
				local remote = Instance.new("RemoteEvent")
				remote.Name = name
				remote.Parent = remoteEventsFolder
			elseif kind == Function then
				local remote = Instance.new("RemoteFunction")
				remote.Name = name
				remote.Parent = remoteFunctionsFolder
			else
				error(string.format(ERR_INVALID_KIND, name))
			end
		end
	else
		for name, kind in pairs(remotes) do
			if kind == Event then
				remoteEventsFolder:WaitForChild(name)
			elseif kind == Function then
				remoteFunctionsFolder:WaitForChild(name)
			else
				error(string.format(ERR_INVALID_KIND, name))
			end
		end
	end

	local function getEvent(name)
		local remote = remoteEventsFolder:FindFirstChild(name)
		if remote ~= nil then
			return remote
		end
		error(string.format(ERR_NO_EVENT, name))
	end

	local function getFunction(name)
		local remote = remoteFunctionsFolder:FindFirstChild(name)
		if remote ~= nil then
			return remote
		end
		error(string.format(ERR_NO_FUNCTION, name))
	end

	return {
		getEvent = getEvent,
		getFunction = getFunction,
	}
end

return register
