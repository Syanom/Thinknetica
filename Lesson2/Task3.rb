fibonacci = [0, 1]
(1..100).each { |number| fibonacci.push(number) if number == fibonacci[-1] + fibonacci[-2] }
puts fibonacci