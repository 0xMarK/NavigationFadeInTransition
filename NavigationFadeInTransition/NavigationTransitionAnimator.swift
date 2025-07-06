//
//  NavigationTransitionAnimator.swift
//  NavigationFadeInTransition
//
//  Created by Anton Kaliuzhnyi on 06.07.2025.
//

import UIKit

class NavigationTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let operation: UINavigationController.Operation
    let duration: TimeInterval
    
    init?(operation: UINavigationController.Operation, from: UIViewController, to: UIViewController, duration: TimeInterval = 0.5) {
        guard Self.isAnimatorNeeded(operation: operation, from: from, to: to) else { return nil }
        self.operation = operation
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animateToViewControllerIfNeeded(transitionContext.viewController(forKey: .to), transitionContext: transitionContext)
        animateFromViewControllerIfNeeded(transitionContext.viewController(forKey: .from), transitionContext: transitionContext)
    }
    
    private func animateToViewControllerIfNeeded(_ to: UIViewController?, transitionContext context: UIViewControllerContextTransitioning) {
        guard let to,
              let pushStyle = (to as? NavigationControllerPushable)?.pushStyle else { return }
        switch (pushStyle, operation) {
        case (.fadeIn, .push):
            context.containerView.addSubview(to.view)
            to.view.alpha = 0.0
            UIView.animate(withDuration: duration, animations: {
                to.view.alpha = 1.0
            }, completion: { _ in
                context.completeTransition(!context.transitionWasCancelled)
            })
        default:
            break
        }
    }
    
    private func animateFromViewControllerIfNeeded(_ from: UIViewController?, transitionContext context: UIViewControllerContextTransitioning) {
        guard let from,
              let pushStyle = (from as? NavigationControllerPushable)?.pushStyle else { return }
        switch (pushStyle, operation) {
        case (.fadeIn, .pop):
            if let to = context.viewController(forKey: .to) {
                context.containerView.insertSubview(to.view, belowSubview: from.view)
            }
            from.view.alpha = 1.0
            UIView.animate(withDuration: duration, animations: {
                from.view.alpha = 0.0
            }, completion: { _ in
                from.view.removeFromSuperview()
                context.completeTransition(!context.transitionWasCancelled)
            })
        default:
            break
        }
    }
    
    private class func isAnimatorNeeded(operation: UINavigationController.Operation, from: UIViewController, to: UIViewController) -> Bool {
        if ((to as? NavigationControllerPushable)?.pushStyle == .fadeIn && operation == .push) || ((from as? NavigationControllerPushable)?.pushStyle == .fadeIn && operation == .pop) {
            return true
        } else {
            return false
        }
    }
}
