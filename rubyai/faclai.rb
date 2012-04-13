#faclai.rb is a Fairie Alchemy Command-Line-Implimentation AI
#This intends to remake the Fairie Alchemy game with an AI that looks ahead
#A later version will hopefully be useful to a player of the game

#Consider moving all classes to seperate files and requiring them

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

BRDSZ=8          #Num Columns (including 
MAXELEM=13       #Highest value for X in ELEMX we'll allow at any time
randlimit=2      #Highest value for X in ELEMX we'll allow during creation

class Piece
  def initialize
    @identity = " "
    @value=0
  end
  def identity
    @identity
  end
  def value
    @value
  end
end

class Board
  def initialize
    @board=[]
 
   #The board is a 6 * 9 set of Pieces
    i=0
    while i<54
      @board[i] = Piece.new
      i=i+1
    end
  end
  def printboard
    puts "--------"
    i=0
    j=0
    while i<9
      j=i*6
      i=i+1
      puts "-" + @board[j+0].identity + @board[j+1].identity +
                 @board[j+2].identity + @board[j+3].identity +
                 @board[j+4].identity + @board[j+5].identity + "-"
    end
    puts "--------"
  end
end

b = Board.new
b.printboard
