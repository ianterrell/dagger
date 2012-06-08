module Dagger
  module OpenGL
    class Effect < GLKBaseEffect
      def self.prepare_default_effect(modelview_matrix, projection_matrix, constant_color=nil)
        @effect ||= self.alloc.init
        
        @effect.transform.modelviewMatrix = modelview_matrix
        @effect.transform.projectionMatrix = projection_matrix
        
        if constant_color
          @effect.useConstantColor = true
          @effect.constantColor = constant_color
        else
          @effect.useConstantColor = false
        end
        
        @effect.prepareToDraw
      end
    end
  end
end