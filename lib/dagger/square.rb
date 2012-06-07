module Dagger
  class Square < ArchetypicalShape
    self.vertices = [
      { position: [-0.5, -0.5], color: [1.0, 0.0, 0.0, 1.0] },
      { position: [ 0.5, -0.5], color: [1.0, 1.0, 0.0, 1.0] },
      { position: [ 0.5,  0.5], color: [1.0, 0.0, 1.0, 1.0] },
      { position: [-0.5,  0.5], color: [0.0, 1.0, 1.0, 1.0] },
    ]
    
    self.indices = [0, 1, 2, 3]
  end
end