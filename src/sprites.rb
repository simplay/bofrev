require 'tk'

class Sprites

  # @param sprites_path [String] sprite path name stored in 'sprites/'
  # @param file_type [String] file type of files in :sprite_sample 'sprites/'
  def initialize(sprites_path, file_type="gif")
    names = Dir["sprites/#{sprites_path}/*.#{file_type}"]
    @images = names.map do |filename|
      TkPhotoImage.new(:file => filename)
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

end
