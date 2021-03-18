local Event = newproxy(true)
getmetatable(Event).__tostring = function()
	return "<Network.Event>"
end

return Event
