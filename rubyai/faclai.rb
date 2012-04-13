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
LFTEG = 1        #Contants for keeping track of what edges pieces are near
RITEG = 2
BOTEG = 3
TOPEG = 4
NOEG  = 0

randlimit=2      #Highest value for X in ELEMX we'll allow during creation

#Consider moving class definitions/implementations to other files and
#requiring them
class Piece
  def initialize
    @identity = " "
    @edge = NOEG
  end
  def identity
    @identity
  end
  def edge
    @edge
  end
  def assedge(newedge)
    @edge = newedge
  end
  def assiden(newiden)
    @identity = newiden
  end
end

class Board
  def initialize
    @board=[]
 
   #The board is a 6 * 9 set of Pieces
    i=0
    for i in (0..53)
      @board[i] = Piece.new
      i=i+1
    end
    for i in (0..5)
      @board[i].assedge(TOPEG)
    end
    for i in (48..53)
      @board[i].assedge(BOTEG)
    end
    for i in (0..8)
      @board[i*BRDSZ].assedge(LFTEG)
      @board[5+i*BRDSZ].assedge(RITEG)
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
  end
end

b = Board.new
b.printboard
