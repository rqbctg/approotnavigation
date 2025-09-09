

# 🚀 AppRootNavigation

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20iPadOS-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)

A Swift Package for managing app root navigation flow in UIKit-based iOS applications.

---

## 📝 Overview

`AppRootNavigation` simplifies managing root navigation within UIKit-based applications. It allows for easy flow management, enabling the app to navigate between root views (such as onboarding screens and home screens) with minimal setup.


## 📦 Installation


### ⚙️ Requirements

- Xcode 12 or higher
- Swift 5.3 or higher
- iOS 13.0 or higher


### 📥 Using Swift Package Manager

### Xcode (Recommended)

1. Open your project in Xcode.  
2. Go to **File → Add Packages…**  
3. Enter the repo URL:

   ```
   https://github.com/rqbctg/convertible.git
   ```

4. Choose **Dependency Rule** → “Up to Next Major” from `1.0.0`.  
5. Select the target you want to add the package to.


---

### Swift Package Manager (`Package.swift`)

```swift
dependencies: [
    .package(url: "https://github.com/rqbctg/approotnavigation.git", from: "1.0.0")
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            .product(name: "AppRootNavigation", package: "AppRootNavigation")
        ]
    )
]
```

---


### 🛠️ Manual Installation

1. Download the latest release of the package.
2. Drag and drop the source files into your Xcode project.

---



## 🚦 Usage


### 📚 Importing the Package

Once added, import the package into your Swift files:

```swift
import AppRootNavigation
```


### 💡 Example Usage

To set up root navigation with conditional flow (e.g., Onboarding screen vs. Home screen) based on user interaction, you can follow this approach:

```swift
// AppRoot.swift

import Foundation
import UIKit
import AppRootNavigation

enum AppRoot: AppRootFlow {
    case home
    case onBoarding

    var key: String {
        switch self {
        case .home:
            return "home"
        case .onBoarding:
            return "onBoarding"
        }
    }

    var isVisited: Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

    var contentController: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .onBoarding:
            return OnBoardingViewController()
        }
    }

    var transition: CATransition? {
        return nil
    }
}

final class DefaultAppRootState: AppRootState {

    static let shared = DefaultAppRootState()

    var currentAppRoot: any AppRootFlow {
        self.getAppRoot()
    }

    func getAppRoot() -> any AppRootFlow {
        // Determine which root screen should be shown
        if AppRoot.onBoarding.isVisited {
            return AppRoot.home
        }
        return AppRoot.onBoarding
    }
}
```


### 🔗 SceneDelegate Integration

In your `SceneDelegate`, use the `DefaultAppRootState` to manage the navigation between root views. The following code demonstrates how to set up the root view controller and handle navigation based on the current root flow:

```swift
// SceneDelegate.swift

import UIKit
import AppRootNavigation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the window
        let window = UIWindow(windowScene: windowScene)

        // Get the current root view controller based on the app root state
        let rootViewController = DefaultAppRootState.shared.currentAppRoot.contentController

        // Set up the navigation controller for root navigation
        window.rootViewController = AppRootNavigationController(rootController: rootViewController)

        // Assign the window and make it visible
        self.window = window
        window.makeKeyAndVisible()
    }
}
```

In this example, `DefaultAppRootState.shared.currentAppRoot.contentController` determines the initial root view controller (either `OnBoardingViewController` or `HomeViewController`). The navigation controller (`AppRootNavigationController`) is used to wrap the root view controller and manage navigation.


## 📖 Documentation

You can find the full documentation and more usage examples on Medium :

Part 1:
https://medium.com/@rqb.ctg/a-simple-yet-powerful-rootnavigation-handler-58f7c8f72350

Part 2:
https://medium.com/@rqb.ctg/deep-dive-building-a-scalable-app-root-flow-system-in-ios-with-swift-ba236862e615



## 🤝 Contributing

1. Fork this repository.
2. Create a new branch for each feature or bug fix.
3. Commit your changes.
4. Push to your fork.
5. Create a Pull Request with a detailed description.


## 🪪 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## 📬 Contact

For issues or feature requests, please open an issue on [GitHub Issues](https://github.com/rqbctg/approotnavigation/issues).
