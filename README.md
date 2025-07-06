# NavigationFadeInTransition

Fade In Navigation Transition of UIViewController.

## Usage

1. Confirm you `UIViewController` to `NavigationControllerPushable`:

```swift
extension SecondViewController: NavigationControllerPushable {

    var pushStyle: NavigationControllerPushStyle? {
        .fadeIn
    }

}
```

2. Have some `NavigationController` which returns `NavigationTransitionAnimator` as Animation Controller:

```swift
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
```

![NavigationFadeInTransition](https://github.com/user-attachments/assets/febbc9d8-2838-4d87-ab38-e056b0f00b99)
