class RedisStructureList < RedisStructure

  def initialize(key)
    super(key, :list)
  end

  def expandable?
    Main.redis.llen(key) > 0
  end

  def children
    unless @children
      @children = []
      list_children = Main.redis.lrange(key, 0, -1)

      list_children.each_with_index do |v, index|
        @children << RedisStructureString.new(index, v)
      end
    end

    @children
  end
end
