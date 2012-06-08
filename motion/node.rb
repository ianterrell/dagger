module Dagger
  class Node
    def initialize      
      @effect = GLKBaseEffect.alloc.init
      @effect.transform.modelviewMatrix = GLKMatrix4MakeTranslation(0.0, 0.0, 0.0)
      # @dirty_matrix = true
    end
    
    def update(dt)
    end
    
    def constant_color=(color)
      if color
        @effect.useConstantColor = true
        @effect.constantColor = color
      else
        @effect.useConstantColor = false
      end
    end
    
    def render(scene, options={})
      @effect.transform.projectionMatrix = scene.projection_matrix
      @effect.prepareToDraw
    end
  end
end