class GameOfRooms
  def initialize
    @current_space = nil
    @player_input = nil
    @rooms = {}
    @exits = {}
  end

  def setup
    room_builder
    door_builder
    room_connector
    @current_space = @rooms["bedroom"]
  end

  def room_builder
    bedroom     = Space.new("bedroom")
    living_room = Space.new("living room")
    bathroom    = Space.new("bathroom")
    kitchen     = Space.new("kitchen")
    backyard    = Space.new("backyard")
    @rooms = {
      "bedroom"     => bedroom,
      "living_room" => living_room,
      "bathroom"    => bathroom,
      "kitchen"     => kitchen,
      "backyard"    => backyard
    }
  end

  def door_builder
    @exits = {
      "bedroom_east"      => Door.new("east", "unlocked"),
      "living_west_door"  => Door.new("west", "unlocked"),
      "living_south_door" => Door.new("south", "unlocked"),
      "living_east_door"  => Door.new("east", "locked"),
      "living_north_door" => Door.new("north", "locked"),
      "bathroom_door"     => Door.new("north", "unlocked"),
      "backyard_door"     => Door.new("south", "locked")
    }
  end

  def room_connector
    @rooms["bedroom"].connect_room(@exits["bedroom_east"], @rooms["living_room"])
    @rooms["living_room"].connect_room(@exits["living_west_door"], @rooms["bedroom"])
    @rooms["living_room"].connect_room(@exits["living_south_door"], @rooms["bathroom"])
    @rooms["living_room"].connect_room(@exits["living_east_door"], @rooms["kitchen"])
    @rooms["living_room"].connect_room(@exits["living_north_door"], @rooms["backyard"])
    @rooms["bathroom"].connect_room(@exits["bathroom_door"], @rooms["living_room"])
    @rooms["kitchen"].connect_room(@exits["living_west_door"], @rooms["living_room"])
    @rooms["backyard"].connect_room(@exits["backyard_door"], @rooms["living_room"])
  end

  def init_items
    @current_space.add_items(Item.new("key", %w("get", "take", "pick")))
  end

  def start
    setup
    init_items
    Kernel.loop do
      binding.pry
      print "You are in the #{@current_space.description}."
      @current_space.connections
      @current_space.items
      print "\n>"
      user_input
      action
    end
  end

  def user_input
    @player_input = gets.chomp.downcase
    @player_input = @player_input.split(" ")
  end

  def action
    if @current_space.door?(@player_input[0])
      @current_space = @current_space.doors[@player_input]#[0]
    elsif @current_space.action?(@player_input[0], @player_input[1])
      puts "success"
    else
      puts "sorry, you can't do that here"
    end
  end
end
