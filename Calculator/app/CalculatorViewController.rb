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
    if splitViewController
      splitViewController.viewControllers.lastObject.program = nil
    end
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

  def graphPressed
    if splitViewController
      NSLog("Tell graph controller what to do")
      splitViewController.viewControllers.lastObject.program = brain.program
    else
      NSLog("Segue to graph")
    end
  end

  def prepareForSegue(segue, sender:sender)
    if segue.identifier == "Graph"
      segue.destinationViewController.program = brain.program
    end
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    splitViewController ||
    [UIInterfaceOrientationPortrait, 
     UIInterfaceOrientationPortraitUpsideDown].include?(interfaceOrientation)
  end

  private
  
  def update_display
    program = brain.program
    self.ticker.text = CalculatorBrain.descriptionOfProgram program
    result = CalculatorBrain.runProgram(program, usingVariableValues:@test_vars)
    self.display.text = format_result(result) 
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
