require "dagger/version"

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  app.development do
    app.files << File.expand_path(File.dirname(__FILE__) + '/dagger/scene.rb')
  end
end
