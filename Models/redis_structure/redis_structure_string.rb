class RedisStructureString < RedisStructure

  def initialize(key, value = nil)
    super(key, :string, value)
  end

end
