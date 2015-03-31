class Event

  attr_reader :type, :content

  def initialize(type, content)
    @type = type
    @content = content
  end

end