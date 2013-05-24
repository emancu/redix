class RedisDataSource
  attr_accessor :outlineView

  def initialize
    refresh_table(self)
  end

  def refresh_table(sender)
    @dataSource = []
    keys = Main.redis.keys '*'

    keys.each do |key|
      @dataSource << RedisStructure.create(key)
    end

    only_string = @dataSource.select(&:string?)

    string_values = Main.redis.mget(*only_string.map(&:key))

    only_string.each_with_index do |structure, index|
      structure.value = string_values[index]
    end

    outlineView.reloadData if outlineView
  end

  # This method is called before expand the tree
  def outlineView(anOutlineView, child: index, ofItem: anItem)
    if anItem
      anItem.children[index]
    else
      @dataSource[index]
    end
  end

  def outlineView(anOutlineView, objectValueForTableColumn: aColumn, byItem: anItem)
    if anItem
      anItem.send aColumn.identifier
    else
      @dataSource.first
    end
  end

  def outlineView(anOutlineView, numberOfChildrenOfItem: anItem)
    anItem ? anItem.children.size : @dataSource.size
  end

  def outlineView(anOutlineView, isItemExpandable: anItem)
    anItem && anItem.expandable?
  end
end
