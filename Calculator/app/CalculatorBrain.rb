class CalculatorBrain

  def operand_stack
    @operand_stack = [] unless @operand_stack
    @operand_stack
  end

  def pushOperand(operand)
    self.operand_stack.push(operand)
  end
  
  def popOperand
    if self.operand_stack.size == 0
      0
    else
      self.operand_stack.pop
    end
  end

  def performOperation(operation)
    result = 0.0
    
    if operation == "+"
      result = self.popOperand + self.popOperand
    elsif operation == "*"
      result = self.popOperand * self.popOperand
    elsif operation == "-"
      subtrahend = self.popOperand
      result = self.popOperand = subtrahend
    elsif operation == "/"
      divisor = self.popOperand
      result = self.popOperand / divisor unless divisor == 0
    elsif operation == "sin"
      result = Math::sin(self.popOperand)
    elsif operation == "cos"
      result = Math::cos(self.popOperand)
    elsif operation == "sqrt"
      result = Math::sqrt(self.popOperand)
    elsif operation == "π"
      result = Math::PI
    elsif operation == "+/-"
      result = - self.popOperand
    end

    self.pushOperand result 
    result
  end
  
  def reset_state
    @operand_stack = []
  end
end
