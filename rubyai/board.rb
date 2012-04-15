BRDSZ=6          #Num Columns (including 

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

    numfound = condense(set,pos,numfound)
    piecetype = @board[set[0]].identity

    #find bottommost piece
    endpoint = set.max

    #find bottommost/leftmost piece
    for i in (0..BRDSZ-1)
      if !set.include?(endpoint-1) and !@board[endpoint].isleft
        break
      else
        endpoint -= 1
      end
    end

    #cleanup
    for i in (0..numfound-1)
      if(set[i] != endpoint)
        @board[set[i]].assiden(" ")
      end
    end
    @board[endpoint].next
  end

  #This begins a recursive check of a piece and it's neighbors for marking
  def startcheck(pos) #position
    set = [pos,pos]   #initialized so ruby recognizes type
    numfound = 0

    numfound = check(set,pos,numfound)

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
        numfound = condense(set,temp,numfound)
      end
    end
    if !p.isbot
      temp = pos+BRDSZ
      q = @board[temp]
      if (p.ismatch(q)) and q.ismarked
        numfound = condense(set,temp,numfound)
      end
    end
    if !p.isleft
      temp = pos-1
      q = @board[temp]
      if (p.ismatch(q)) and q.ismarked
        numfound = condense(set,temp,numfound)
      end
    end
    if !p.isright
      temp = pos+1
      q = @board[temp]
      if (p.ismatch(q)) and q.ismarked
        numfound = condense(set,temp,numfound)
      end
    end
    return numfound
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
        numfound = check(set,temp,numfound)
      end
    end
    if !p.isbot
      temp = pos+BRDSZ
      q = @board[temp]
      if (p.ismatch(q)) and !q.ismarked
        numfound = check(set,temp,numfound)
      end
    end
    if !p.isleft
      temp = pos-1
      q = @board[temp]
      if (p.ismatch(q)) and !q.ismarked
        numfound = check(set,temp,numfound)
      end
    end
    if !p.isright
      temp = pos+1
      q = @board[temp]
      if (p.ismatch(q)) and !q.ismarked
        numfound = check(set,temp,numfound)
      end
    end
    return numfound
  end
end