require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# ------------------------------------------------------------------------------
# Print today's date
# ------------------------------------------------------------------------------
puts "***********************************************************************"
puts "Date of report : #{Time.now}"
puts "***********************************************************************"

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# ------------------------------------------------------------------------------
# For each product in the data set:
# ------------------------------------------------------------------------------
products_hash["items"].each do |toy|

	# Var initialization by brand
	total_amount_sales = 0


	# ---------------------------------------------------------------------------
  # Print the name of the toy
	# ---------------------------------------------------------------------------
	puts "***********************************************************************"
	puts "Product reference: #{toy["title"]}"

	# ---------------------------------------------------------------------------
  # Print the retail price of the toy
	# ---------------------------------------------------------------------------
	puts "Retail price: #{toy["full-price"]}$"

	# ---------------------------------------------------------------------------
  # Calculate and print the total number of purchases
	# ---------------------------------------------------------------------------
	puts "Number of purchases for this reference: #{toy["purchases"].length}"

	# ---------------------------------------------------------------------------
  # Calculate and print the total amount of sales
	# ---------------------------------------------------------------------------
	toy["purchases"].each do |purchase|
		total_amount_sales = total_amount_sales + purchase["price"]
	end
	puts "Total amount of sales without the shipping cost: #{total_amount_sales}$"

	# ---------------------------------------------------------------------------
  # Calculate and print the average price the toy sold for
	# ---------------------------------------------------------------------------
	puts "Average price for the reference without the shipping cost: #{total_amount_sales/toy["purchases"].length}$"

	# ---------------------------------------------------------------------------
  # Calculate and print the average discount based off the average sales price
	# Formula = ((toy full price-toy price)/toy full price)*100
	# ---------------------------------------------------------------------------
	puts "Percentage of discount: #{((toy["full-price"].to_f-(total_amount_sales/toy["purchases"].length))/toy["full-price"].to_f).round(2)*100}%"

end



	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# -----------------------------------------------------------------------------
# Defining the list of brands
#
# Verify for each product brand if it exists already into the list of brands
# if yes the brand is not added into the list of brands
# if no the brand is added into the list of brands
# -----------------------------------------------------------------------------
brands = Array.new

products_hash["items"].each do |toy|
	already_exist = false
	brands.each do |brand|
		already_exist = brand == toy["brand"]? true : false
	end
	if already_exist == false
		brands.push(toy["brand"])
	end
end


# -----------------------------------------------------------------------------
# Genarating the report by brand according the list of brands gathered into the
# file.
# -----------------------------------------------------------------------------

brands.each do |brand|

	# Var initialization by brand
	nb_stocked_unit = 0
	total_amount_sales_brand = 0

	# Products selection by brand
	toys_list = products_hash["items"].select do |toy|
		toy["brand"] == brand
	end


	# ---------------------------------------------------------------------------
	# Print the name of the brand
	# ---------------------------------------------------------------------------
	puts "***********************************************************************"
	puts "Sales information for the brand #{brand}"

	# ---------------------------------------------------------------------------
	# Count and print the number of the brand's toys we stock
	# ---------------------------------------------------------------------------


  toys_list.each do |toy|
		nb_stocked_unit = nb_stocked_unit + toy["stock"]
	end
	puts "Number of the stock units available: #{nb_stocked_unit}"


	# ---------------------------------------------------------------------------
	# Calculate and print the average price of the brand's toys
	# Average price = sum of the toy's prices / number of toys
	# ---------------------------------------------------------------------------
	toys_list.each do |toy|
		total_amount_sales_toy = 0

		# Calculate the total amount of sales for one toy reference for one brand
		# For one refrence , make the sum of the amount of the purchases
		toy["purchases"].each do |purchase|
			total_amount_sales_toy = total_amount_sales_toy + purchase["price"]
		end

		# Calculate and print the total amount of sales for all toys references for one brand
		# Make the sum of the totals of the purchases by produduct
		total_amount_sales_brand = total_amount_sales_brand + total_amount_sales_toy
	end
	puts "Average price of the brand toys: #{total_amount_sales_brand.round(2)/toys_list.length}$"

	# ---------------------------------------------------------------------------
	# Calculate and print the total sales volume of all the brand's toys combined
	# ---------------------------------------------------------------------------

	puts "Total amount of sales for the brand without shipping cost: #{total_amount_sales_brand.round(2)}$"

end



# ---------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------
# End of file
# ---------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------
