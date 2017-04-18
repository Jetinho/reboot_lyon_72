def scrap(idea)
  url = "https://www.etsy.com/search?q=#{idea}"
  file = open(url)
  doc = Nokogiri::HTML(file)
  cards = doc.search(".buyer-card").first(5)
  suggestions = []
  cards.each do |card|
    # On va chercher le nom de l'article:
    title = card.at_css(".card-title").text.strip
    # On va chercher le prix de l'article:
    price = card.at_css(".currency").text.to_i
    new_suggestion = {name: title, etsy_price: price}
    # Equivalent à :
    # new_suggestion = {}
    # new_suggestion[:name] = title
    # new_suggestion[:bought?] = false
    # new_suggestion[:etsy_price] = price
    # On stocke chaque suggestion dans un tableau:
    suggestions << new_suggestion
  end
  return suggestions
end
