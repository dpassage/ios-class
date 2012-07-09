describe "CalculatorBrain" do
  before do
    @cb = CalculatorBrain.new
  end
  
  it "can use variables" do
    @cb.pushVariable("x")
    @cb.pushVariable("y")
    result = @cb.performOperation("+")
    result.should == 0
    
    program = @cb.program
    
    result = CalculatorBrain::runProgram(program, usingVariableValues:{"x" => 2, "y" => 4})
    result.should == 6
    
    vars = CalculatorBrain::variablesUsedInProgram program
    vars.size.should == 2
    vars.include?("x").should == true
    vars.include?("y").should == true
  end
  describe "::variablesUsedInProgram" do
    it "returns nil if no vars used" do
      @cb.pushOperand(1)
      @cb.pushOperand(1)
      @cb.performOperation("+")
      program = @cb.program
      vars = CalculatorBrain.variablesUsedInProgram program
      vars.should == nil
    end
    it "returns only one instance of each variable" do
      @cb.pushVariable("x")
      @cb.pushVariable("x")
      @cb.performOperation("+")
      program = @cb.program
      vars = CalculatorBrain.variablesUsedInProgram program
      vars.size.should == 1
    end
  end
  describe "::describeProgram" do
    it "handles 3 E 5 E 6 E 7 + * -" do
      @cb.pushOperand(3)
      @cb.pushOperand(5)
      @cb.pushOperand(6)
      @cb.pushOperand(7)
      @cb.performOperation("+")
      @cb.performOperation("*")
      @cb.performOperation("-")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "3 - 5 * (6 + 7)"
    end
    it "handles 3 E 5 + sqrt" do
      @cb.pushOperand(3)
      @cb.pushOperand(5)
      @cb.performOperation("+")
      @cb.performOperation("sqrt")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "sqrt(3 + 5)"
    end
    it "handles 3 sqrt sqrt" do
      @cb.pushOperand(3)
      @cb.performOperation("sqrt")
      @cb.performOperation("sqrt")
      program = @cb.program
      
      CalculatorBrain.descriptionOfProgram(program).should == "sqrt(sqrt(3))"
    end
    it "handles 3 E 5 sqrt +" do
      @cb.pushOperand(3)
      @cb.pushOperand(5)
      @cb.performOperation("sqrt")
      @cb.performOperation("+")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "3 + sqrt(5)"
    end
    it "handles π r r * * " do
      @cb.performOperation("π")
      @cb.pushVariable("r")
      @cb.pushVariable("r")
      @cb.performOperation("*")
      @cb.performOperation("*")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "π * r * r"
    end
    it "handles a a * b b * + sqrt" do
      @cb.pushVariable("a")
      @cb.pushVariable("a")
      @cb.performOperation("*")
      @cb.pushVariable("b")
      @cb.pushVariable("b")
      @cb.performOperation("*")
      @cb.performOperation("+")
      @cb.performOperation("sqrt")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "sqrt(a * a + b * b)"
    end
    it "handles 3 E 5 + 6 *" do
      @cb.pushOperand(3)
      @cb.pushOperand(5)
      @cb.performOperation("+")
      @cb.pushOperand(6)
      @cb.performOperation("*")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "(3 + 5) * 6"
    end
    it "handles 3 E 5 E" do
      @cb.pushOperand(3)
      @cb.pushOperand(5)
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "5, 3"
    end
    it "3 E 5 + 6 E 7 * 9 sqrt" do
      @cb.pushOperand(3)
      @cb.pushOperand(5)
      @cb.performOperation("+")
      @cb.pushOperand(6)
      @cb.pushOperand(7)
      @cb.performOperation("*")
      @cb.pushOperand(9)
      @cb.performOperation("sqrt")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "sqrt(9), 6 * 7, 3 + 5"
    end    
    it "handles 3 E 4 E 5 E + -" do
      @cb.pushOperand(3)
      @cb.pushOperand(4)
      @cb.pushOperand(5)
      @cb.performOperation("+")
      @cb.performOperation("-")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "3 - (4 + 5)"
    end
    it "handles 3 E 4 E 5 E * /" do
      @cb.pushOperand(3)
      @cb.pushOperand(4)
      @cb.pushOperand(5)
      @cb.performOperation("*")
      @cb.performOperation("/")
      program = @cb.program
      CalculatorBrain.descriptionOfProgram(program).should == "3 / (4 * 5)"
    end
  end
end
