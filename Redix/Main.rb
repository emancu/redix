require ObjCHiredis.rb

class Main
  attr_accessor :window
  attr_accessor :key
  attr_accessor :value


  def self.redis
    @@redis ||= ObjCHiredis.redisRb
  end

  def awakeFromNib
    Main.redis # initialize
  end

  def redis_set(sender)
    @@redis[key.stringValue]= value.stringValue
    puts "Set"
  end

  def redis_get(sender)
    value.setStringValue(@@redis[key.stringValue])
    puts "Get"
  end
end
