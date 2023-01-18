class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_pos

    pos = gets.chomp.split("")

    pos[0] = pos[0].ord - 97
    pos[1] = pos[1].to_i - 1
    pos

  end
end