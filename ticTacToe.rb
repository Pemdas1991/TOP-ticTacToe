class Game

    def initialize(players = 2)
       newBoard 
    end

    def newBoard
        @board = Array.new(3) {Array.new(3) {" "}} 
    end


    def drawBoard
        puts "  | 0 | 1 | 2 |"
        puts "a | #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"
        puts "b | #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
        puts "c | #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
    end

    def updateSquare(row, column, symbol)
        
        case row
        when "c"
            @row = 2
        when "b"
            @row = 1
        else @row = 0
        end

        @column = column
        @symbol = symbol
        
        @board[@row][@column] = symbol
    end

end

testGame = Game.new
testGame.updateSquare("c",0,"X")
testGame.drawBoard()
