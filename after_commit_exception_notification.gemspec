name = "after_commit_exception_notification"
require "./lib/#{name.gsub("-","/")}/version"

Gem::Specification.new name, AfterCommitExceptionNotification::VERSION do |s|
  s.summary = "Rails: Get notified when an after_commit block blows up"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files lib/ bin/ MIT-LICENSE`.split("\n")
  s.license = "MIT"
end
