cart = Hash.new

while true
  puts "What do you buy? Write стоп to finish"
  product = gets.chomp.to_s
  break if product == "стоп"
  puts "Price per 1?"
  price = gets.chomp.to_f
  puts "Quantity?"
  quantity = gets.chomp.to_f
  cart[product] = { price => quantity }
end

final_sum = 0
cart.each do |product, info|
	# Ну не нашел я, как обратиться к нулевому и единственному ключу хэша, сделал как сумел :(
	info.each do |price, quantity|
      sum = price * quantity
	  final_sum += sum 
      puts "Product: #{product}, price: #{price}, quantity: #{quantity}, cost of position: #{sum}"
	end  
end

puts "Cost of whole cart: #{final_sum}"