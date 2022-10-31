class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_pos
    gets
      .chomp
      .split(",")
      .map {|part| part.to_i}
  end
end