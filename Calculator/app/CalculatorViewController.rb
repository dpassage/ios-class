class CalculatorViewController < UIViewController
  
  attr_accessor :display
  
  def digitPressed(sender)
    NSLog "#{sender.currentTitle} pressed"
  end
  def operationPressed(sender)
    NSLog "#{sender.currentTitle} pressed"
  end
  def enterPressed
    NSLog "Enter pressed"
  end
end