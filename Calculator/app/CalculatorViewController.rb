class CalculatorViewController < UIViewController

  attr_accessor :display
  attr_accessor :ticker
  
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
    update_ticker
  end

  def operationPressed(sender)
    NSLog "#{sender.currentTitle} pressed"
    if @user_in_the_middle_of_entering_a_number
      enterPressed
    end
    operation = sender.currentTitle
    result = brain.performOperation(operation)
    display.text = format_result(result)
    update_ticker
  end
  
  def clearPressed
    NSLog "Clear pressed"
    self.display.text = "0"
    self.ticker.text = ""
    @user_in_the_middle_of_entering_a_number = false
    self.brain.reset_state
  end
  
  def backspacePressed
    NSLog "Backspace Pressed"
    self.display.text = self.display.text[0..-2]
    if self.display.text == ""
      self.display.text = "0"
      @user_in_the_middle_of_entering_a_number = false
    end
  end
  
  def plusMinusPressed
    NSLog "+/- Pressed"
    if @user_in_the_middle_of_entering_a_number
      change_display_sign
    else
      result = brain.performOperation("+/-")
      self.display.text = format_result(result)
      update_ticker
    end
  end

  def update_ticker
    program = brain.program
    self.ticker.text = CalculatorBrain.descriptionOfProgram program
  end
  
  def change_display_sign
    if self.display.text[0] == "-"
      self.display.text = self.display.text[1..-1]
    else
      self.display.text = "-" + self.display.text
    end
  end
  
  def format_result(result)
    if (result % 1) == 0
      "%g" % result
    else
      "%f" % result
    end
  end

end
