require "active_record"

module AfterCommitExceptionNotification
  def self.callback(exception = nil, &block)
    if block
      @block = block
    else
      @block.call(exception)
    end
  end

  module CommittedWithNotification
    def committed!
      super
    rescue Exception => e # same as active_record/connection_adapters/abstract/database_statements.rb:370
      AfterCommitExceptionNotification.callback(e)
      raise
    end
  end
end

ActiveRecord::Base.send :include, AfterCommitExceptionNotification::CommittedWithNotification
