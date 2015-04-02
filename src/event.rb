class Event

  attr_reader :type, :content

  def initialize(type, content)
    @type = type
    @content = content
  end

  def to_s
    "t:#{type} c:#{content}"
  end
end