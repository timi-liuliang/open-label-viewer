local object ={}

-- start
function object:start()
end

-- update
function object:update()
end

-- on click
function object:onMouseButtonDown()
	Log:error("test")
end

return setmetatable(object, Object)
