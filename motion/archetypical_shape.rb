module Dagger
  class ArchetypicalShape < Node
    # Must be setup before being rendered. This is a separate step to provide control over when data is loaded.
    def self.setup
      @archetype ||= OpenGL::Drawable.new(self.vertices, self.indices, self.mode)
    end
    
    def self.render_archetype
      # TODO: The setup call should (probably) get moved out this render call and exist in a client-specific location.
      # Arguably it could stay since it uses a single initialization via ||=, but that seems like extra overhead that we'd like
      # to keep out of the render loop.
      # 
      # Anyway, it needs to happen after context is created though, and I need to decide where that's going to happen in this framework.
      # The current location in scene#viewDidLoad is crap.
      self.setup 
      
      @archetype.render
    end

    def render(scene, options={})
      super
      self.class.render_archetype
    end
  end
end