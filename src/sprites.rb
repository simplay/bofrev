require 'java'
java_import 'javax.imageio.ImageIO'

class Sprites

  # @param sprites_path [String] sprite path name stored in 'sprites/'
  # @param file_type [String] file type of files in :sprite_sample 'sprites/'
  def initialize(sprites_path, full_path=false, file_type='gif')
    if full_path
      names = Dir["#{sprites_path}/*.#{file_type}"]
    else
      names = Dir["sprites/#{sprites_path}/*.#{file_type}"]
    end
    @images = names.map do |filename|
      generate_image_for(filename)
    end
    @current_idx = 0
  end

  # Get all sprite images.
  # @return [Array] of TkPhotoImage instances.
  def images
    @images
  end

  # Get number of sprite images used for animation.
  # @return [Integer] number of images.
  def count
    @images.count
  end

  # Get successor sprite image.
  # @return [TkPhotoImage] image used for current animation.
  def next_image
    img = @images[@current_idx]
    @current_idx = (@current_idx + 1) % count
    img
  end

  protected

  # @param filename [String] image file name
  def generate_image_for(filename)
    ImageIO.read(java.io.File.new(filename))
  end

end
