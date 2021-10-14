module OccTyping
  abstract struct Term
    # Convenience method for more succinct instantiation in tests.
    def self.[](*args); new(*args) end
  end

  struct TermVar < Term
    property name : String
    def initialize(@name)
    end

    def pretty_print(format : PrettyPrint)
      format.text(@name)
    end
  end

  struct TermLambda < Term
    property param_type : Type # TODO: extend to allow multiple params
    property param_name : String # TODO: extend to allow multiple params
    property body : StructRef(Term)
    def initialize(@param_type, @param_name, body)
      @body = StructRef(Term).new(body)
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
        @body.value.pretty_print(format)
      }
    end
  end

  struct TermApply < Term
    property fn : StructRef(Term)
    property arg : StructRef(Term) # TODO: extend to allow multiple args
    def initialize(fn, arg)
      @fn = StructRef(Term).new(fn)
      @arg = StructRef(Term).new(arg)
    end

    def pretty_print(format : PrettyPrint)
      fn.value.pretty_print(format)
      format.surround("(", ")", left_break: "", right_break: nil) {
        @arg.value.pretty_print(format)
      }
    end
  end

  struct TermIfIsThenElse < Term
    property input : StructRef(Term)
    property type : Type
    property body : StructRef(Term)
    property else_body : StructRef(Term)
    def initialize(input, @type, body, else_body)
      @input = StructRef(Term).new(input)
      @body = StructRef(Term).new(body)
      @else_body = StructRef(Term).new(else_body)
    end

    def pretty_print(format : PrettyPrint)
      format.surround("(", ")", left_break: "", right_break: nil) {
        format.text("if ")
        @input.value.pretty_print(format)
        format.text(" is ")
        type.pretty_print(format)
        format.text(" then ")
        @body.value.pretty_print(format)
        format.text(" else ")
        @else_body.value.pretty_print(format)
      }
    end
  end
end
