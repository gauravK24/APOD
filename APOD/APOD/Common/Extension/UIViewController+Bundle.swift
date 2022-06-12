import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: Bundle.main)
        }
        return instanceFromNib()
    }
}
