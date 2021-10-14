module OccTyping
  abstract class Term
    # Convenience method for more succinct instantiation in tests.
    def self.[](*args); new(*args) end
  end

  class TermVar < Term
    property name : String
    def initialize(@name)
    end

    def pretty_print(format : PrettyPrint)
      format.text(@name)
    end
  end

  class TermLambda < Term
    property param_type : Type # TODO: extend to allow multiple params
    property param_name : String # TODO: extend to allow multiple params
    property body : Term
    def initialize(@param_type, @param_name, @body)
    end

    def pretty_print(format : PrettyPrint)
      format.surround("(fun ", ")", left_break: " ", right_break: nil) {
        format.surround("(", ")", left_break: nil, right_break: nil) {
          format.text(@param_name)
          format.text(" : ")
          @param_type.pretty_print(format)
        }
        format.text(" ->")
        format.breakable(" ")
        @body.pretty_print(format)
      }
    end
  end

  class TermApply < Term
    property fn : Term
    property arg : Term # TODO: extend to allow multiple args
    def initialize(@fn, @arg)
    end

    def pretty_print(format : PrettyPrint)
      fn.pretty_print(format)
      format.surround("(", ")", left_break: "", right_break: nil) {
        @arg.pretty_print(format)
      }
    end
  end

  class TermIfIsThenElse < Term
    property input : Term
    property type : Type
    property body : Term
    property else_body : Term
    def initialize(@input, @type, @body, @else_body)
    end

    def pretty_print(format : PrettyPrint)
      format.surround("(", ")", left_break: "", right_break: nil) {
        format.text("if ")
        @input.pretty_print(format)
        format.text(" is ")
        type.pretty_print(format)
        format.text(" then ")
        @body.pretty_print(format)
        format.text(" else ")
        @else_body.pretty_print(format)
      }
    end
  end
end
