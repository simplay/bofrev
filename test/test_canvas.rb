require "test_helper"
java_import 'javax.swing.JPanel'

class TestCanvas < Minitest::Test

  class ACanvas < Canvas
    def public_scope_draw(g)
      drawing_methods(g)
    end
  end

  def test_initialize
    canvas = Canvas.new
    background_color = canvas.get_background
    assert_equal(Color.white.to_awt_color, background_color)
    assert_includes(Canvas, RenderHelpers)
    assert_respond_to(canvas, :paintComponent)
    assert_respond_to(canvas, :game=)
  end

  def test_descendent_of_canvas_must_implement_drawing_methods
    assert_raises(RuntimeError, "not implemented yet"){ACanvas.new.public_scope_draw(nil)}
  end

end
