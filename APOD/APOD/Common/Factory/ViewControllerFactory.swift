import UIKit

struct ViewControllerFactory {
    enum ViewControllerType {
        case astronomy
    }

    static func create(_ type: ViewControllerType) -> UIViewController? {
        var viewController: UIViewController?
        switch type {
        case .astronomy:
            viewController = AstronomyViewController.instantiate()
        }
        return viewController
    }
}
