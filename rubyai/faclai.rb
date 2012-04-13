#faclai.rb is a Fairie Alchemy Command-Line-Implimentation AI
#This intends to remake the Fairie Alchemy game with an AI that looks ahead
#A later version will hopefully be useful to a player of the game

################################################################################
#Notes:                                                                        
# 4 directions a pair of objects to be dropped can face 
# Vertical directions (2) can be dropped in 6 places
# Horizontal directions (2) can be dropped in 5 
# Thus each drop calculation must account for 2*6+2*5=22 positions 
#  
# The branch factor is thus [NUMELS + (NUMELS-1)+...+(NUMELS-NUMELS)]*22 
# NUMELS will max out at 13+12+11+...+1+0, which is 91 
# This means we have a maximum branching factor of 113 
#  
# ELEM1 = 1 points  
# ELEM2 = 3 points = 3*ELEM1 
# ELEM3 = 9 points = 3*ELEM2  
# .. 
# ELEMX = 3*ELEM(X-1) points = 3^(X-1)   
################################################################################

BRDSZ=6          #Num Columns (including 
MAXELEM=13       #Highest value for X in ELEMX we'll allow at any time
NOEG  = 0

randlimit=2      #Highest value for X in ELEMX we'll allow during creation

#Consider moving class definitions/implementations to other files and
#requiring them
class Piece
  def initialize
    @identity = " "
    @isbot = false
    @isleft = false
    @isright = false
    @istop = false
    @marked = false
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

class Board
  def initialize
    @board=[]
 
    #The board is a 6 * 9 set of Pieces
    #We create each position as a piece and initialize them to know their edges
    i=0
    for i in (0..53)
      @board[i] = Piece.new
      i=i+1
    end
    for i in (0..5)
      @board[i].top
    end
    for i in (48..53)
      @board[i].bot
    end
    for i in (0..8)
      @board[i*BRDSZ].left
      @board[5+i*BRDSZ].right
    end
  end
  def printboard
    puts "--------"
    j=0
    for i in (0..8)
      j=i*BRDSZ
      puts "-" + @board[j+0].identity + @board[j+1].identity +
                 @board[j+2].identity + @board[j+3].identity +
                 @board[j+4].identity + @board[j+5].identity + "-"
    end
    puts "--------"
  end
  def droppiece(p,c) #(piece,column)
    i = c
    while i<54
      if @board[i].identity != " "
        @board[i-BRDSZ].assiden(p)
        break
      end
      if i+BRDSZ > 54
        @board[i].assiden(p)
      end
      i=i+BRDSZ
    end
  end
  def update
    while reduce
    end
  end
  def reduce
    reduced = false
    #check each piece for matching neigbors and mark them
    for i in (0..53)
      if !(@board[i].ismarked)
        startcheck(@board[i],i)
      end
    end
    return reduced
  end
  #This begins a recursive check of a piece and it's neighbors
  def startcheck(p,pos) #piece, position
    set = []
    numfound = 0

    check(@board[pos-BRDSZ],set,numfound,pos-BRDSZ)

    #cleanup
    if(numfound<3)
      if numfound == 1  #we found only this node
        set[0].unmark
      else
        set[0].unmark   #we found and appended only one other
        set[1].unmark
      end
    end
  end
  def check (p,set,numfound,pos)
    temp = 0
    set[numfound] = p
    numfound += 1

    if !p.top
      temp = pos-BRDSZ
      if p.identity == @board[temp].identity
        check(@board[temp],set,numfound,temp)
      end
    end
    if !p.bot
      temp = pos+BRDSZ
      if p.identity == @board[temp].identity
        check(@board[temp],set,numfound,temp)
      end
    end
    if !p.left
      temp = pos-1
      if p.identity == @board[temp].identity
        check(@board[temp],set,numfound,temp)
      end
    end
    if !p.right
      temp = pos+1
      if p.identity == @board[temp].identity
        check(@board[temp],set,numfound,temp)
      end
    end
  end
end

b = Board.new
b.update
b.printboard
