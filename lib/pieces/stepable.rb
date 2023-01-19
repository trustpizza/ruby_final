module Stepable
  def available_moves
    moves = []

    move_dirs.each do |(dr, dc)|
      current_r, current_c = location

      current_r += dr
      current_c += dc
      loc = [current_r, current_c]
      next unless board.in_bounds?(loc)

      moves << loc if board.empty?(loc) || enemy?(loc)
    end
    moves
  end
end
