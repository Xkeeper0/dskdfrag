local Game		= {}

-- Stats for the current game (if any, who knows what goes here)
local gameStats	= nil
-- Layout of clusters, probably?
local gameDisk	= {}
-- Files for the game, I guess.
local gameFiles	= {}
-- Work area clusters
local workArea	= {}


function Game:init()
	-- @TODO in the future, maybe some way to specify new game settings...
	local boardSize	= { w = 10, h = 5 }
	local numFiles	= 5


end


function Game:enter(previous, newGame)
	-- Generate a new game if one was requested or we have none yet
	newGame = newGame and newGame or (gameStats == nil)
	if newGame then
		-- Of note is that this will run the first time we enter anyway,
		-- because :init is called. but whatever!! im coder!!!!!
		self:init()
	end
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
