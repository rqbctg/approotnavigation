//
//  AppRootFlow.swift
//  AppRootNavigation
//
//  Created by Abul Monsur Rakib on 9/9/25.
//

import UIKit

/// Protocol defining the requirements for an app root flow.
public protocol AppRootFlow {
    /// Unique key for the flow, used for persistence.
    var key: String { get }
    /// Indicates whether the flow has been visited.
    var isVisited: Bool { get }
    /// The view controller associated with the flow.
    var contentController: UIViewController { get }
    
    ///The animation of view controller transition
    var transition: CATransition? { get }
}


public protocol AppRootState  {
    /// The current app root flow, asynchronously determined.
    var currentAppRoot : AppRootFlow { get }
}
