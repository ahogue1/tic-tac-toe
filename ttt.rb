require 'matrix'

class TicTacToe

  def initialize(player = 'X')
    @player = player
    @board = Matrix.build(3) { ' ' }
    @computer_player = @player == 'O' ? 'X' : 'O'
    @columns = ('A'..'C').to_a

  end

  def get_empty_squares
    empty_squares = []
    @board.each_with_index do |square, row, col|
      empty_squares << [row, col] if square == ' '
    end

    empty_squares
  end

  def print_board
    puts "    #{@columns.join(' | ')}"
    puts '   -----------'

    @board.row_vectors.each_with_index do |row, index|
      puts "#{index + 1} | #{row.to_a.join(' | ')} |"
      puts '   -----------'
    end
  end

  def is_winner?(player)
    winning_line = Array.new(3, player)

    @board.row_vectors.each do |row|
      return true if row.to_a == winning_line
    end

    @board.column_vectors.each do |col|
      return true if col.to_a == winning_line
    end

    return true if @board.each(:diagonal).to_a == winning_line

    mirrored_board = Matrix.rows(@board.row_vectors.map{ |r| r.to_a.reverse})

    mirrored_board.each(:diagonal).to_a == winning_line
  end
end

puts 'Welcome to Tic-Tac-Toe!'
puts 'Select player: X or O'
player = gets.chomp.upcase

TicTacToe.new(player)
