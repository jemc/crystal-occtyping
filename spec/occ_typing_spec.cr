require "./spec_helper"

describe OccTyping do
  # Test cases taken from Table 1 (page 23) of the following paper:
  # - https://www.irif.fr/~gc/papers/occurrencetyping.pdf
  it "handles example cases from the paper" do
    # TODO: Add the TermLet layer to this example that the paper has in it.
    TermLambda[TypeUnion[TypeBase::INT, TypeBase::BOOL], "y",
      TermIfIsThenElse[
        TermVar["y"],
        TypeBase::INT,
        TermApply[TermVar["incr"], TermVar["y"]],
        TermApply[TermVar["lnot"], TermVar["y"]],
      ]
    ].should have_type("TODO")
  end
end
