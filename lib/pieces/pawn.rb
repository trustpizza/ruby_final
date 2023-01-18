class Pawn < Piece
  def forward_dir
    color == :black ? 1 : -1
  end

  def at_start?
    color == :black && current_r == 1 || 
      color == :white && current_r == 6
  end

  def available_moves
    # move forward 1
    moves = []

    one_forward = [current_r + forward_dir, current_c]
    if board.empty?(one_forward)
      moves << one_forward
    end

    # if on the start line, move forward 2
    two_forward = [current_r + (forward_dir * 2), current_c]
    if board.empty?(two_forward) && board.empty?(one_forward) && at_start?
      moves << two_forward
    end      
   
    # if enemy diag
    diag_left = [current_r + forward_dir, current_c + 1]
    diag_right = [current_r + forward_dir, current_c - 1]
    if enemy?(diag_left)
      moves << diag_left
    end
    if enemy?(diag_right)
      moves << diag_right
    end

    moves.select {|m| board.in_bounds?(m) }
  end

  def to_s
    color == :black ? "♟" : "♙"
  end
end