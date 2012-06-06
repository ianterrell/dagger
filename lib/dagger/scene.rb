module Dagger
  class Scene < GLKViewController
    attr_accessor :clearColor
    
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
      
      @effect = GLKBaseEffect.alloc.init
      
      @clearColor ||= Color.new(1, 0, 0, 1)
    end
  
    def viewDidUnload
      super

      if EAGLContext.currentContext == @context
        EAGLContext.setCurrentContext(nil)
      end
      
      @context = nil
      @effect = nil
    end
  
    def glkView(view, drawInRect:rect)   
      glClearColor(@clearColor.r, @clearColor.g, @clearColor.b, @clearColor.a)
      glClear(GL_COLOR_BUFFER_BIT)
    
      @effect.prepareToDraw
    
      # glBindBuffer(GL_ARRAY_BUFFER, @vertexBuffer)
      #     glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, @indexBuffer)
      # 
      #     glEnableVertexAttribArray(GLKVertexAttribPosition)
      #     glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 9*4, Pointer.magic_cookie(0))
      #   
      #     glEnableVertexAttribArray(GLKVertexAttribColor)
      #     glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 9*4, Pointer.magic_cookie(3*4))
      #   
      #     glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
      #     glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 9*4, Pointer.magic_cookie(7*4));
      #   
      # glDrawElements(GL_TRIANGLES, @indices.size, GL_UNSIGNED_BYTE, Pointer.magic_cookie(0))
    end

    def update
      # aspect = (view.bounds.size.width / view.bounds.size.height).abs
      # projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), aspect, 4.0, 10.0)
      # @effect.transform.projectionMatrix = projectionMatrix
    end
  end
end