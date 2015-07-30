require_relative 'views/grid_gui'
require_relative 'views/freeform_gui'

module GameMetaData

  module ClassMethods

    def gui_type_as_sym
      underscore(gui_type.to_s)
    end

    protected

    def underscore(word)
      word = word.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end

  end

  def self.included(klass)
    klass.send(:extend, ClassMethods)
  end

  def self.theme_list
    raise "not implemented yet"
  end

  def self.sound_effect_list
    raise "not implemented yet"
  end

  def self.achievement_system
    raise "not implemented yet"
  end

  def self.achievement_system_sym
    raise "not implemented yet"
  end

  def self.game_map
    raise "not implemented yet"
  end

  def self.render_attributes
    raise "not implemented yet"
  end

  def self.gui_type
    raise "not implemented yet"
  end

end
