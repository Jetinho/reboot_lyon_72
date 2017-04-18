require_relative "calculator"

puts "Bienvenue sur calculator"

answer = "y"

until answer == "n"
  puts "Entrez votre 1er nombre"
  print "> "

  number_1 = gets.chomp.to_i

  puts "Entrez votre 2e nombre"
  print "> "

  number_2 = gets.chomp.to_i

  puts "Quelle opération effectuer [ + ; - ; * ; / ]"
  print "> "

  operator = gets.chomp

  result = calculate(number_1, number_2 , operator)

  if result == nil
    puts "A problem occurred, check your input"
  else
    puts result
  end

  puts "One more ? [y/n]"

  answer = gets.chomp
end

