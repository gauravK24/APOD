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
    private var service: AstronomyInfoProviding

    init(service: AstronomyInfoProviding) {
        self.service = service
    }

    func restrieveInfo() {
        service.getInfo { [weak self] result in
            switch result {
            case .success(let info):
                self?.presenter?.didRetrieve(info: info)
            case .failure(_):
                self?.presenter?.onError()
            }
        }
    }
}
