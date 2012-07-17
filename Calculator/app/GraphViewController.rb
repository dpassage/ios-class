class GraphViewController < UIViewController
  attr_accessor :graph
  attr_accessor :graphLabel
  attr_accessor :program

  def setGraph(graph)
    @graph = graph
    @graph.data_source = self
  end

  def viewDidLoad
    NSLog("GraphViewController loaded!")
    graphLabel.text = CalculatorBrain.descriptionOfProgram(program)
  end

  def y_value_for_x(x)
    CalculatorBrain.runProgram(program, usingVariableValues:{ "x" => x })
  end
end
