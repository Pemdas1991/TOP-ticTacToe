class Game
  def initialize
    new_board
  end

  def new_board
    @board = Array.new(3) { Array.new(3) { ' ' } }
  end

  def play
    @GAMEINPLAY = 1
    @WINNER = 0
    while @GAMEINPLAY
      new_board
      until @WINNER
        # get player move
        # check winner
        # return if winner
        # switch player
      end
      # would you like to play a new game
      # get answer
    end
  end

  def draw_board
    puts '  | 0 | 1 | 2 |'
    puts "a | #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"
    puts "b | #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
    puts "c | #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
  end

  def update_square(row, column, symbol)
    row.downcase
    case row
    when 'c'
      @row = 2
    when 'b'
      @row = 1
    when 'a'
      @row = 0
    else
      puts 'Error: Did not receive a letter a-c'
      return
    end

    @column = column
    @symbol = symbol

    @board[@row][@column] = symbol
  end
end

testGame = Game.new
testGame.update_square('a', 0, 'X')
testGame.draw_board
