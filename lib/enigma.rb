require 'pry'
require './lib/key_generator'

class Enigma
  attr_reader :key

  def initialize(input_key = rand(99999))
    @key = KeyGenerator.new(input_key).key
  end

  def encrypt
  end

  def decrypt
  end

  def crack
  end

end
