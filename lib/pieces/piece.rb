class Piece
  attr_reader :color, :board
  attr_accessor :location

  def initialize(board, location, color)
    @board = board
    @color = color
    @location = location
  end

  # Available moves that don't move us into check
  def safe_moves
    moves = []
    # Look at available moves
    available_moves.each do |move|
      # try the move
      new_board = board.dup
      new_board.move_piece!(location, move)
      # if not in check, then the move is safe
      moves << move unless new_board.in_check?(color)
    end
    moves
  end

  def readable_safe_moves
    safe_moves = safe_moves()
    moves = []

    safe_moves.each do |move|
      move[0] = (move[0] + 97).chr
      move[1] = (move[1] + 1).to_s
      moves << move.join('')
    end
    moves
  end

  def enemy?(location)
    board.in_bounds?(location) && (board[location].color != color unless board[location].color.nil?)
  end

  def friend?(location)
    board.in_bounds?(location) && board[location].color == color
  end

  def current_r
    location.first
  end

  def current_c
    location.last
  end
end
