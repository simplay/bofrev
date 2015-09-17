module DummyClasses

  # @info is used by:
  #   TestCanvas
  class ACanvas < Canvas
    def public_scope_draw(g)
      drawing_methods(g)
    end
  end

  # @info is used by:
  #   TestGameMetaData
  class FancyView; end

  # @info is used by:
  #   TestGameMetaData
  class FancyAchievementSystem
    def initialize; end

    def self.instance
      FancyAchievementSystem.new
    end
  end

  # @info is used by:
  #   TestGameMetaData
  class ANewMetaDataGame
    extend GameMetaData
  end

  # @info is used by:
  #   TestGameMetaData
  class BNewMetaDataGame
    extend GameMetaData

    def self.gui_type
      FancyView
    end

    def self.achievement_system
      FancyAchievementSystem.instance
    end
  end

  # @info is used by:
  #   TestLayer
  class ANewDrawableL
    def initialize(id="")
      @id = id
      @state = "init"
    end

    def drawable?
      true
    end

    def state
      @state
    end

    def id
      @id
    end

    def update_animation_state
      @state = "#{id}"
    end

    def draw_onto(g)
      @state = "drawing #{id}"
    end
  end

  # @info is used by:
  #   TestObserver
  class ADrawable; end

  # @info is used by:
  #   TestObserver
  class ARandomClass < Observer; end

  # @info is used by:
  #   TestObserver
  class BRandomClass < Observer
    def handle_event
      puts "implemented 1"
    end

    def handle_event_with(message)
      puts "implemented 2"
    end
  end

end
