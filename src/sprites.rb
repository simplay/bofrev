require 'tk'

class Sprites
  def initialize(sprite_sample, file_type="gif")
    names = Dir["sprites/#{sprite_sample}/*.#{file_type}"]
    @images = names.map do |filename|
      TkPhotoImage.new(:file => filename)
    end
    @current_idx = 0
  end

  def images
    @images
  end

  def count
    @images.count
  end

  def next_image
    img = @images[@current_idx]
    @current_idx = (@current_idx + 1) % count
    img
  end

end
