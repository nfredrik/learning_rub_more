#Should control most or all of the game logic to allow for consistent gameplay
#Functions should tell you which pieces are ready to be used et


BASCHR  = 'a'
PIECTYP = 0

class Game
  def initialize
    @currpieces = []
    @nextpieces = []
    @board = Board.new
  end

  #Wrappers
  def copyboard(inboard)
    @board.copy(inboard)
  end
  def update
    @board.update
  end
  def printboard
    @board.printboard
  end

  #Copying
  def copy(ingame)
    copymoves(ingame.currpieces,ingame.nextpieces)
    copyboard(ingame.board)
  end  
  def copymoves(incurr,innext)
    for i in 0..1
      @currpieces[i] = incurr[i]
      @nextpieces[i] = innext[i]
    end
  end

  #Shows the four movetypes a player can make (in a nice format.) 
  #Note: Useless for the AI
  def showmoves
    puts "Enter the number of the movetype you want, following by the"
    puts "column number. Ex. (1,2) for first movetype, second column."
    puts "------------MOVETYPES------------"
    puts "|1  " + @currpieces[0] + "   " +
         "|2  " + @currpieces[1] + "   " +
         "|3      " + "|4      |"
    puts "|   " + @currpieces[1] + "   " +
         "|   " + @currpieces[0] + "   " + 
         "|  "  + @currpieces[0] + " "   + 
                  @currpieces[1] + "  "  +
         "|  "  + @currpieces[1] + " "   + 
                  @currpieces[0] + "  |"  
    puts "---------------------------------"
  end

  #Support
  def genpieces
    rl = @board.randlimit
    for i in 0..1
      @currpieces[i] = (rand(rl)+97).chr
      @nextpieces[i] = (rand(rl)+97).chr
    end
  end

  #Getters
  def currpieces
    @currpieces
  end
  def nextpieces
    @nextpieces
  end
  def board
    @board
  end
end
