//
//  NavigationController.swift
//  NavigationFadeInTransition
//
//  Created by Anton Kaliuzhnyi on 06.07.2025.
//

import UIKit

protocol NavigationControllerPushable {
    var pushStyle: NavigationControllerPushStyle? { get }
}

enum NavigationControllerPushStyle {
    case fadeIn
}

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

}

extension NavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        NavigationTransitionAnimator(operation: operation, from: fromVC, to: toVC)
    }

}
