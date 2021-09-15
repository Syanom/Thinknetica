puts "Enter a, please"
a = gets.chomp.to_f
puts "Enter b, please"
b = gets.chomp.to_f
puts "Enter c, please"
c = gets.chomp.to_f

d = b ** 2 - 4 * a * c

if d < 0 
	puts "The equation's discriminant is #{d} and it has no roots"
elsif d == 0
	puts "The equation's discriminant is #{d}, and the only root is #{(-b + Math.sqrt(d)) / 2 / a}"
else
	puts "The equation's discriminant is #{d}, roots are #{(-b + Math.sqrt(d)) / 2 / a} and #{(-b - Math.sqrt(d)) / 2 / a}"
end
