//
//  RootChanging.swift
//  AppRootNavigation
//
//  Created by Abul Monsur Rakib on 9/9/25.
//
import UIKit

@MainActor
/// A protocol that defines the interface for changing the root view controller.
internal protocol RootChanging {
    /// A method to change the root view controller in a navigation controller.
    /// - Parameters:
    ///   - appRootFlow: The new root flow to transition to. It must conform to `AppRootFlow`.
    ///   - navigationController: The navigation controller in which the root will be changed.
    func changeRoot(to appRootFlow: any AppRootFlow, in navigationController: UINavigationController)
}

// MARK: - Concrete Root Changer
/// A concrete implementation of the `RootChanging` protocol responsible for changing the root view controller.
final internal class AppRootChanger: RootChanging {
    
    /// A default transition used when changing the root view controller.
    var defaultTransition: CATransition {
        let direction: CATransitionSubtype = .fromRight // Direction for the transition
        let duration = 0.3 // Duration of the transition

        // Create a CATransition for the "push" animation with the specified parameters
        let transition = CATransition()
        transition.type = CATransitionType.push // Type of transition (push)
        transition.subtype = direction // Direction of the transition (from right)
        transition.duration = duration // Duration of the transition
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // Smooth easing effect
        return transition
    }
    
    /// This method changes the root view controller of the given navigation controller.
    /// - Parameters:
    ///   - appRootFlow: The new root flow to transition to, which must conform to `AppRootFlow`.
    ///   - navigationController: The navigation controller where the root will be changed.
    func changeRoot(to appRootFlow: any AppRootFlow, in navigationController: UINavigationController) {
        // Apply the transition to the view's layer. If `appRootFlow.transition` is not provided, the default transition is used.
        navigationController.view.layer.add(appRootFlow.transition ?? defaultTransition, forKey: kCATransition)
        
        // Set the new root view controller, and prevent animation (since the transition handles the animation).
        navigationController.setViewControllers([appRootFlow.contentController], animated: false)
    }
}
