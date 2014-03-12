require 'benchmark'

### Prepare words collection
#
# Start with a empty array.
@words_collection = []

# Fill array from words dictionary file.
file = File.open("Words/Words/en.txt", "r")
file.each_line do |line|
  @words_collection << line.strip
end
puts "Total words: #{@words_collection.count}"

### Helper Methods
#
ALPHABET = "abcdefghijklmnopqrstuvwxyz"
# Returns letters NOT in the given string.
def opposite_letters(letters)
  return ALPHABET.gsub(/[#{letters}]/, "")
end

### Main Algorithms
#
## Letter Parse
# Cycle through each letter of each word.
# This is meant to be slow!
# Used as a starting benchmark.
def basic_letter_parse(letters)
  matching_words = []
  @words_collection.each do |word|
    for i in 0..word.length-1 do
      letter = word[i]
      break unless letter.match(/[#{letters}]/)
      matching_words << word if i == word.length - 1
    end
  end
  matching_words
end

## Word Parse
# Cycle through each word.
def word_parse(letters)
  matching_words = []
  opposite_letters = opposite_letters(letters)
  @words_collection.each do |word|
    matching_words << word unless word.match(/[#{opposite_letters}]/)
  end
  matching_words
end

puts "Performing Basic Letter Parse..."
puts "This is supposed to be slow."
time_taken = Benchmark.realtime { @count = basic_letter_parse("yxmijcmknbshdwifzrsmueist").count }
puts "Matched #{@count} words"
puts "Time taken: #{time_taken} seconds"

baseline = time_taken
puts "Baseline: #{time_taken} seconds"
puts "\n"

puts "Performing Word Parse"
time_taken = Benchmark.realtime { @count = word_parse("yxmijcmknbshdwifzrsmueist").count }
puts "Matched #{@count} words"
puts "Total time: #{time_taken} seconds"
puts "#{(baseline / time_taken).round(1)}x faster!"

