class RedisStructureSortedSet < RedisStructure

  def initialize(key)
    super(key, :zset)
  end

  def expandable?
    Main.redis.zcard(key) > 0
  end

  def children
    unless @children
      @children = []
      zset_children = Hash[*Main.redis.zrange(key, 0, -1, :withscores)]

      zset_children.each_pair do |value, score|
        @children << RedisStructureString.new(score, value)
      end
    end

    @children
  end
end
