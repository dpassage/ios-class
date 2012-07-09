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

  def self.descriptionOfProgram(program)
    stack = program.clone
    result = describe_stack(stack)
    while stack.length > 0
      result = result + ", " + describe_stack(stack)
    end
    result
  end
  
  def self.describe_stack(stack)
    result = ""
    
    top_of_stack = stack.pop
    if top_of_stack.is_a? Numeric
      result = top_of_stack.to_s
    elsif self.is_variable?(top_of_stack)
      result = top_of_stack
    elsif self.is_nonary_operator?(top_of_stack)
      result = top_of_stack
    elsif self.is_unary_operator?(top_of_stack)
      result = top_of_stack + "(" + describe_stack(stack) + ")"
    elsif self.is_binary_operator?(top_of_stack)
      rhs = if self.is_binary_operator?(stack[-1], with_lower_precedence_than:top_of_stack) ||
               (top_of_stack == "-" && self.is_additive_operator?(stack[-1])) ||
               (top_of_stack == "/" && self.is_multplicative_operator?(stack[-1]))
               
              "(" + describe_stack(stack) + ")"
            else
              describe_stack(stack)
            end
      lhs = if self.is_binary_operator?(stack[-1], with_lower_precedence_than:top_of_stack)
              "(" + describe_stack(stack) + ")"
            else
              describe_stack(stack)
            end
      result = lhs + " " + top_of_stack + " " + rhs
    end
    result
  end
  
  def self.runProgram(program, usingVariableValues:vars)
    stack = program.collect do |item|
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
  
  def self.is_nonary_operator?(item)
    ["π"].include?(item)
  end
  
  def self.is_unary_operator?(item)
    ["sin", "cos", "sqrt", "+/-"].include?(item)
  end
  
  def self.is_additive_operator?(item)
    ["+", "-", ].include?(item)
  end
  
  def self.is_multplicative_operator?(item)
    ["*", "/", ].include?(item)
  end
  
  def self.is_binary_operator?(item, with_lower_precedence_than:otheritem)
    answer = self.is_additive_operator?(item) && self.is_multplicative_operator?(otheritem)
    NSLog("is_binary_operator?: #{item} with_lower_precedence_than:#{otheritem} ans #{answer}")
    answer
  end
  
  def self.is_binary_operator?(item)
    self.is_additive_operator?(item) ||
    self.is_multplicative_operator?(item)
  end
  def self.is_operator?(item)
    self.is_nonary_operator?(item) ||
    self.is_unary_operator?(item) ||
    self.is_binary_operator?(item)
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
        operand = pop_operand_off_program_stack(stack)
        result = Math::sqrt(operand) unless operand < 0
      elsif operation == "π"
        result = Math::PI
      elsif operation == "+/-"
        result = - pop_operand_off_program_stack(stack)
      end
    end

    result
  end

end
