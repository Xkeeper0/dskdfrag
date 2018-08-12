local Game		= {}

function Game:enter()
end

function Game:draw()
	love.graphics.print("a game, probably. wow", 100, 100)
end

function Game:update(dt)
end

function Game:keypressed(key, code)
	print("press", key, code)
end

return Game
