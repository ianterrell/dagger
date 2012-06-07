module Dagger
  class ArchetypicalShape

    def self.vertices=(vertexArray)
      @vertexArray = vertexArray
    end
    
    def self.indices=(indexData)
      @indexData = indexData
    end
    
    def self.setup
      @setup ||= begin
        numVertices = @vertexArray.count

        vertex = @vertexArray[0]
        @vertexSize = 0

        if vertex[:position]
          @positionVertexSize = vertex[:position].count
          @vertexSize += @positionVertexSize
        else
          raise 'must have position data'
        end

        if vertex[:color]
          @hasColor = true
          @vertexSize += 4
        end

        if vertex[:texture]
          @hasTexture = true
          @vertexSize += 2
        end

        # Copy data onto heap
        verticesPtr = Pointer.new(:float, @vertexSize * numVertices)
        @vertexArray.each_with_index do |vertex, i|
          vertexData = [vertex[:position], vertex[:color], vertex[:texture]].flatten.reject{|v|v.nil?}
          vertexData.each_with_index do |component, j|
            verticesPtr[i * @vertexSize + j] = component
          end
        end

        # Send to OpenGL Buffer
        vertexBufferPtr = Pointer.new(:uchar)
        glGenBuffers(1, vertexBufferPtr)
        @vertexBuffer = vertexBufferPtr[0]

        glBindBuffer(GL_ARRAY_BUFFER, @vertexBuffer)
        glBufferData(GL_ARRAY_BUFFER, numVertices*@vertexSize*4, verticesPtr, GL_STATIC_DRAW)
        
        @numIndices = @indexData.count
        indicesPtr = Pointer.new(:uchar, @numIndices)
        @indexData.each_with_index do |index, i|
          indicesPtr[i] = index
        end

        indexBufferPtr = Pointer.new(:uchar)
        glGenBuffers(1, indexBufferPtr)
        @indexBuffer = indexBufferPtr[0]
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, @indexBuffer)
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, @numIndices*4, indicesPtr, GL_STATIC_DRAW)
        
        true
      end
    end
    
    def self.renderInScene(scene)
      self.setup
      
      glBindBuffer(GL_ARRAY_BUFFER, @vertexBuffer)
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, @indexBuffer)
      
      glEnableVertexAttribArray(GLKVertexAttribPosition)
      glVertexAttribPointer(GLKVertexAttribPosition, @positionVertexSize, GL_FLOAT, GL_FALSE, @vertexSize*4, Pointer.magic_cookie(0))

      offset = @positionVertexSize      
      if @hasColor
        glEnableVertexAttribArray(GLKVertexAttribColor)
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, @vertexSize*4, Pointer.magic_cookie(offset*4))
        offset += 4
      end
      
      if @hasTexture
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, @vertexSize*4, Pointer.magic_cookie(offset*4));
      end
      
      glDrawElements(GL_TRIANGLE_FAN, @numIndices, GL_UNSIGNED_BYTE, Pointer.magic_cookie(0))
      
      glDisableVertexAttribArray(GLKVertexAttribPosition)
      glDisableVertexAttribArray(GLKVertexAttribColor) if @hasColor
      glDisableVertexAttribArray(GLKVertexAttribTexCoord0) if @hasTexture
    end

    def renderInScene(scene, parent:parent)
      self.class.renderInScene(scene)
    end
  end
end