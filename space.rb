class Space
  attr_accessor(:description, :doors)
  def initialize(description)
    @description = description
    @doors = {}
    @items = []
  end

  def connect_room(door, room)
    return if @doors.key?(door.direction)
    @doors.store(door.direction, [room, door.status])
  end

  def connections
    print "There is a door to the "
    @doors.keys.each { |direction| print "#{direction}, " }
  end

  def door?(input)
    @doors.key?(input) ? true : false
  end

  def add_items(item)
    @items << item
  end

  def items
    @items.each { |item| puts "\nThere is a #{item.name}" }
  end

  def action?(action, item_name)
    @items.each do |item|
      item.name == item_name && item.actions.include?(action) ? true : false
    end
  end
end
