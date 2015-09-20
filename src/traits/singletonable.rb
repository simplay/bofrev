# Singletonable models the ability of being a singleton.
# A class is supposed to extend the Singletonable module in order
# to become a singleton. Being a singleton ensures to work always with
# the same instance of the Singletonable class.
#
# @example
#
#   class ASingletonClass
#     extend Singletonable
#   end
module Singletonable

  # Returns a singleton of the extending class
  #
  # @return [self] new instance of type of extending class.
  def singleton
    @unique_instance ||= self.new
  end

end
