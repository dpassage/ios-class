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
      @cb.pushOperand("x")
      @cb.pushOperand("x")
      @cb.performOperation("+")
      program = @cb.program
      vars = CalculatorBrain.variablesUsedInProgram program
      vars.size.should == 1
    end
  end
end