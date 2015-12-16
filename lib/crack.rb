require 'date'
require 'pry'

class Crack



end





  # def crack_key(date, message)
  #   c = KeyCrack.new
  #   date_offsets = get_date_offsets(date)
  #   actual_ending = translate_end_of_message_to_numbers(message)
  #   expected_ending = c.expected_ending
  #   c.interpret_key(actual_ending, expected_ending, message, date_offsets)
  # end
  #
  # def translate_end_of_message_to_numbers(message)
  #   c = KeyCrack.new
  #   mc = MessageConverter.new
  #   end_of_message = c.extract_ending(message)
  #   mc.convert_to_numbers(end_of_message)
  # end
  #
  # def crack(date=nil, message)
  #   date = check_date(date)
  #   key = crack_key(date, message)
  #   puts "Cracked Key = #{key} | Date = #{date}"
  #   decrypt_message(key, date, message)
  # end
