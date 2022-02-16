import Foundation

struct Vector {
    static let zero = Vector(x: 0, y: 0)
    
    let x: CGFloat
    let y: CGFloat
    
    var length: CGFloat {
        get { return sqrt(x * x + y * y) }
    }
    
    init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    func normalize() -> Vector {
        let len = length
        return Vector(x: self.x / len, y: self.y / len)
    }

    func angle() -> CGFloat {
        return atan2(y, x)
    }
    
    func abs() -> Vector {
        return Vector(x: Swift.abs(self.x), y: Swift.abs(self.y))
    }
    
}

func +(lhs: Vector, rhs: Vector) -> Vector {
    return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: Vector, rhs: Vector) -> Vector {
    return Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func *(lhs: Vector, rhs: CGFloat) -> Vector {
    return Vector(x: lhs.x * rhs, y: lhs.y * rhs)
}
