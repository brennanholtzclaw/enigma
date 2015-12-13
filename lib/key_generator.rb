require 'pry'

class KeyGenerator
  attr_reader :key

  def initialize(key = rand(99999))
    @key = key.to_s
    key_checker(@key)
  end

  def key_checker(key)
    @key = ("%05d" % key) if @key.length < 5
    "Key length too long" if @key.to_s.length > 5
  end

end
