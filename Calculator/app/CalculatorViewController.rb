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
    self.ticker.text ="#{self.ticker.text} #{self.display.text}"
  end

  def operationPressed(sender)
    NSLog "#{sender.currentTitle} pressed"
    if @user_in_the_middle_of_entering_a_number
      enterPressed
    end
    operation = sender.currentTitle
    result = brain.performOperation(operation)
    display.text = format_result(result)
    self.ticker.text ="#{self.ticker.text} #{sender.currentTitle}"
  end
  
  def clearPressed
    NSLog "Clear pressed"
    self.display.text = "0"
    self.ticker.text = ""
    @user_in_the_middle_of_entering_a_number = false
    self.brain.reset_state
  end
  
  def format_result(result)
    if (result % 1) == 0
      "%g" % result
    else
      "%f" % result
    end
  end

end
