class RedisStructureHash < RedisStructure

  def initialize(key)
    super(key, :hash)
  end

  def expandable?
    Main.redis.hlen(key) > 0
  end

  def children
    unless @children
      @children = []
      hash_children = Hash[*Main.redis.hgetall(key)]

      hash_children.each_pair do |k, v|
        @children << RedisStructureString.new(k, v)
      end
    end

    @children
  end
end
