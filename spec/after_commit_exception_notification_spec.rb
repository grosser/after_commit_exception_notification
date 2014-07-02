require "spec_helper"

describe AfterCommitExceptionNotification do
  let(:calls) { [] }

  before do
    User.delete_all
    ActiveRecord::Base.logger = Logger.new(StringIO.new)
    AfterCommitExceptionNotification.callback { |e| calls << e }
  end

  it "has a VERSION" do
    AfterCommitExceptionNotification::VERSION.should =~ /^[\.\da-z]+$/
  end

  it "notifies on after_commit exception" do
    ActiveRecord::Base.logger.should_receive(:error).with { |e| e.to_s.should include "BOOOM"; true } # rails still receives the exception
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
end
