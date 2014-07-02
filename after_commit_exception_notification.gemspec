name = "after_commit_exception_notification"
require "./lib/#{name.gsub("-","/")}/version"

Gem::Specification.new name, AfterCommitExceptionNotification::VERSION do |s|
  s.summary = "Rails: Get notified when an after_commit block blows up"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files lib/ bin/ MIT-LICENSE`.split("\n")
  s.license = "MIT"

  s.add_runtime_dependency "activerecord"

  s.add_development_dependency "rspec", "~> 3"
  s.add_development_dependency "wwtd"
  s.add_development_dependency "rake"
  s.add_development_dependency "bump"
  s.add_development_dependency "mysql2" # sqlite3 does not work
end
