module OccTyping
  class Typer
    alias Env = Nil

    def initialize
      @memo = {} of Term => Type
    end

    def typeof(env : Env, term : Term) : Type
      # Return the memoized type if we have already typed this particular term.
      # Terms are classes (identity equality), so we can memoize by identity,
      # without risking collision with another term that is structurally equal.
      already_memoized = @memo[term]?
      return already_memoized if already_memoized

      TypeBase.new("TODO")
    end
  end
end
