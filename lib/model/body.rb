class Body
  attr_accessor :name, :mass, :position, :velocity

  # TODO: change position & velocity to RVec3
  # TODO: ensure mass is a float
  def initialize(name, mass, position, velocity)
    @name = name
    @mass = mass
    @position = position
    @velocity = velocity
  end
end