local Function = newproxy(true)
getmetatable(Function).__tostring = function()
	return "<Network.Function>"
end

return Function
