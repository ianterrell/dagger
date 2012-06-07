require "dagger/version"

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  app.development do
    app.frameworks << 'OpenGLES'
    app.frameworks << 'QuartzCore'
    app.frameworks << 'GLKit'
    
    app.vendor_project(File.expand_path(File.dirname(__FILE__) + '/../vendor/DaggerExt'), :xcode, :target => 'DaggerExt', :headers_dir => 'DaggerExt')
    
    app.files << File.expand_path(File.dirname(__FILE__) + '/dagger/archetypical_shape.rb')
    app.files << File.expand_path(File.dirname(__FILE__) + '/dagger/scene.rb')
    app.files << File.expand_path(File.dirname(__FILE__) + '/dagger/color.rb')
    app.files << File.expand_path(File.dirname(__FILE__) + '/dagger/square.rb')
    
    
  end
end
