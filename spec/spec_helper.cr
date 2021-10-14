require "spec"
require "../src/occ_typing"

include OccTyping

# Introduce an expectation that the left side term should be inferred
# as having a type whose shown string matches the right side.
def have_type(type_string)
  OccTyping::TypeExpectation.new(type_string)
end

class OccTyping::TypeExpectation
  @type_string : String

  def initialize(@type_string)
  end

  def actual_type_string(term : Term)
    "TODO"
  end

  def match(term)
    @type_string == actual_type_string(term)
  end

  def failure_message(term : Term)
    <<-MSG
    #{term.pretty_inspect}

    ---

    Expected type: #{@type_string}
         got type: #{actual_type_string(term)}
    MSG
  end

  def negative_failure_message(term : Term)
    <<-MSG
      Expected not to have type: #{@type_string}
    MSG
  end
end
