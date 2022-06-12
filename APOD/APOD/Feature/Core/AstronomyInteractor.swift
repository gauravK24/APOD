import Foundation

protocol AstronomyInteractorInput {
    func restrieveInfo()
}

protocol AstronomyInteractorOutput: AnyObject {
    func didRetrieve(info: AstronomyInfo?)
    func onError()
}

final class AstronomyInteractor: BaseInteractor, AstronomyInteractorInput {
    weak var presenter: AstronomyInteractorOutput?

    override init() {
    }

    func restrieveInfo() {
    }
}
