module Dagger
  module OpenGL
    class VertexData
      attr_reader :vertex_size, :position_dimensions, :buffer
    
      def initialize(vertex_array)
        @num_vertices = vertex_array.count

        vertex = vertex_array[0]

        if vertex[:position]
          @position_dimensions = vertex[:position].count
        else
          raise 'must have position data'
        end

        @has_color   =   vertex[:color] ? true : false
        @has_texture = vertex[:texture] ? true : false

        @vertex_size = @position_dimensions
        @vertex_size += 4 if has_color?
        @vertex_size += 2 if has_texture?
      
        copy_data(vertex_array)
      end
    
      def copy_data(vertex_array)
        @verticesPtr = Pointer.new(:float, @vertex_size * @num_vertices)
        vertex_array.each_with_index do |vertex, i|
          vertexData = [vertex[:position], vertex[:color], vertex[:texture]].flatten.reject{|v|v.nil?}
          vertexData.each_with_index do |component, j|
            @verticesPtr[i * @vertex_size + j] = component
          end
        end
      end
    
      def load_buffer
        @buffer ||= begin
          vertexBufferPtr = Pointer.new(:uchar)
          glGenBuffers(1, vertexBufferPtr)
          vertexBuffer = vertexBufferPtr[0]
          glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer)
          glBufferData(GL_ARRAY_BUFFER, @num_vertices*@vertex_size*4, @verticesPtr, GL_STATIC_DRAW)
          vertexBuffer
        end
      end
    
      def has_color?
        @has_color
      end
    
      def has_texture?
        @has_texture
      end
    end
  end
end