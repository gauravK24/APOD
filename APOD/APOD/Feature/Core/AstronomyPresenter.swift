import Foundation

final class AstronomyPresenter {
    private let interactor: AstronomyInteractorInput
    private weak var router: AstronomyRouterInput?

    weak var view: AstronomyViewInput?

    init(interactor: AstronomyInteractorInput, router: AstronomyRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension AstronomyPresenter: AstronomyViewOutput {
    func viewDidLoad() {
        view?.showLoading()
        interactor.restrieveInfo()
    }
}

extension AstronomyPresenter: AstronomyInteractorOutput {
    func didRetrieve(info: AstronomyInfo?) {
        view?.hideLoading()
        // translate
        view?.show(info: info)
    }

    func onError() {
        // do nothing
    }
}

