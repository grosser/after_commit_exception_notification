require "spec_helper"
require "logger"

describe AfterCommitExceptionNotification do
  let(:calls) { [] }

  def capture_stderr
    old, $stderr = $stderr, StringIO.new
    yield
    $stderr.string
  ensure
    $stderr = old
  end

  before do
    User.delete_all
    ActiveRecord::Base.logger = Logger.new(StringIO.new)
    AfterCommitExceptionNotification.callback { |e| calls << e }
  end

  it "has a VERSION" do
    AfterCommitExceptionNotification::VERSION.should =~ /^[\.\da-z]+$/
  end

  it "notifies on after_commit exception" do
    ActiveRecord::Base.logger.should_receive(:error).with(satisfy{ |e| e.to_s.should include "BOOOM"; true }) # rails still receives the exception
    user = User.create!(:boom => true)
    user.persisted?.should == true
    calls.size.should == 1
  end

  it "does not notify when after_commit goes well" do
    ActiveRecord::Base.logger.should_not_receive(:error)
    user = User.create!
    user.persisted?.should == true
    calls.size.should == 0
  end

  it "prints to stderr by default" do
    AfterCommitExceptionNotification.remove_instance_variable(:@block)
    recorded = capture_stderr do
      user = User.create!(:boom => true)
      user.persisted?.should == true
    end
    recorded.should include "After commit failed: BOOOM"
    recorded.should include "lib/after_commit_exception_notific"
  end
end
