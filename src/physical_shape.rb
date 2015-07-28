require_relative 'shape'
class PhysicalShape < Shape

  def initialize(type = :default, position = Point2f.new, drawable=true, update_rate=20, sprite_folder_name = 'dummy/')
    super(type, position, drawable, update_rate, sprite_folder_name)
  end

end
