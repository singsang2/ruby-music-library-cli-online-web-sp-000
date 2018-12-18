def guess_name
  letters = ["a","b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
  puts "Write your name: "
  name = gets.strip()
  len = name.length


  puts "Length: #{len}"
  puts "Probability: 1 in #{26**len}"

  try = 1
  count = 0
  guess_name = ""
  
  while guess_name != name
    guess = []
    count = 0
    while count < len
      guess << letters[rand(26)]
      count += 1
    end
    guess_name = guess.join("")
    puts "try ##{try} guess: #{guess_name}"
    try += 1
  end
end
