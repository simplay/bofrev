# Achievement system models a particular achievement, i.e. its name and the rule
# used to check wheter it is fulfilled. Every achievemnt has a flag, indicating
# whether or no it has been achieved. Every achievement system can register
# arbitrary achievements.
class Achievement

  # Every achievement is defined by a identifier and a rule.
  #
  # @param identifier [Symbol] indicating the name of the achievement
  # @param rule [Proc] a procedure or lambda expression
  #   that can be evaluated wheter the achievement is fulfilled.
  #   This Proc is supposed to return a boolean expression.
  # @info: Threas a RuntimeError when rule is not a Proc.
  def initialize(identifier, rule)
    raise "rule is not of type Proc but is equal #{rule.inspect}" unless rule.is_a? Proc
    @rule = rule
    @identifier = identifier
    @is_achieved = false
  end

  # Obtain unique identifier of this achievement.
  #
  # @info: This is used in a AchievementSystem to query for this particular Achievement.
  # @return [Symbol] unique identifier of this achievement
  def identifier
    @identifier
  end

  # Is this achievement already achieved after evaluating its rule.
  # As soon as a Achievement is fulfilled, it remains marked a fulfilled.
  #
  # @hint: This is used to flag all achieved acheivements in a AchievementSystem's list.
  # @return [Boolean] true if achieved otherwise false.
  def achieved?
    @is_achieved
  end

  # Check whether this Achievement's rule is true for a given evaluation argument.
  #
  # @hint: Wrties the state of @is_achived.
  # @todo: make this more abstract (introduce a rule class to check for responding to arg).
  # @param [Object] an input argugment that we can apply on this Achievement's rule.
  # @return [Boolean] true if rule evaluation yielded true (or already did once), false otherwise.
  def check_rule(given_value)
    return true if achieved?
    @is_achieved = @rule.call(given_value)
  end

end
