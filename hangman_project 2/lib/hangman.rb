class Hangman
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    return [] if !@secret_word.include?(char)
    
    indices = []
    arr = @secret_word.split("")
    arr.each_with_index { |ele,i| indices << i if ele == char }
    indices
  end

  def fill_indices(char, arr)
    arr.each do |ele|
      @guess_word[ele] = char
    end
  end
  
  
  def try_guess(char)
    if self.already_attempted?(char)
      print "that has already been attempted"
      return false
    end

    idxs = self.get_matching_indices(char)
    self.fill_indices(char,idxs)
    
    @remaining_incorrect_guesses -= 1 if idxs.length == 0

      @attempted_chars << char
      true
    
  end

  def ask_user_for_guess
    p "Enter a char:"
    char = gets.chomp
    try_guess(char)
  end

  def win?
    if guess_word.join("") == @secret_word
      p "WIN"
      return true
    end
    
    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      print "LOSE"
      return true
    end

    false
  end

  def game_over?
    if self.win? || self.lose?
      print @secret_word 
      return true
    end

    false
  end










end
