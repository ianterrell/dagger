# Dagger

A simple OpenGL game engine for RubyMotion.

## Installation

You'll need a copy of `dagger` installed inside vendor. The 90% case will be to do this as a git submodule.

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

If you subclass `dagger` objects you may need to set up explicit file dependencies:

```ruby
Motion::Project::App.setup do |app|
  # existing app setup
  
  app.files_dependencies 'app/custom_shape.rb' => 'vendor/dagger/motion/archetypical_shape.rb'
end
```
