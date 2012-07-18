class GraphViewController < UIViewController
  attr_accessor :graph
  attr_accessor :graphLabel
  attr_accessor :program

  def setGraph(graph)
    @graph = graph
    @graph.data_source = self
    @graph.addGestureRecognizer(UIPinchGestureRecognizer.alloc.initWithTarget(@graph, action: "pinch:"))
    @graph.addGestureRecognizer(UIPanGestureRecognizer.alloc.initWithTarget(@graph, action:"pan:"))
    tapGesture = UITapGestureRecognizer.alloc.initWithTarget(@graph, action:"tap:")
    tapGesture.numberOfTapsRequired = 3
    @graph.addGestureRecognizer(tapGesture)
  end

  def viewDidLoad
    NSLog("GraphViewController loaded!")
    graphLabel.text = CalculatorBrain.descriptionOfProgram(program)
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    true
  end
  
  def y_value_for_x(x)
    CalculatorBrain.runProgram(program, usingVariableValues:{ "x" => x })
  end
end
