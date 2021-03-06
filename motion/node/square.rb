module Dagger
  module Node
    class Square < ArchetypicalShape
      def self.vertices
        [
          { position: [-0.5, -0.5], color: [1.0, 0.0, 0.0, 1.0] },
          { position: [ 0.5, -0.5], color: [1.0, 1.0, 0.0, 1.0] },
          { position: [ 0.5,  0.5], color: [1.0, 0.0, 1.0, 1.0] },
          { position: [-0.5,  0.5], color: [0.0, 1.0, 1.0, 1.0] },
        ]
      end
    
      def self.indices
        [0, 1, 2, 3]
      end
 
      def self.mode
        GL_TRIANGLE_FAN
      end
    end
  end
end