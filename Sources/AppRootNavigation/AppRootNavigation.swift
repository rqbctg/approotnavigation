// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import Combine

/// A custom UINavigationController responsible for managing the root view controller
/// and handling app flow transitions.
final public class AppRootNavigationController: UINavigationController {

    // A set of cancellables to store the subscriptions for Combine framework
    private var cancellables = Set<AnyCancellable>()
    
    // A static PassthroughSubject to publish app root flow changes
    static let changeAppRoot = PassthroughSubject<AppRootFlow, Never>()

    // The root changer responsible for changing the root view controller
    private let rootChanger: RootChanging

    /// Initializer to set the root changer and initial view controller.
    /// - Parameters:
    ///   - rootChanger: An object conforming to `RootChanging` to change root.
    ///   - rootViewController: The initial view controller for the navigation controller.
    public init(
        rootController: UIViewController
    ) {
        self.rootChanger = AppRootChanger()
        // Calls the parent class initializer with the provided root view controller.
        super.init(rootViewController: rootController)
    }

    /// Required initializer for when the controller is loaded from a storyboard.
    /// - Parameter aDecoder: A decoder used to load the view controller.
    required init?(coder aDecoder: NSCoder) {
        // Initializes the rootChanger with a default instance
        self.rootChanger = AppRootChanger()
        super.init(coder: aDecoder)
    }

    /// This method is called after the view controller has been loaded.
    /// It sets up the Combine subscription to listen for app root changes.
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Subscribe to the static `changeAppRoot` subject to listen for root changes.
        // The subscription ensures that any emitted root flow changes will trigger the root changing process.
        Self.changeAppRoot
            .receive(on: DispatchQueue.main) // Ensures UI updates are done on the main thread.
            .sink { [weak self] appRootFlow in
                guard let self = self else { return }
                // Calls the rootChanger to change the root view controller
                self.rootChanger.changeRoot(to: appRootFlow, in: self)
            }
            .store(in: &cancellables) // Store the cancellable to manage lifecycle.
    }

    /// This method is called before the view is about to appear.
    /// It hides the navigation bar when the view is displayed.
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden(true, animated: animated) // Hides navigation bar.
    }
}
