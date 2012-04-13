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

  #interactive methods
  def ismatch(inpiece)
    if @identity == inpiece.identity
      return true
    else
      return false
    end
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
      if !(@board[i].ismarked) and (@board[i].identity != " ")
        startcheck(i)
      end
    end
    for i in (0..53)
      if @board[i].ismarked
        reduced = true
        startcondense(i)
      end
    end
    return reduced
  end

  #This begins a recursive check of a piece and it's neighbors for reduction
  def startcondense(pos)
    set = [pos]
    numfound = 0

    condense(set,pos,numfound)

    #find bottommost piece
    endpoint = 0;
    for i in (0..numfound)
      if set[i] > endpoint
        endpoint = set[i]
      end
    end

    #find bottommost/leftmost piece
    for i in (0..BRDSZ-1)
      if !set.include?(endpoint-1) and !@board[endpoint].isleft
        break
      else
        endpoint -= 1
      end
    end

    #cleanup
    for i in (0..numfound)
      @board[set[i]].assiden(" ")
    end
    @board[endpoint].assiden("Z")
  end

  #This begins a recursive check of a piece and it's neighbors for marking
  def startcheck(pos) #position
    set = [pos,pos]   #initialized so ruby recognizes type
    numfound = 0

    check(set,pos,numfound)

    #cleanup
    if(numfound<3)
      if numfound == 1  #we found only this node
        @board[set[0]].unmark
      else              #we found and appended only one other
        @board[set[0]].unmark
        @board[set[1]].unmark
      end
    end
  end

  def condense(set,pos,numfound)
    p = @board[pos]
    p.unmark
    set[numfound] = pos
    numfound += 1

    if !p.istop
      temp = pos-BRDSZ
      q = @board[temp]
      if (p.ismatch(q)) and q.ismarked
        condense(set,temp,numfound)
      end
    end
    if !p.isbot
      temp = pos+BRDSZ
      q = @board[temp]
      if (p.ismatch(q)) and q.ismarked
        condense(set,temp,numfound)
      end
    end
    if !p.isleft
      temp = pos-1
      q = @board[temp]
      if (p.ismatch(q)) and q.ismarked
        condense(set,temp,numfound)
      end
    end
    if !p.isright
      temp = pos+1
      q = @board[temp]
      if (p.ismatch(q)) and q.ismarked
        condense(set,temp,numfound)
      end
    end
  end

  def check (set,pos,numfound)
    p = @board[pos]
    p.mark
    set[numfound] = pos
    numfound += 1

    if !p.istop
      temp = pos-BRDSZ
      q = @board[temp]
      if (p.ismatch(q)) and !q.ismarked
        check(set,temp,numfound)
      end
    end
    if !p.isbot
      temp = pos+BRDSZ
      q = @board[temp]
      if (p.ismatch(q)) and !q.ismarked
        check(set,temp,numfound)
      end
    end
    if !p.isleft
      temp = pos-1
      q = @board[temp]
      if (p.ismatch(q)) and !q.ismarked
        check(set,temp,numfound)
      end
    end
    if !p.isright
      temp = pos+1
      q = @board[temp]
      if (p.ismatch(q)) and !q.ismarked
        check(set,temp,numfound)
      end
    end
  end
end

b = Board.new
b.droppiece("a",1)
b.droppiece("a",1)
b.droppiece("a",1)
b.printboard
b.update
b.printboard
