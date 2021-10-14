module OccTyping
  abstract class Type
    # Convenience method for more succinct instantiation in tests.
    def self.[](*args); new(*args) end
  end

  class TypeBase < Type
    property name : String
    def initialize(@name)
    end

    def pretty_print(format : PrettyPrint)
      format.text(@name)
    end

    INT = TypeBase.new("Int")
    BOOL = TypeBase.new("Bool")
  end

  class TypeUnion < Type
    property lhs : Type
    property rhs : Type
    def initialize(@lhs, @rhs)
    end

    def pretty_print(format : PrettyPrint)
      format.surround("(", ")", left_break: "", right_break: nil) {
        @lhs.pretty_print(format)
        format.text(" | ")
        @rhs.pretty_print(format)
      }
    end
  end

  class TypeFunction < Type
    property param : Type # TODO: extend to allow multiple params
    property ret : Type
    def initialize(@param, @ret)
    end

    def pretty_print(format : PrettyPrint)
      format.surround("(", ")", left_break: "", right_break: nil) {
        @param.pretty_print(format)
        format.text(" -> ")
        @ret.pretty_print(format)
      }
    end
  end
end
