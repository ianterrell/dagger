module Dagger
  module Node
    class Base
      attr_reader :position, :rotation, :scale
      attr_accessor :constant_color
      
      def initialize
        @position = [0.0, 0.0]
        @rotation = 0.0
        @scale = [1.0, 1.0]
        
        @modelview_matrix = GLKMatrix4Identity
        @dirty_matrix = true
      end
      
      def position=(position)
        @dirty_matrix = true
        @position = position
      end
      
      def rotation=(rotation)
        @dirty_matrix = true
        @rotation = rotation
      end
      
      def scale=(scale)
        @dirty_matrix = true
        @scale = scale
      end

      def update(dt)
      end
    
      def render(scene, options={})
        ::Dagger::OpenGL::Effect.prepare_default_effect(modelview_matrix(options), scene.projection_matrix, @constant_color)
      end
            
      def modelview_matrix(options={})
        if @dirty_matrix
          translation_matrix = GLKMatrix4MakeTranslation(@position[0], @position[1], 0.0)
          scale_matrix = GLKMatrix4MakeScale(@scale[0], @scale[1], 1.0)
          rotation_matrix = GLKMatrix4MakeZRotation(@rotation)
          
          @modelview_matrix = GLKMatrix4Multiply(translation_matrix, scale_matrix)
          @modelview_matrix = GLKMatrix4Multiply(@modelview_matrix, rotation_matrix)

          @dirty_matrix = false
        end
        
        @modelview_matrix
      end
    end
  end
end