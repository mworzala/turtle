import Foundation

class Turtle {
    var position: Vector
    var velocity: Vector
    
    let size: CGFloat = 64
    
    let speed: CGFloat = 75 // In pixels per second
    
    init() {
        self.position = Vector(x: 0, y: 0)
        self.velocity = Vector(x: 0, y: 0)
    }
    
    init(withPosition pos: Vector, andVelocity vel: Vector) {
        self.position = pos
        self.velocity = vel
    }
    
    
    
}
