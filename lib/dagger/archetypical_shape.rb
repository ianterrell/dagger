module Dagger
  class ArchetypicalShape
    def self.setup
      @setup ||= begin
        @vertex_data = OpenGL::VertexData.new(self.vertices)
        @vertex_data.load_buffer
                
        @index_data = OpenGL::IndexData.new(self.indices)
        @index_data.load_buffer
        
        true
      end
    end
    
    def self.renderInScene(scene)
      self.setup
      
      glBindBuffer(GL_ARRAY_BUFFER, @vertex_data.buffer)
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, @index_data.buffer)
      
      glEnableVertexAttribArray(GLKVertexAttribPosition)
      glVertexAttribPointer(GLKVertexAttribPosition, @vertex_data.position_dimensions, GL_FLOAT, GL_FALSE, @vertex_data.vertex_size*4, Pointer.magic_cookie(0))

      offset = @vertex_data.position_dimensions      
      if @vertex_data.has_color?
        glEnableVertexAttribArray(GLKVertexAttribColor)
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, @vertex_data.vertex_size*4, Pointer.magic_cookie(offset*4))
        offset += 4
      end
      
      if @vertex_data.has_texture?
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, @vertex_data.vertex_size*4, Pointer.magic_cookie(offset*4));
      end
      
      glDrawElements(self.mode, @index_data.num_indices, GL_UNSIGNED_BYTE, Pointer.magic_cookie(0))
      
      glDisableVertexAttribArray(GLKVertexAttribPosition)
      glDisableVertexAttribArray(GLKVertexAttribColor) if @vertex_data.has_color?
      glDisableVertexAttribArray(GLKVertexAttribTexCoord0) if @vertex_data.has_texture?
    end

    def renderInScene(scene, options={})
      self.class.renderInScene(scene)
    end
  end
end