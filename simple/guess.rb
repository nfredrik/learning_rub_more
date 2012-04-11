#this is a simple guessing "game", for practice with strings
#Written by Erich Ulmer using rubyist.net

words = ['foobar','baz','quux']
secret = words[rand(3)]

print "guess? "
while guess = STDIN.gets
  guess.chop!
  if guess == secret
    puts "Youz a winna! now git outta heeh"
    break
  else
    puts "Lolz, 'ur gahbige kid! 'U'll neva make it!"
  end
  print "guess? "
end 
puts "The word was " +  secret + "."
#puts "the word was #{secret}."
