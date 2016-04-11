class GameOfRooms
  def initialize
    @current_space = nil
    @player_input = nil
  end

  def init_rooms
    bedroom = Space.new("bedroom")
    living_room = Space.new("living room")
    bathroom = Space.new("bathroom")
    kitchen = Space.new("kitchen")
    backyard = Space.new("backyard")
    bedroom_east = Door.new("east", "unlocked")
    living_west_door = Door.new("west", "unlocked")
    living_south_door = Door.new("south", "unlocked")
    living_east_door = Door.new("east", "locked")
    living_north_door = Door.new("north", "locked")
    bathroom_door = Door.new("north", "unlocked")
    backyard_door = Door.new("south", "locked")
    bedroom.connect_room(bedroom_east, living_room)
    living_room.connect_room(living_west_door, bedroom)
    living_room.connect_room(living_south_door, bathroom)
    living_room.connect_room(living_east_door, kitchen)
    living_room.connect_room(living_north_door, backyard)
    bathroom.connect_room(bathroom_door, living_room)
    kitchen.connect_room(living_west_door, living_room)
    backyard.connect_room(backyard_door, living_room)
    @current_space = bedroom
  end

  def start
    setup
    Kernel.loop do
      print "You are in the #{@current_space.description}."
      @current_space.connections
      print "\n>"
      user_input
      action
    end
  end

  def user_input
    @player_input = gets.chomp.downcase
  end

  def action
    if @current_space.door?(@player_input)
      @current_space = @current_space.doors[@player_input]
    else
      puts "sorry, you can't do that here"
    end
  end
end
