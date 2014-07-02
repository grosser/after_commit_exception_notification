require "spec_helper"

describe AfterCommitExceptionNotification do
  it "has a VERSION" do
    AfterCommitExceptionNotification::VERSION.should =~ /^[\.\da-z]+$/
  end
end
