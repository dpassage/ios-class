class CalculatorViewController < UIViewController

  attr_accessor :display
  attr_accessor :ticker
  attr_accessor :variables
  
  def brain
    @brain = CalculatorBrain.alloc.init unless @brain
    @brain
  end

  def digitPressed(sender)
    NSLog "#{sender.currentTitle} pressed"
    digit = sender.currentTitle
    if @user_in_the_middle_of_entering_a_number
      self.display.text = self.display.text + digit
    else
      self.display.text = digit
      @user_in_the_middle_of_entering_a_number= true
    end
  end
  
  def decimalPressed
    NSLog ". pressed"
    if @user_in_the_middle_of_entering_a_number
      self.display.text = self.display.text + "." unless self.display.text.index('.')
    else
      self.display.text = "."
      @user_in_the_middle_of_entering_a_number= true
    end 
  end
  
  def enterPressed
    NSLog "Enter pressed"
    brain.pushOperand display.text.to_f
    @user_in_the_middle_of_entering_a_number = false
    update_display
  end

  def operationPressed(sender)
    NSLog "#{sender.currentTitle} pressed"
    if @user_in_the_middle_of_entering_a_number
      enterPressed
    end
    operation = sender.currentTitle
    result = brain.performOperation(operation)
    display.text = format_result(result)
    update_display
  end
  
  def clearPressed
    NSLog "Clear pressed"
    @user_in_the_middle_of_entering_a_number = false
    @test_vars = nil
    self.brain.reset_state
    update_display
  end
  
  def backspacePressed
    NSLog "Backspace Pressed"
    if @user_in_the_middle_of_entering_a_number
      self.display.text = self.display.text[0..-2]
      if self.display.text == ""
        self.display.text = "0"
        @user_in_the_middle_of_entering_a_number = false
      end
    else
      brain.undo
      update_display
    end
  end
  
  def plusMinusPressed
    NSLog "+/- Pressed"
    if @user_in_the_middle_of_entering_a_number
      change_display_sign
    else
      result = brain.performOperation("+/-")
      self.display.text = format_result(result)
      update_display
    end
  end

  def variablePressed(sender)
    NSLog("variable #{sender.currentTitle} pressed")
    brain.pushVariable(sender.currentTitle)
    update_display
  end

  def update_display
    program = brain.program
    self.ticker.text = CalculatorBrain.descriptionOfProgram program
    result = CalculatorBrain.runProgram(program, usingVariableValues:@test_vars)
    self.display.text = format_result(result)
    vars_used = CalculatorBrain.variablesUsedInProgram(program)
    if @test_vars
      self.variables.text = vars_used.inject("") do |string, var|
        if @test_vars[var]
          string += "%s = %g " % [var, @test_vars[var]]
        else
          string
        end
      end
    else
      self.variables.text = ""
    end
  end

  def change_display_sign
    if self.display.text[0] == "-"
      self.display.text = self.display.text[1..-1]
    else
      self.display.text = "-" + self.display.text
    end
  end
  
  def format_result(result)
    "%g" % result
  end

end
