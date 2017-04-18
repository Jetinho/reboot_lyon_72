require 'pry'
require 'nokogiri'
require 'open-uri'
require_relative 'csv_interface'
require_relative 'tools'
require_relative 'etsy_scraper'

puts "Bienvenue sur Xmas List !"
puts "---------------"

# On charge notre array gift_list à partir du fichier CSV
gift_list = load_csv

action = ""
# Entrée dans le loop si action est différent de "exit"
until action == "exit"
  # puts "Que voulez-vous faire ? ([list]|[add]|[delete]|[mark (as bought)][exit]|[idea])"
  # print "> "
  # Au lieu des 2 lignes précédentes on utilise la méthode ask dans tools.rb pour poser une question (DRY: on évite de répéter du code):
  ask("Que voulez-vous faire ? ([list]|[add]|[delete]|[mark (as bought)][exit]|[idea])")

  # action = gets.chomp
  # Au lieu de répéter gets.chomp à chaque foison ne l'écrit qu'une fois dans la méthode answer de tools.rb,
  # et on appelle la méthode comme sur la ligne qui suit
  action = answer

  # "Orientation" vers le code à exécuter en fonction du retour de l'utilisateur
  case action

  when "list"
    if gift_list.empty?
      puts "Your list is empty so far"
      puts "            "
    else
      puts "            "
      gift_list.each do |gift|
        puts "- #{gift[:name]}#{gift[:etsy_price] ? '- ' + gift[:etsy_price].to_s + '€' : ''} - #{gift[:bought?] == "true" ? "[X]" : "[ ]"} "
      end
    end

  when "add"
    ask("Which item do you want to add ?")
    new_gift_name = answer
    new_gift = {name: new_gift_name, bought?: false}
    gift_list << new_gift

  when "delete"
    gift_list.each_with_index do |gift, index|
      puts "#{index + 1} - #{gift[:name]} - #{gift[:bought?] ? "[X]" : "[ ]"}"
    end
    puts "            "
    puts "Which gift do you want to delete ? (type gift number)"
    gift_number = answer.to_i
    gift_list.delete_at(gift_number - 1)

  # Marquer un cadeau comme acheté
  when "mark"
    gift_list.each_with_index do |gift, index|
      puts "#{index + 1} - #{gift[:name]} - #{gift[:bought?] ? "[X]" : "[ ]"}"
    end
    puts "            "
    puts "Which gift did you buy ? (type gift number)"
    gift_number = answer.to_i
    gift_list[gift_number - 1][:bought?] = "true"

  # Récupérer des suggestions depuis le site Etsy
  when "idea"
    ask("Which kind of item ?")
    idea = answer
    # On va chercher l'information sur etsy via la méthode scrap dans le fichier etsy_scraper.rb
    suggestions = scrap(idea)

    # On affiche les suggestions:
    suggestions.each_with_index do |suggestion, index|
      puts "#{index + 1}- #{suggestion[:name]} - #{suggestion[:etsy_price]} €"
    end
    puts "            "
    ask("Which suggestion do you want to add ? (type gift number or 'quit')")
    suggestion_number = answer.to_i
    unless suggestion_number == 'quit'
      # On crée un nouveau gift en fonction du choix de l'utilisateur, à partir des infos contenues dans la suggestion sélectionnée.
      new_gift = suggestions[suggestion_number - 1]
      new_gift[:bought?] = false
      gift_list << new_gift
    end
  when "exit"
    # On sauvegarde notre liste avant de partir
    store_to_csv(gift_list)
    puts "Thank you and goodbye"
  else
    puts "#{action} is not a valid instruction"
  end
end



