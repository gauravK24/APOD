import Foundation

protocol AstronomyRouterInput: AnyObject {
    func showNextView()
}

protocol AstronomyRouterOutput {
    // do nothing
}

final class AstronomyRouter: AstronomyRouterInput {
    func showNextView() {
    }
}

extension AstronomyRouter: AstronomyRouterOutput {
}
