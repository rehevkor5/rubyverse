require 'opengl'
require 'glu'
require 'glut'

require_relative '../opengl_sugar/open_gl_sugar'

class Renderer
  # Mixin GL and GLUT namespaces available to make code easier to read
  include Gl
  include Glu
  include Glut
  include OpenGlSugar

  def render(body)
    transform do
      glTranslatef(body.position[0], body.position[1], body.position[2])
      glMaterialfv(GL_FRONT, GL_DIFFUSE, [0.8, 0.9, 0.8, 1])
      Glut.glutSolidSphere(2, 30, 30)
    end
  end
end