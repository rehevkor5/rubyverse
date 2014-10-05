require 'rmath3d/rmath3d'
require 'opengl'

require_relative 'body'

class Camera < Body
  include Gl

  attr_accessor :force

  #TODO: duplicate with Universe time per tick... doesn't belong here?
  TIME_PER_TICK = 0.0001

  def initialize
    super('camera', 100, RMath3D::RVec3.new(0.0, 0.0, -50.0), RMath3D::RVec3.new)
    @force = RMath3D::RVec3.new
    #TODO need a drag factor so that in the absence of a force it will slow to a halt
  end

  def run_simulation_tick
    # TODO duplicate code with universe
    delta_v = RMath3D::RVec3.new(@force.x * TIME_PER_TICK / @mass,
                                 @force.y * TIME_PER_TICK / @mass,
                                 @force.z * TIME_PER_TICK / @mass)
    @velocity.add! delta_v

    @position += @velocity
    puts @position
  end

  # Loads identity to the modelview matrix & applies the camera's transformation.
  # Doesn't really "render" anything but it's similar to other render methods...
  def render
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity

    # Camera
    # todo: gluLookAt() is more appropriate
    glTranslatef(@position.x, @position.y, @position.z)
  end
end