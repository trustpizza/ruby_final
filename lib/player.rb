class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_pos
    loop do
      pos = gets.chomp.split("")

      redo unless pos.length == 2

      pos[0] = pos[0].downcase.ord - 97
      pos[1] = pos[1].to_i - 1
      return pos if pos.length == 2
    end
  end
end 