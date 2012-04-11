#fact.rb is a simple program that finds the factorial of a given number from
#the command line
#Written by Erich Ulmer using rubyist.net

def fact(n)
  if n <= 0
    1
  else
    n * fact(n-1)
  end
end

puts fact(ARGV[0].to_i)

