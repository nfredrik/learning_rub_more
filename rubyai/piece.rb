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

  #!!WARNING: Uses a deprecated function
  #This updates the current "identity" character to the next
  def next
    #!!WARNING: Deprecated use of [0]. If running Ruby1.9 this needs to be .ord
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

