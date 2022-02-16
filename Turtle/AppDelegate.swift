import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindow: NSWindow?
    
    override init() {
        mainWindow = nil
        super.init()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        // Create window
        let mainWindow = NSWindow(contentRect: CGRect(x: 50, y: 50, width: 500, height: 500),
                              styleMask: NSWindow.StyleMask.borderless,
                              backing: NSWindow.BackingStoreType.buffered,
                              defer: false)
        self.mainWindow = mainWindow
        
        // Fill entire screen
        let mainScreen = NSScreen.main!
        mainWindow.setFrame(mainScreen.frame, display: true, animate: false)
        mainWindow.level = .screenSaver
        
        // Configure background/click through
        mainWindow.ignoresMouseEvents = true
        mainWindow.isOpaque = false
        mainWindow.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        // Create main view
        let mainView = RenderView()
        mainView.wantsLayer = true
        mainView.layerContentsRedrawPolicy = .onSetNeedsDisplay
        mainWindow.contentView = mainView

        mainWindow.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return false
    }


}
