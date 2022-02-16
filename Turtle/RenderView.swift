import AppKit

class RenderView : NSView {
    
    private let right: NSImage = NSImage(named: NSImage.Name("blue_right"))!
    private let left: NSImage = NSImage(named: NSImage.Name("blue_left"))!
    
    private let turtle = Turtle(withPosition: Vector(x: 200, y: 800),
                                andVelocity: Vector(x: 0, y: 0))
    private var goal = Vector(x: 0, y: 0)
    
    private var lastTime: CFTimeInterval = 0
    
    private let jumpHeightMax: CGFloat = 7.5
    private let jumpInterval: CGFloat = 7.5 * 2
    private var jumpStatus: CGFloat = 0
    
    override func draw(_ dirtyRect: NSRect) {
        // Timing
        if lastTime == 0 { lastTime = CACurrentMediaTime() }
        let now = CACurrentMediaTime()
        let deltaTime = now - lastTime  // Delta time IN SECONDS
        lastTime = now
        
        // Update entities (just turtle for now)
        update(deltaTime)
        
        // Get current graphics context and save its state
        let context: CGContext = NSGraphicsContext.current!.cgContext
        context.saveGState()
        
        // Translate to position
        context.translateBy(x: turtle.position.x, y: turtle.position.y)
        // Calculate jump interval
//        let jumpValue = turtle.position.x.truncatingRemainder(dividingBy: jumpInterval)
//        if (jumpValue < jumpInterval / 2) {
//            context.translateBy(x: 0, y: jumpValue)
//        } else {
//            context.translateBy(x: 0, y: jumpInterval - jumpValue)
//        }
        
        let jumpValue = jumpStatus.truncatingRemainder(dividingBy: jumpInterval) / jumpInterval
        let unitY = zeroOneParabola(jumpValue)
        context.translateBy(x: 0, y: unitY * jumpHeightMax)
        
        //
        var velocityAngle = turtle.velocity.angle()
        if (velocityAngle >= CGFloat.pi / 2 || velocityAngle <= -CGFloat.pi / 2) {
            velocityAngle += CGFloat.pi
        }
        context.rotate(by: velocityAngle)
        
        let image = turtle.velocity.x > 0 ? right : left
        image.draw(in: NSRect(x: -turtle.size / 2,
                              y: -turtle.size / 2,
                              width: turtle.size,
                              height: turtle.size))
    
        // Restore last context
        context.restoreGState()
                
        // Redraw next frame
        performSelector(onMainThread: #selector(queueRedraw), with: nil, waitUntilDone: false)
    }

    func update(_ deltaTime: CGFloat) {
        if (turtle.velocity.x == 0 && turtle.velocity.y == 0) {
            let halfSize = turtle.size / 2
            goal = Vector(x: CGFloat.random(in: halfSize ..< (frame.width - halfSize)),
                              y: CGFloat.random(in: halfSize ..< (frame.height - halfSize)))
            turtle.velocity = (goal - turtle.position).normalize()
        }
        
        turtle.position = turtle.position + (turtle.velocity * turtle.speed * deltaTime)
        jumpStatus += deltaTime * turtle.speed
        
        let distToGoal = (goal - turtle.position).abs().length
        if (distToGoal < 5) {
            turtle.velocity = .zero
        }
    }
    
    @objc func queueRedraw() {
        needsDisplay = true
    }
}
