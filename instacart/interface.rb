# Définition du stock du magasin, dans une variable car ce stock est amené à être modifié.
stock_products = {
  tshirt: {price: 15, quantity: 5},
  sweat: {price: 30, quantity: 5},
  coat: {price: 100, quantity: 5},
  pull: {price: 50, quantity: 5},
  hat: {price: 25, quantity: 5},
  underwear: {price: 10, quantity: 5}
}
# On initialise les variables qu'on va utiliser par la suite
cart = {}
sum = 0
new_article = nil

puts "~~~ Bienvenue chez Wagonshop! ~~~"

# Entrée du loop
until new_article == "quit"
  # Afficher le stock
  puts  "Voici notre stock:"
  puts "--------------------------"
  stock_products.each do |key, value|
    puts "#{key} - #{value[:price]} € - #{value[:quantity]} items"
  end

  puts "--------------------------"
  puts "Choisissez votre article, ou tapez quit pour finaliser votre achat"
  print ">"

  new_article = gets.chomp
  puts "--------------------------"

  if new_article == "quit"
    puts "OK, we finalize your order"
    puts "__________________________"
  # Vérification : le produit est-il référencé dans notre stock ?
  elsif stock_products.has_key?(new_article.to_sym)
    product_quantity = stock_products[new_article.to_sym][:quantity]
    puts "We have #{product_quantity} #{new_article}"
    puts "How many #{new_article} do you want"
    print "> "
    quantity = gets.chomp.to_i
    # Vérification : a-t'on suffisament de stock pour la quantité demandée d'un produit.
    if product_quantity >= quantity
      # Si oui:
      # Ajout au panier de l'objet et de la quantité correspondante
      cart[new_article.to_sym] = quantity
      # On soustrait du stock la quantité demandée.
      stock_products[new_article.to_sym][:quantity] -= quantity
    else
      # Si la quantité demandée est supérieure au stock disponible :
      puts "Sorry, we don't have that amount of #{new_article}"
    end
  else
    # Si le produit n'est pas référencé:
    puts "We don't have #{new_article}. Check your choice."
  end
end

# Calcul de la valeur totale du panier
cart.each do |key, value|
  result = value * stock_products[key.to_sym][:price]
  sum += result
end

# Affichage du panier : valeur totale et valeur par objet.
puts "Your cart: #{sum} €"
cart.each do |key, value|
  puts "#{value} x #{key}----------- #{stock_products[key.to_sym][:price]} €"
  puts "-------------------#{value * stock_products[key.to_sym][:price]} €"
end
