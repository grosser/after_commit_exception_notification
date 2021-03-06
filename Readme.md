Rails: Get notified when an after_commit block blows up

This gem is deprecated since rails 4.2 / 5 now have the correct behavior.

```
config.active_record.raise_in_transactional_callbacks = true
```

Install
=======

```Bash
gem install after_commit_exception_notification
```

Usage
=====

```Ruby
require 'after_commit_exception_notification' # by default prints to STDERR and ActiveRecord::Base.logger

AfterCommitExceptionNotification.callback do |exception|
  ErrorService.report("after_commit crashed", exception)
end
```

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/after_commit_exception_notification.png)](https://travis-ci.org/grosser/after_commit_exception_notification)
