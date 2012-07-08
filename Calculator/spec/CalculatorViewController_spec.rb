class MockUILabel 
  attr_accessor :text
end

class MockSender
  attr_accessor :currentTitle
end
class MockSenderFactory
  def title(title)
    sender = MockSender.new
    sender.currentTitle = title
    sender
  end
end
describe "CalculatorViewController" do
  before do
    @cvb = CalculatorViewController.alloc.init
    @cvb.display = MockUILabel.new
    @cvb.ticker = MockUILabel.new
    @factory = MockSenderFactory.new
  end
  
  it "computes 3 + 3" do
    @cvb.digitPressed(@factory.title("3"))
    @cvb.enterPressed
    @cvb.digitPressed(@factory.title("3"))
    @cvb.operationPressed(@factory.title("+"))
    @cvb.display.text.should == "6"
  end
  it "computes 3 - 2" do
    @cvb.digitPressed(@factory.title("3"))
    @cvb.enterPressed
    @cvb.digitPressed(@factory.title("2"))
    @cvb.operationPressed(@factory.title("-"))
    @cvb.display.text.should == "1"
  end
  it "handles decimals with no leading 0" do
    @cvb.decimalPressed
    @cvb.digitPressed(@factory.title("7"))
    @cvb.digitPressed(@factory.title("5"))
    @cvb.display.text.should == ".75"
    @cvb.enterPressed
    @cvb.digitPressed(@factory.title("4"))
    @cvb.operationPressed(@factory.title("*"))
    @cvb.display.text.should == "3"
  end
  it "ignores the second decimal press" do
    @cvb.decimalPressed
    @cvb.digitPressed(@factory.title("7"))
    @cvb.digitPressed(@factory.title("5"))
    @cvb.decimalPressed
    @cvb.digitPressed(@factory.title("7"))
    @cvb.digitPressed(@factory.title("5"))
    @cvb.display.text.should == ".7575"
  end
  it "computes sine" do
    @cvb.digitPressed(@factory.title("1"))
    @cvb.operationPressed(@factory.title("sin"))
    @cvb.display.text.should == "0.841471"
  end
  it "computes cosine" do
    @cvb.digitPressed(@factory.title("1"))
    @cvb.operationPressed(@factory.title("cos"))
    @cvb.display.text.should == "0.540302"
  end
  it "computes sqrt" do
    @cvb.digitPressed(@factory.title("25"))
    @cvb.operationPressed(@factory.title("sqrt"))
    @cvb.display.text.should == "5"
    @cvb.digitPressed(@factory.title("0"))
    @cvb.operationPressed(@factory.title("sqrt"))
    @cvb.display.text.should == "0"
  end
  it "returns 0 for sqrt(-1)" do
    @cvb.digitPressed(@factory.title("1"))
    @cvb.plusMinusPressed
    @cvb.operationPressed(@factory.title("sqrt"))
    @cvb.display.text.should == "0"
  end
  it "computes π" do
    @cvb.operationPressed(@factory.title("π"))
    @cvb.display.text.should == "3.141592"
    @cvb.operationPressed(@factory.title("π"))
    @cvb.enterPressed
    @cvb.digitPressed(@factory.title("3"))
    @cvb.operationPressed(@factory.title("*"))
    @cvb.operationPressed(@factory.title("+"))
    @cvb.display.text.should == "12.566364"
  end
  it "keeps a ticker" do
    @cvb.digitPressed(@factory.title("6"))
    @cvb.decimalPressed
    @cvb.digitPressed(@factory.title("3"))
    @cvb.enterPressed
    @cvb.digitPressed(@factory.title("5"))
    @cvb.operationPressed(@factory.title("+"))
    @cvb.digitPressed(@factory.title("2"))
    @cvb.operationPressed(@factory.title("*"))
    @cvb.ticker.text.should == " 6.3 5 + 2 *"
  end
  it "has a clear button" do
    @cvb.digitPressed(@factory.title("3"))
    @cvb.digitPressed(@factory.title("7"))
    @cvb.clearPressed
    @cvb.digitPressed(@factory.title("5"))
    @cvb.display.text.should == "5"
  end
  it "has a backspace button" do
    @cvb.digitPressed(@factory.title("3"))
    @cvb.digitPressed(@factory.title("7"))
    @cvb.backspacePressed
    @cvb.display.text.should == "3"

    @cvb.backspacePressed
    @cvb.display.text.should == "0"
    
    @cvb.decimalPressed
    @cvb.digitPressed(@factory.title("3"))
    @cvb.backspacePressed
    @cvb.display.text.should == "."
    @cvb.backspacePressed
    @cvb.display.text.should == "0"
  end
  it "has a plus/minus button" do
    @cvb.digitPressed(@factory.title("3"))
    @cvb.digitPressed(@factory.title("7"))
    @cvb.plusMinusPressed
    @cvb.display.text.should == "-37"
    @cvb.plusMinusPressed
    @cvb.display.text.should == "37"
  end
    
end
