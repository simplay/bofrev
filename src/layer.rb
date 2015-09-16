# A layer acts as a container of drawale instances that are supposed to be drawn
# onto a canvas the same time. For example, there is a background layer, drawing
# the background image, the middleground layer, only updated when the ticker
# notifies the game and the foreground layer, that is updated at every Thicker tic
# and whenever bofrev receives a user input.
class Layer

  # Every layer has initial an empty Array colled drawables to manage
  # its drawable instances.
  def initialize
    @drawables = []
  end

  # Append a drawable to its internal drawable list.
  #
  # @param drawable [Drawable] a drawable instance that responds
  #   to #update_animation_state, #draw_onto and #drawable?
  def append(drawable)
    @drawables << drawable
  end

  # Update the animation state of all Drawable instances contained
  # in the list of all drawables of this Layer.
  def update_drawables
    @drawables.each &:update_animation_state
  end

  # Draw all drawables of this Layer onto a given graphics.
  #
  # @param graphics [Java::Graphics] used by Awt.
  def draw_drawables_onto(graphics)
    @drawables.each do |drawable|
      drawable.draw_onto(graphics) if drawable.drawable?
    end
  end

end
