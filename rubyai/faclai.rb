#faclai.rb is a Fairie Alchemy Command-Line-Implimentation AI
#This intends to remake the Fairie Alchemy game with an AI that looks ahead
#A later version will hopefully be useful to a player of the game

#Consider moving all classes to seperate files and requiring them

class Board
  def initialize
    @board = ["-","-","-","-","-","-","-","-",
              "-"," "," "," "," "," "," ","-",
              "-"," "," "," "," "," "," ","-",
              "|"," "," "," "," "," "," ","|",
              "|"," "," "," "," "," "," ","|",
              "|"," "," "," "," "," "," ","|",
              "|"," "," "," "," "," "," ","|",
              "|"," "," "," "," "," "," ","|",
              "|"," "," "," "," "," "," ","|",
              "|"," "," "," "," "," "," ","|",
              "-","-","-","-","-","-","-","-"] 
  end
  def printboard
    i = 0
    j = 0
    while i <= 10
      j = i * 8
      i = i + 1
      puts @board[j + 0] + @board[j + 1] + @board[j + 2] + @board[j + 3]                 + @board[j + 4] + @board[j + 5] + @board[j + 6] + @board[j + 7]
    end
  end
end

#randomlimit
rl = 2
while rl <= 5
  puts (1+rand(rl)).to_s + " " + (1+rand(rl)).to_s + " " + (1+rand(rl)).to_s
  rl = rl + 1
end

b = Board.new
b.printboard
