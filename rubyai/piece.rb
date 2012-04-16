#Utilized by board.rb to keep track of all position logic
#Flags are used to simplify board logic code

class Piece
  def initialize
    #piecetype
    @identity = " "

    #positional flags
    @isbot = false
    @isleft = false
    @isright = false
    @istop = false

    #used solely for logic. Various sweeps mark the piece and unmark pieces
    #to keep track of them for future sweeps
    @marked = false
  end

  #interactive methods
  #This checks to see if a piece matches some input piece's character
  def ismatch(inpiece)
    if @identity == inpiece.identity
      return true
    else
      return false
    end
  end 

  #Make this piece a copy of another
  def copy(inpiece)
    assiden(inpiece.identity)

    #Flag testing
    inpiece.isbot    ? bot   : @isbot = false
    inpiece.istop    ? top   : @istop = false
    inpiece.isleft   ? left  : @isleft = false
    inpiece.isright  ? right : @isright = false
    inpiece.ismarked ? mark  : @ismarked = false
  end

  #!!WARNING: Uses a deprecated functionality
  #This updates the current "identity" character to the next
  def next
    @identity = (@identity[0]+1).chr
  end
 
 #getters
  def identity
    @identity
  end
  def isbot
    if @isbot
      return true
    else
      return false
    end
  end
  def isright
    if @isright
      return true
    else
      return false
    end
  end
  def isleft
    if @isleft
      return true
    else
      return false
    end
  end
  def istop
    if @istop
      return true
    else
      return false
    end
  end
  def ismarked
    if @marked
      return true
    else
      return false
    end
  end

  #setters
  def assiden(newiden)	#input is a character (or any ASCII char)
    @identity = newiden
  end
  def mark
    @marked = true
  end
  def unmark
    @marked = false
  end
  def bot
    @isbot = true
  end
  def left
    @isleft = true
  end
  def right
    @istop = true
  end
  def top
    @istop = true
  end
end

