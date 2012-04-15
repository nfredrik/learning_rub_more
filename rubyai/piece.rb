class Piece
  def initialize
    @identity = " "
    @isbot = false
    @isleft = false
    @isright = false
    @istop = false
    @marked = false
  end

  #interactive methods
  def ismatch(inpiece)
    if @identity == inpiece.identity
      return true
    else
      return false
    end
  end 
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
  def assiden(newiden)
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

