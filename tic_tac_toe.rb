# frozen_string_literal: true

class Game
  def initialize
    @GAMEINPLAY = true
    @p1_symbol = 'X'
    @p2_symbol = '0'
    @current_symbol = @p1_symbol
    @board_size = 3
    play
  end

  def new_board
    @board = Array.new(@board_size) { Array.new(@board_size) { ' ' } }
  end

  def play
    while @GAMEINPLAY == true
      new_board
      @WINNER = false
      @turn = 0
      until @WINNER
        @turn += 1
        clear
        draw_board
        get_player_move(@current_symbol)
        clear
        draw_board
        @WINNER = check_winner? if @turn >= 5
        if @WINNER
          puts "#{@current_symbol} IS THE WINNER"
          break
        end
        if @turn >= 9 && !@WINNER
          puts 'DRAW!'
          @WINNER = true
          break
        end

        switch_player(@current_symbol)
      end
      # would you like to play a new game
      puts 'Would you like to play again? y/n'
      new_game = gets.chomp.downcase
      break @GAMEINPLAY = false if %w[n no].include?(new_game)
    end
  end

  def check_winner?
    last_player = @current_symbol
    return false if @turn < 5
    # check rows
    # a
    return true if @board[0][0] == last_player && @board[0][1] == last_player && @board[0][2] == last_player
    # b
    return true if @board[1][0] == last_player && @board[1][1] == last_player && @board[1][2] == last_player
    # c
    return true if @board[2][0] == last_player && @board[2][1] == last_player && @board[2][2] == last_player

    # check columns
    return true if @board[0][0] == last_player && @board[1][0] == last_player && @board[2][0] == last_player
    return true if @board[0][1] == last_player && @board[1][1] == last_player && @board[2][1] == last_player
    return true if @board[0][2] == last_player && @board[1][2] == last_player && @board[2][2] == last_player
    # check diag
    return true if @board[0][0] == last_player && @board[1][1] == last_player && @board[2][2] == last_player
    # check anti-Diag
    return unless @board[0][2] == last_player && @board[1][1] == last_player && @board[2][0] == last_player

    true
  end

  def clear
    system('clear')
  end

  def draw_board
    puts "'#{@current_symbol}' Turn"
    puts '  | 1 | 2 | 3 |'
    puts "a | #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"
    puts "b | #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
    puts "c | #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
  end

  def update_square(row, column, symbol)
    row_int = convert_row(row)
    @board[row_int][column] = symbol
  end

  def convert_row(row)
    case row
    when 'c'
      2
    when 'b'
      1
    when 'a'
      0
    end
  end

  def get_player_move(symbol)
    begin
      puts 'Enter a row and column'
      selection = gets.chomp.split('')
      if selection.empty?
        clear
        draw_board
        puts "Please enter a row and column like 'B2'"
        raise
      end
      row_down = selection[0].downcase
      column_int = selection[1].to_i - 1

      unless input_valid?(row_down, column_int)
        clear
        draw_board
        puts 'Please make sure that the column starts with a, b, or c and the column is between 1 and 3 ex... "A1"'
        raise
      end

      unless valid_move?(row_down, column_int)
        clear
        draw_board
        puts 'Invalid Move, space is occupied'
        raise
      end
    rescue StandardError => e
      retry
    end
    update_square(row_down, column_int, symbol)
  end

  def input_valid?(row_down, column_int)
    row = row_down if %w[a b c].include?(row_down)
    column = column_int if column_int >= 0 && column_int < 3
    return false if row.nil? || column.nil?

    true
  end

  def valid_move?(row, column)
    row_int = convert_row(row)
    @board[row_int][column] == ' '
  end

  def switch_player(current_symbol)
    @current_symbol = if current_symbol == @p1_symbol
                        @p2_symbol
                      else
                        @p1_symbol
                      end
  end
end

test_game = Game.new
