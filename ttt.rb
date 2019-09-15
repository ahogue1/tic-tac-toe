require 'matrix'

class TicTacToe

  def initialize
    puts 'Welcome to Tic-Tac-Toe!'
    puts 'Select player: X or O'
    @player = gets.chomp.upcase

    @board = Matrix.build(3) { ' ' }
    @computer_player = @player == 'O' ? 'X' : 'O'
    @columns = ('A'..'C').to_a

    @player == 'O' ? computer_move : player_move
  end

  def player_move
    empty_squares = get_empty_squares
    print_board

    puts 'Where do you want to move?'
    print '> '
    square = gets.chomp

    move_column = @columns.index(square[0]&.upcase)
    move_row = square[1].to_i - 1

    unless empty_squares.any? [move_row, move_column]
      puts 'Invalid Selection, select an empty space'
      return player_move
    end

    @board[move_row, move_column] = @player

    if is_winner?(@player)
      game_over("Congratulations! #{@player} wins!")
    elsif empty_squares.empty?
      game_over('Draw game: no more moves')
    else
      computer_move
    end
  end

  def computer_move
    empty_squares = get_empty_squares

    unless empty_squares.empty?
      move = empty_squares.sample
      puts "#{@computer_player} selected #{@columns[move[1]]}#{move[0] + 1}"
      @board[move[0], move[1]] = @computer_player
    end

    if is_winner?(@computer_player)
      game_over("#{@computer_player} wins! Better luck next time!")
    elsif empty_squares.empty?
      game_over('Draw game: no more moves')
    else
      player_move
    end
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

  def game_over(message)
    print_board
    puts message
  end

end

TicTacToe.new
