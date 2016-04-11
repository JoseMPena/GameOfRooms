class Door
  attr_accessor(:direction, :status)
  def initialize(direction, status)
    @direction = direction
    @status = status
  end
end
