module Dagger
  module OpenGL
    class IndexData
      attr_reader :num_indices, :buffer
    
      def initialize(index_array)
        @num_indices = index_array.count
        copy_data(index_array)
      end
    
      def copy_data(index_array)
        @indices_ptr = Pointer.new(:uchar, @num_indices)
        index_array.each_with_index do |index, i|
          @indices_ptr[i] = index
        end
      end
    
      def load_buffer
        @buffer ||= begin
          indexBufferPtr = Pointer.new(:uchar)
          glGenBuffers(1, indexBufferPtr)
          indexBuffer = indexBufferPtr[0]
          glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer)
          glBufferData(GL_ELEMENT_ARRAY_BUFFER, @num_indices*4, @indices_ptr, GL_STATIC_DRAW)
          indexBuffer
        end
      end
    end
  end
end