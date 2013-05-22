#
#  Main.rb
#  Redix
#
#  Created by Emiliano Mancuso on 11/05/13.
#  Copyright 2013 Emiliano Mancuso. All rights reserved.
#

require ObjCHiredis.rb

class Main
  attr_accessor :window
  attr_accessor :key
  attr_accessor :value
  attr_accessor :tableView
  
  def awakeFromNib
    @redis = ObjCHiredis.redisRb

    update_table(self)
  end
  
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end
  
  def numberOfRowsInTableView(aTableView)
    @data.size
  end
  
  def tableView(aTableView, objectValueForTableColumn: aColumn, row: rowIndex)
    @data[rowIndex][aColumn.identifier.to_sym]
  end
  
  def update_table(sender)
    @data = []
    @keys = @redis.keys('*')
    
    # Use MGET instead
    @keys.each do |key|
      @data << {
        key: key,
        type: @redis.type(key),
        value: @redis[key]
      }
    end

    tableView.reloadData
  end
  
  def redis_set(sender)
    @redis[key.stringValue]= value.stringValue
    puts "Set"
  end
  
  def redis_get(sender)
    value.setStringValue(@redis[key.stringValue])
    puts "Get"
  end
end