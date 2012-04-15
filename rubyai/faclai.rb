#faclai.rb is a Fairie Alchemy Command-Line-Implimentation AI
#This intends to remake the Fairie Alchemy game with an AI that looks ahead
#A later version will hopefully be useful to a player of the game

require File.expand_path('../piece.rb', __FILE__)
require File.expand_path('../board.rb', __FILE__)

b = Board.new
b.printboard
