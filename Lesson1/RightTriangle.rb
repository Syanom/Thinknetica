puts "Enter first side of triangle, please"
a = gets.chomp.to_f
puts "Enter second side of triangle, please"
b = gets.chomp.to_f
puts "Enter third side of triangle, please"
c = gets.chomp.to_f

# Make c the biggest side, like in trigonometry
if a > b && a > c
	tmp = a 
	a = c
	c = tmp
elsif b > a && b > c
	tmp = b
	b = c
	c = tmp
end

if a == b && a == c
	puts "Triangle is equilateral"
elsif a == b 
	puts "Triangle is isosceles"
elsif c ** 2 == a ** 2 + b ** 2
	puts "Triangle is right-angled"
else
	puts "Triangle is not right-angled"
end
