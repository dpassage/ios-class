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
    @factory = MockSenderFactory.new
  end
  
  it "computes 3 + 3" do
    @cvb.digitPressed(@factory.title("3"))
    @cvb.enterPressed
    @cvb.digitPressed(@factory.title("3"))
    @cvb.operationPressed(@factory.title("+"))
    @cvb.display.text.should == "6"
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
end
