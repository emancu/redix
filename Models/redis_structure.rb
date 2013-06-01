class RedisStructure
  attr_accessor :key, :type, :value

  def self.create(key)
    type = Main.redis.type(key)
    self.send("create_#{type}", key)
  end

  def initialize(key, type, value = nil)
    self.key  = key
    self.type = type
    self.value = value
  end

  def string?
    type == :string
  end

  def children
    raise 'Children not defined!'
  end

  def expandable?
    false
  end

  private

  def self.create_string(key)
    RedisStructureString.new(key)
  end

  def self.create_hash(key)
    RedisStructureHash.new(key)
  end

  def self.create_list(key)
    RedisStructureList.new(key)
  end

  def self.create_set(key)
    RedisStructureSet.new(key)
  end

  def self.create_zset(key)
    RedisStructureSortedSet.new(key)
  end
end
