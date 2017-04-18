horses_names = ["Flamand bleu", "Murdo", "Etoile", "Cheval des mers"]

puts "Bienvenue aux courses, voici la liste des chevaux"
horses_names.each_with_index do |horse_name, index|
  puts "#{index + 1}- #{horse_name}"
end

puts "Sur quel cheval allez-vous parier ?"
print "> "
bet = gets.chomp.to_i

puts "Vous avez parié sur #{horses_names[bet - 1]}"

winner = rand(1..horses_names.length)

def check_win(winner, bet)
  if winner == bet
    "You won, congrats !"
  else
    "Sorry you lost..."
  end
end

result = check_win(winner, bet) + "\n#{horses_names[winner - 1]} won the race."

puts result
