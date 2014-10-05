
require 'glut'

# "The x and y callback parameters indicate the mouse in window relative coordinates when the key was pressed."
class DefaultKeyboardController
  def initialize(camera)
    @camera = camera
  end

  def attach
    #Glut::glutIgnoreKeyRepeat(1)
    #Glut::glutKeyboardFunc(method(:glut_normal_keyboard_func).to_proc)
    #Glut::glutSpecialFunc(method(:glut_special_keyboard_func).to_proc)
    Glut::glutKeyboardUpFunc(method(:glut_key_up).to_proc)
    #Glut::glutSpecialUpFunc(method(:glut_special_up).to_proc)
  end

  def glut_normal_keyboard_func(key, x, y)
    puts 'normal'
    case key
      when 27.chr
        # ASCII escape
        exit 0
      when 'w'
        @camera.force.z = 20.0
      when 's'
        @camera.force.z = -20.0
      else
        # ?
    end
  end

  def glut_special_keyboard_func(key, x, y)
    puts 'special'
  end

  def glut_key_up()
    puts 'up'
    # case key
    #   when 'w'
    #     @camera.force.z = 0.0
    #   when 's'
    #     @camera.force.z = 0.0
    #   else
    #     # ?
    # end
  end

  def glut_special_up(key, x, y)

  end
end