module Dagger
  class Scene < GLKViewController
    attr_accessor :clearColor
    
    def init
      super
      
      @objects = []
      @clearColor = Color.new(1, 0, 0, 1)
      
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
      glClearColor(@clearColor.r, @clearColor.g, @clearColor.b, @clearColor.a)
      glClear(GL_COLOR_BUFFER_BIT)
            
      @effect ||= GLKBaseEffect.alloc.init
      @effect.prepareToDraw
      
      @objects.each { |object| object.renderInScene(self, parent: nil) }
    end

    def update
      @effect ||= GLKBaseEffect.alloc.init
      
      # aspect = (view.bounds.size.width / view.bounds.size.height).abs
      projectionMatrix = GLKMatrix4MakeOrtho(-2, 2, -3, 3, 1.0, -1.0);
      @effect.transform.projectionMatrix = projectionMatrix
      
      modelViewMatrix = GLKMatrix4MakeTranslation(0.0, 0.0, 0.0)   
      @effect.transform.modelviewMatrix = modelViewMatrix
    end
  end
end