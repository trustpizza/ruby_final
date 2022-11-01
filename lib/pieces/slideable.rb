module Slideable
  def available_moves
    moves = []

    move_dirs.each do |(dr, dc)|
      current_r, current_c = location
      #Location is an array [1,1] location[0] = current_r, location[1] = current_c

      loop do
        current_r += dr
        current_c += dc
        loc = [current_r, current_c]
        break if !board.in_bounds?(loc)
        break if friend?(loc)
        
        moves << loc if board.empty?(loc)

        if enemy?(loc)
          moves << loc
          break
        end
      end
    end
    moves.uniq  
  end
end