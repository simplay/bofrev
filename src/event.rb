class Event

  attr_reader :type, :content

  def initialize(type, content=nil)
    @type = type
    @content = content
  end

  def to_s
    "type: #{type} content: #{content}"
  end
end
