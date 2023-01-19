require 'json'
require_relative './board_renderer_text'
require 'pry-byebug'

class Game
  attr_reader :player1, :player2, :board, :renderer
  attr_accessor :current_player

  def initialize(board, player1, player2, _current_player = nil)
    @board = board
    @renderer = BoardRendererText.new(board)
    @player1 = player1
    @player2 = player2
    @current_player = @player1

    start_game
  end

  def swap_player!
    self.current_player = (current_player == player1 ? player2 : player1)
  end

  def start_game
    puts "Type 'y' to load game or press enter to start:"
    answer = gets.chomp.downcase

    load_game if answer == 'y'
    play if answer != 'y'
    play
  end

  def load_game
    file = File.read('save_file.json')
    hash = JSON.parse(file)

    @board = Marshal.load(hash['board'])
    @renderer = BoardRendererText.new(board)
    @player1 = Marshal.load(hash['player1'])
    @player2 = Marshal.load(hash['player2'])
    @current_player = Marshal.load(hash['current_player'])

    play
  end

  def play
    until over?
      renderer.render
      puts "It's #{current_player.color}'s turn"
      puts "#{current_player.color} is in check." if board.in_check?(current_player.color)

      take_turn
      swap_player!
      save_game(board, player1, player2, current_player)
    end

    swap_player!
    puts "Game over! The winner is: #{current_player.color}"
    renderer.render
  end

  def over?
    board.checkmate?(current_player.color)
    puts "#{current_player} has lost :("
  end

  def take_turn
    start_pos = nil
    # Prompt current player to enter a starting pos
    loop do
      puts "Select a piece to move by typing 'LetterNumber [i.e. G1]' where G is the row and Number is the column: "
      start_pos = get_piece

      break if (board[start_pos].color == current_player.color) && board[start_pos].safe_moves.any?

      puts "Did not select a #{current_player.color} piece."
    end

    # Prompt current player to enter an ending pos
    loop do
      puts 'Select a position to move to'
      puts "Available Moves Are #{board[start_pos].readable_safe_moves}"

      end_pos = current_player.get_pos

      # Move the piece
      begin
        board.move_piece(start_pos, end_pos)
        break
      rescue StandardError
        redo
      end
    end
  end

  private

  def get_piece
    # Error with null inputs
    loop do
      loc = current_player.get_pos

      return loc unless (board[loc].color == current_player.color) && board[loc].safe_moves.empty?

      puts 'Select a piece with available moves:'

    rescue StandardError
      puts 'Error, select again'
      redo
    end
  end

  def save_game(board, player1, player2, current_player)
    save_file = {}
    save_file[:board] = Marshal.dump(board)
    save_file[:player1] = Marshal.dump(player1)
    save_file[:player2] = Marshal.dump(player2)
    save_file[:current_player] = Marshal.dump(current_player)

    file_name = 'save_file.json'
    File.open(file_name, 'w') do |item|
      item.write(save_file.to_json)
    end
  end
end
