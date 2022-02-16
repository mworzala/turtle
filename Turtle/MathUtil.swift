

import CoreGraphics

func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat.pi / 180
}

func radiansToDegress(radians: CGFloat) -> CGFloat {
    return radians * 180 / CGFloat.pi
}

extension CGFloat {
    var rad: CGFloat {
        get {
            return degreesToRadians(degrees: self)
        }
    }
    var deg: CGFloat {
        get {
            return radiansToDegress(radians: self)
        }
    }
}

// -4(0.5-x)^2+1
func zeroOneParabola(_ x: CGFloat) -> CGFloat {
    return (-4 * pow(0.5 - x, 2)) + 1
}
