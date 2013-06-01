class RedisStructureSet < RedisStructure

  def initialize(key)
    super(key, :set)
  end

  def expandable?
    Main.redis.scard(key) > 0
  end

  def children
    unless @children
      @children = []
      set_children = Main.redis.smembers(key)

      set_children.each do |v|
        @children << RedisStructureString.new(nil, v)
      end
    end

    @children
  end
end
