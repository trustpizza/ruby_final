class BoardRendererText
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def render
    system('clear')
    puts '  1 2 3 4 5 6 6 8'
    8.times do |r|
      puts '  ---------------'
      print "#{(r + 97).chr} "
      8.times do |c|
        piece = board[[r, c]]
        print "#{board[[r, c]]} "
      end
      puts ''
    end
    puts '  ---------------'
  end
end
