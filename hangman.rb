def set_difficulty
  puts "Would you like an increased difficulty? Y/N"
  reply = gets.chomp.upcase
  if reply == 'Y'
    return "words.txt"
  elsif reply == 'N'
    return "common_words.txt"
  else
    puts "Incorrect input."
    set_difficulty
  end
end

def load_dictionary(filename)
  dictionary = File.open(filename)
  words = dictionary.readlines
  words.shuffle!
  return words
end

def pick_random_word(words)
  return words[rand(0...words.length)]
end

def enter_letter(alphabet)
  puts "Enter letter: "
  letter = gets.chomp.downcase.strip

  if alphabet.include?(letter) && letter != ''
    alphabet.delete!(letter)
    return letter
  else
    puts "Invalid input, try again."
    enter_letter(alphabet)
  end
end

def display_word(word_array, letters_remaining)
  word_array.each do |x|
    if letters_remaining.include?(x)
      print "_ "
    else
      print "#{x} "
    end
  end
  print "\n"
end

def set_replay
  puts "Play again? Y/N"
  reply = gets.chomp.upcase
  if reply == 'Y'
    return true
  elsif reply == 'N'
    return false
  else
    puts "Incorrect input."
    set_replay
  end
end

difficulty = set_difficulty
words = load_dictionary(difficulty)
replay = true

until replay == false
  word = pick_random_word(words).downcase.strip
  word_array = word.chars.to_a
  letters_remaining = word_array.sort.uniq

  alphabet = %(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  lives = 7

  puts "Word selected!"

  until lives == 0 || letters_remaining.length == 0
    display_word(word_array, letters_remaining)
    letter = enter_letter(alphabet)

    if letters_remaining.include?(letter)
      puts "Correct!"
      letters_remaining.delete(letter)
    else
      lives = lives - 1
      puts "Wrong! Lives remaining: #{lives}"
    end
  end

  display_word(word_array, letters_remaining)
  if(letters_remaining.length == 0)
    puts "You win!"
  else
    puts "No lives left! The word was #{word}."
  end

  replay = set_replay
end