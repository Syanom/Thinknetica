puts "Day?"
day = gets.chomp.to_i
puts "Month?"
month = gets.chomp.to_i
puts "Year?"
year = gets.chomp.to_i
answer = 0
monthes_in_year = {
	1 => 31,
	2 => 28,
	3 => 31,
	4 => 30,
	5 => 31,
	6 => 30,
	7 => 31,
	8 => 31,
	9 => 30,
	10 => 31,
	11 => 30,
	12 => 31
}
monthes_in_year.each { |month_in_year, days| answer += days if month_in_year < month }
answer += day
# Adding +1 to answer if year is leap and its later than 29 feb
answer += 1 if year % 4 && ( !(year % 100 == 0) || (year % 400 == 0) ) && month > 2	