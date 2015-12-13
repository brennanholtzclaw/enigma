require 'pry'
require 'date'

class KeyGenerator
  attr_reader :key, :date, :a_rotation, :b_rotation, :c_rotation, :d_rotation

  def initialize(key = rand(99999))
    @key = key.to_s
    key_checker(@key)
    @a_rotation = @key[0..1]
    @b_rotation = @key[1..2]
    @c_rotation = @key[2..3]
    @d_rotation = @key[3..4]
  end

  def key_checker(key)
    @key = ("%05d" % key) if @key.to_s.length < 5
    "Key length too long" if @key.to_s.length > 5
  end

end
