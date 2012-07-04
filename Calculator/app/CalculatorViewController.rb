class CalculatorViewController < UIViewController

  attr_accessor :display

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
    NSLog "#{sender.currentTitle} pressed"
  end

  def enterPressed
    NSLog "Enter pressed"
    brain.pushOperand display.text.to_f
    @user_in_the_middle_of_entering_a_number = false
  end

  def operationPressed(sender)
    NSLog "#{sender.currentTitle} pressed"
    if @user_in_the_middle_of_entering_a_number
      enterPressed
    end
    operation = sender.currentTitle
    result = brain.performOperation(operation)
    display.text = result.to_a
  end

end
