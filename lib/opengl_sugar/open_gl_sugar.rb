require 'opengl'

module OpenGlSugar
  # Pushes and pops the current matrix around the given block.
  def transform
    Gl.glPushMatrix
    yield
    Gl.glPopMatrix
  end
end