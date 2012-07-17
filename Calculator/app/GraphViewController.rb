class GraphViewController < UIViewController
  attr_accessor :graph
  attr_accessor :graphLabel
  attr_accessor :program

  def viewDidLoad
    NSLog("GraphViewController loaded!")
    graphLabel.text = CalculatorBrain.descriptionOfProgram(program)
  end
end
