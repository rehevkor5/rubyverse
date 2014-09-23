require 'rmath3d/rmath3d'

require_relative '../view/renderer'
# require_relative '../model/body'

class Universe
  TIME_PER_TICK = 0.0001

  def initialize(*bodies)
    @bodies = bodies
    @renderer = Renderer.new
  end

  def add_body(body)
    @bodies << body
  end

  def run_simulation_tick
    body_forces = {}

    @bodies.combination(2) do |combo|
      body1 = combo[0]
      body2 = combo[1]
      vec_from_body1 = RMath3D::RVec3.new(body2.position[0] - body1.position[0],
                            body2.position[1] - body1.position[1],
                            body2.position[2] - body1.position[2]
      )
      r_sq = vec_from_body1.getLengthSq

      force = 1.0 * ((body1.mass * body2.mass) / r_sq)

      vec_from_body1.normalize!
      force_on_body_1 = vec_from_body1 * force
      body_forces[body1] ||= []
      body_forces[body1] << force_on_body_1

      force_on_body_2 = force_on_body_1 * -1.0
      body_forces[body2] ||= []
      body_forces[body2] << force_on_body_2
    end



    body_forces.each do |body, forces|
      cumulative_force = forces.inject do |cumulative_force, force|
        # if cumulative_force.nil?
        #   force
        # else
          cumulative_force + force
        # end
      end

      delta_v_x = cumulative_force.x * TIME_PER_TICK / body.mass
      delta_v_y = cumulative_force.y * TIME_PER_TICK / body.mass
      delta_v_z = cumulative_force.z * TIME_PER_TICK / body.mass

      body.velocity[0] += delta_v_x
      body.velocity[1] += delta_v_y
      body.velocity[2] += delta_v_z
    end

    @bodies.each do |body|
      new_position = []
      body.position.zip(body.velocity) do |ary|
        new_position << ary.inject(:+)
      end
      body.position = new_position
    end
  end

  def render
    @bodies.each do |body|
      @renderer.render(body)
    end
  end
end