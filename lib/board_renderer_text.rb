class BoardRendererText
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def render
    system('clear')
    puts "  0 1 2 3 4 5 6 7"
    8.times do |r|
      puts "  ---------------"
      print "#{r} "
      8.times do |c|
        piece = board[[r, c]]
        print "#{board[[r, c]]} "
      end
      puts ""
    end
    puts "  ---------------"
  end
end