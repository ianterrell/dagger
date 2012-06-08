module Dagger
  def self.setup(app)
    app.files += Dir.glob('./vendor/dagger/motion/**/*.rb')
    
    app.files_dependencies 'vendor/dagger/motion/node/archetypical_shape.rb' => 'vendor/dagger/motion/node/base.rb'
    
    app.frameworks += ['OpenGLES', 'QuartzCore', 'GLKit']
    
    app.vendor_project(File.expand_path(File.dirname(__FILE__) + '/DaggerExt'), :xcode, :target => 'DaggerExt', :headers_dir => 'DaggerExt')
  end
end