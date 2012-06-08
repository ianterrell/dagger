module Dagger
  def self.setup(app)
    app.files += Dir.glob(File.dirname(__FILE__) + '/dagger/**/*.rb')
    app.frameworks += ['OpenGLES', 'QuartzCore', 'GLKit']
    app.vendor_project(File.expand_path(File.dirname(__FILE__) + '/../DaggerExt'), :xcode, :target => 'DaggerExt', :headers_dir => 'DaggerExt')
  end
end