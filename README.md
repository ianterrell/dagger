# Dagger

A simple OpenGL game engine for RubyMotion.

## Installation

You'll need a copy of `dagger` installed somewhere. The 90% case for this will be to install it as a git submodule inside vendor.

```
git submodule add git@github.com:ianterrell/dagger.git vendor/dagger
```

Then add its configuration to your RubyMotion `Rakefile`:

```ruby
require File.dirname(__FILE__) + '/vendor/dagger/setup.rb'

Motion::Project::App.setup do |app|
  # existing app setup
  
  Dagger.setup app
end
```