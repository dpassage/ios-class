class GraphViewController < UIViewController
  # IBOutlets
  attr_accessor :graph
  attr_accessor :graphLabel
  attr_accessor :tool_bar

  attr_accessor :program
  attr_accessor :split_view_bar_button_item

  def program=(program)
    @program = program
    graph.setNeedsDisplay if graph
    graphLabel.text = CalculatorBrain.descriptionOfProgram(program) if graphLabel
  end

  def split_view_bar_button_item=(button)
    if @split_view_bar_button_item != button
      tool_bar_items = Array.new(tool_bar.items)
      if @split_view_bar_button_item 
        tool_bar_items.delete @split_view_bar_button_item
      end
      if button
        tool_bar_items.unshift button
      end
      self.tool_bar.items = tool_bar_items
      @split_view_bar_button_item = button
    end
  end

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
