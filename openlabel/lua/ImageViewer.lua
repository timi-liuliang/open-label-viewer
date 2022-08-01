local object ={}

-- start
function object:start()
end

-- update
function object:update()
end

-- on click
function object:onMouseButtonDown()
	local display = self:getNode("Display")
	Log:error(display)
	if display ~= nil then
		display:setTextureRes("D:/test.png")
	end
end

return setmetatable(object, Object)
