require_relative './lib/invalid_move_error.rb'
require_relative './lib/pieces.rb'
require_relative './lib/board_renderer_text.rb'
require_relative './lib/board.rb'
require_relative './lib/player.rb'
require_relative './lib/game.rb'

b = Board.start_chess
g = Game.new(
  b, 
  Player.new(:black), 
  Player.new(:white),
  BoardRendererText
)
g.play