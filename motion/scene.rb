module Dagger
  class Scene < GLKViewController
    attr_accessor :clear_color, :projection_matrix
    
    def init
      super
      
      @objects = []
      @clear_color = Color.new(1, 0, 0, 1)
      @projection_matrix = GLKMatrix4MakeOrtho(-2, 2, -3, 3, 1.0, -1.0);
      
      self
    end
    
    def viewDidLoad
      super

      @context = EAGLContext.alloc.initWithAPI(KEAGLRenderingAPIOpenGLES2)
      if @context
        EAGLContext.setCurrentContext(@context)
        self.view.context = @context
      else
        # TODO: Handle error better
        puts "Failed to create OpenGL ES context"
      end
    end
  
    def viewDidUnload
      super

      if EAGLContext.currentContext == @context
        EAGLContext.setCurrentContext(nil)
      end
      
      @context = nil
    end
    
    def <<(object)
      @objects << object
    end
  
    def glkView(view, drawInRect:rect)   
      glClearColor(@clear_color.r, @clear_color.g, @clear_color.b, @clear_color.a)
      glClear(GL_COLOR_BUFFER_BIT)
            
      @effect ||= GLKBaseEffect.alloc.init
      @effect.prepareToDraw
      
      @objects.each { |object| object.render(self) }
    end

    def update
    end
  end
end