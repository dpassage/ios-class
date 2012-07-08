class CalculatorBrain

  def program
    self.program_stack.clone
  end

  def pushOperand(operand)
    self.program_stack.push(operand)
  end

  def pushVariable(var)
    self.program_stack.push(var) unless CalculatorBrain.is_operator?(var)
  end
  
  def performOperation(operation)
    self.program_stack.push(operation)
    CalculatorBrain.runProgram(self.program)
  end

  def reset_state
    @program_stack = []
  end

  def self.description_of_program(program)
    "Implement this in Homework #2"
  end

  def self.runProgram(program, usingVariableValues:vars)
    stack = program.collect do |item|
      NSLog("#{item}")
      if self.is_variable?(item)
        vars[item] ? vars[item] : 0
      else
        item
      end
    end
    pop_operand_off_program_stack(stack)
  end

  def self.runProgram(program)
    self.runProgram(program, usingVariableValues:{})
  end
  
  def self.variablesUsedInProgram(program)
    ret = program.find_all {|item| self.is_variable?(item) }.uniq
    ret.size == 0 ? nil : ret
  end
  # methods below here are private
  
  def self.is_variable?(item)
    item.is_a?(String) && !self.is_operator?(item)
  end
  
  def self.is_operator?(item)
    ["+", "*", "-", "/", "sin", "cos", "sqrt", "+/-", "π"].include?(item)
  end
  
  def program_stack
    @program_stack = [] unless @program_stack
    @program_stack
  end

  def self.pop_operand_off_program_stack(stack)
    result = 0.0

    top_of_stack = stack.pop
    if (top_of_stack.is_a? Numeric) 
      result = top_of_stack
    elsif (top_of_stack.is_a? String)
      operation = top_of_stack
      if operation == "+"
        result = pop_operand_off_program_stack(stack) + pop_operand_off_program_stack(stack)
      elsif operation == "*"
        result = pop_operand_off_program_stack(stack) * pop_operand_off_program_stack(stack)
      elsif operation == "-"
        subtrahend = pop_operand_off_program_stack(stack)
        result = pop_operand_off_program_stack(stack) - subtrahend
      elsif operation == "/"
        divisor = pop_operand_off_program_stack(stack)
        result = pop_operand_off_program_stack(stack) / divisor unless divisor == 0
      elsif operation == "sin"
        result = Math::sin(pop_operand_off_program_stack(stack))
      elsif operation == "cos"
        result = Math::cos(pop_operand_off_program_stack(stack))
      elsif operation == "sqrt"
        result = Math::sqrt(pop_operand_off_program_stack(stack))
      elsif operation == "π"
        result = Math::PI
      elsif operation == "+/-"
        result = - pop_operand_off_program_stack(stack)
      end
    end

    result
  end

end
