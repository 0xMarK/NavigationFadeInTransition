//
//  SecondViewController.swift
//  NavigationFadeInTransition
//
//  Created by Anton Kaliuzhnyi on 06.07.2025.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SecondViewController: NavigationControllerPushable {

    var pushStyle: NavigationControllerPushStyle? {
        .fadeIn
    }

}
