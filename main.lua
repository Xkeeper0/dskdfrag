-- Gamestate manager
Gamestate	= require "hump.gamestate"


gamestates	= {}
gamestates.Game			= require "gamestates.game"

function love.load(arg)
	-- Register the gamestate events
	Gamestate.switch(gamestates.Game)
	Gamestate.registerEvents()

	fonts			= {}
	fonts.big		= love.graphics.newFont(60)
	fonts.normal	= love.graphics.newFont(30)
	fonts.small		= love.graphics.newFont(20)
	fonts.tiny		= love.graphics.newFont(15)
	fonts.micro		= love.graphics.newFont(10)

	screenMode		= {}
	screenMode.width, screenMode.height, screenMode.flags	= love.window.getMode()

end
