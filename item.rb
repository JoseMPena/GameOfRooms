class Item
  attr_accessor(:name, :actions)
  def initialize(name, actions)
    @name = name
    @actions = actions
  end

  def add_action(action)
    @actions << action
  end

  def remove_action(action)
    return unless @actions.include?(action)
    @actions.slice(@actions.index(action))
  end
end
