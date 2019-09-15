require 'matrix'

class TicTacToe

  def initialize(player = 'X')
    @player = player
    @board = Matrix.build(3) { ' ' }
    @computer_player = @player == 'O' ? 'X' : 'O'
    @columns = ('A'..'C').to_a

    print_board
  end

  def print_board
    puts "    #{@columns.join(' | ')}"
    puts '   -----------'

    @board.row_vectors.each_with_index do |row, index|
      puts "#{index + 1} | #{row.to_a.join(' | ')} |"
      puts '   -----------'
    end
  end
end

puts 'Welcome to Tic-Tac-Toe!'
puts 'Select player: X or O'
player = gets.chomp.upcase

TicTacToe.new(player)
