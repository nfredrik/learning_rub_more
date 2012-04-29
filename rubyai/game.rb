#Should control most or all of the game logic to allow for consistent gameplay
#Functions should tell you which pieces are ready to be used et


BASCHR  = 'a'
PIECTYP = 0

class Game
  def initialize
    @currpieces = []
    @nextpieces = []
    @board = Board.new
    genpieces
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
  #Also initiates entire move process for a human player
  #Note: Useless for the AI
  def showmoves
    printboard
    puts "------------MOVETYPES------------"
    puts "|1  " + @currpieces[0]  + "   " +
         "|2  " + @currpieces[1]  + "   " +
         "|3      " + "|4      |" + "   Next Pieces:"
    puts "|   " + @currpieces[1] + "   " +
         "|   " + @currpieces[0] + "   " + 
         "|  "  + @currpieces[0] + " "   + 
                  @currpieces[1] + "  "  +
         "|  "  + @currpieces[1] + " "   + 
                  @currpieces[0] + "  |" + 
         "   "  + @nextpieces[0] + " " + @nextpieces[1]
    puts "---------------------------------"
    getmove
  end

  def getmove
    colmax = 5
    while(true)
      puts "Please enter movetype you wish to use (1-4):"
      movetype = gets.to_i

      #ensure good input
      if movetype < 1 or movetype > 4 
        puts "Invalid input. Must be a number between 1 and 4"
      else
        #make user instructions accurate
        if movetype < 3
          colmax = 6
        else
          colmax = 5
        end
        break
      end
    end

    while(true)
      puts "Please enter the column to drop under (1-" + colmax.to_s + "):"
      column = gets.to_i

      #ensure valid input
      if movetype < 1 or movetype > colmax
        puts "Invalid input. Must be a number between 1 and " + colmax
      else
        break
      end
    end

    putmove(movetype,column-1,true)
  end
 
  #uses desired move, may be called directly
  def putmove(movetype,column,gen) #column refers to leftmost column in move
    #put pieces on board
    if movetype == 1
      @board.droppiece(currpieces[0],column)
      @board.droppiece(currpieces[1],column)
    elsif movetype == 2
      @board.droppiece(currpieces[1],column)
      @board.droppiece(currpieces[0],column)
    elsif movetype == 3
      @board.droppiece(currpieces[0],column)
      @board.droppiece(currpieces[1],column+1)
    elsif movetype == 4
      @board.droppiece(currpieces[1],column)
      @board.droppiece(currpieces[0],column+1)
    end 
    setcurr(@nextpieces[0],@nextpieces[1])
    if gen
      gennext
    end
  end

  #Support
  def setcurr(a,b)
    @currpieces[0] = a
    @currpieces[1] = b
  end

  def setnext(a,b)
    @nextpieces[0] = a
    @nextpieces[1] = b
  end

  def genpieces
    gencurr
    gennext
  end

  def gencurr
    rl = @board.randlimit
    @currpieces[0] = (rand(rl)+97).chr
    @currpieces[1] = (rand(rl)+97).chr
  end

  def gennext
    rl = @board.randlimit
    @nextpieces[0] = (rand(rl)+97).chr
    @nextpieces[1] = (rand(rl)+97).chr
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
