i = 0
vowels = Hash.new
("a".."z").each do |letter|
  i +=1
  vowels[letter] = i if letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u"
end
puts vowels
