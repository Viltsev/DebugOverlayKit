# DebugOverlayKit

DebugOverlayKit is a lightweight library for displaying logs directly inside your iOS app.  
It provides a floating overlay window (`LogWindow`) where you can view logs in real-time, without relying on the Xcode console.  

Perfect for debugging and testing during development.  

---

## 📦 Installation

### Swift Package Manager (SPM)

1. In Xcode, go to File → Add Packages…  
2. Add the repository URL: https://github.com/Viltsev/DebugOverlayKit.git
3. Select the package and link it to your project.  
4. Import it in your code:  

```swift
import DebugOverlayKit
```

## ⚙️ Usage
1. Setup LogWindow in *SceneDelegate* 

Example:

```swift
import UIKit
import DebugOverlayKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var logWindow: LogWindow?
    // ...

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Create log overlay window
        logWindow = LogWindow(windowScene: windowScene)
        setupDoubleTapTrigger()
        
        // ...
    }
}

extension SceneDelegate {
    
    func setupDoubleTapTrigger() {
        guard let mainWindow = window else { return }
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleLogs))
        tap.numberOfTapsRequired = 2
        mainWindow.addGestureRecognizer(tap)
    }

    @objc private func toggleLogs() {
        if let logWindow = logWindow {
            logWindow.isHidden.toggle()
            if !logWindow.isHidden {
                logWindow.makeKeyAndVisible()
            } else {
                window?.makeKeyAndVisible()
            }
        }
    }
}
```

Now, double-tapping anywhere on the screen will toggle the log overlay.

2. Logging Messages

Use the Logger.shared instance to add messages:

Logger.shared.log("Hello from DebugOverlayKit", level: .info)
Logger.shared.log("Something looks suspicious", level: .warning)
Logger.shared.log("Oops, error happened!", level: .error)
### 🎨 Log Levels

- *info* — informational messages (white text)
- *warning* — warnings (yellow text)
- *error* — errors (red text)

![Demo of DebugOverlayKit](Docs/demo.gif)
