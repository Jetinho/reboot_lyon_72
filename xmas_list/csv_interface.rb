require 'csv'

CSV_OPTIONS = { col_sep: ',', quote_char: '"', headers: :first_row }
FILEPATH = 'gift_list.csv'

def store_to_csv(gift_list)
  CSV.open(FILEPATH, 'wb', CSV_OPTIONS) do |csv|
      csv << ['Name', "Bought?", "Etsy Price"]
    gift_list.each do |gift|
      csv << [gift[:name], gift[:bought?], gift[:etsy_price]]
    end
  end
end

def load_csv
  gift_list = []
  CSV.foreach(FILEPATH, CSV_OPTIONS) do |row|
    gift = {}
    gift[:name] = row["Name"]
    gift[:bought?] = row["Bought?"]
    gift[:etsy_price] = row["Etsy Price"]
    gift_list << gift
  end
  gift_list
end
