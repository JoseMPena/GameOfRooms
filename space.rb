class Space
  attr_reader(:description, :doors)
  def initialize(description)
    @description = description
    @doors = {}
  end

  def connect_room(door, room)
    @doors.store(door.direction, room) unless @doors.key?(door.direction)
  end

  def connections
    print "There is a door to the "
    @doors.keys.each { |direction| print "#{direction}, " }
  end

  def door?(input)
    @doors.key?(input) ? true : false
  end
end
