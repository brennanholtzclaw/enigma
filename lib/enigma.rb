require 'pry'
require './lib/key_generator'

class Enigma

  def encrypt(message, key = nil, date = nil)
    Encryptor.new(message, key, date)
  end

  def decrypt(message, key = nil, date = nil)
    Decryptor.new(message, key = nil, date = nil)
  end

  def crack
    Crack.new(message, date)
  end

end
