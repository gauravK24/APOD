import UIKit

protocol AstronomyViewInput: AnyObject {
    func show(info: AstronomyInfo?)
    func showLoading()
    func hideLoading()
    func showError()
}

protocol AstronomyViewOutput {
    func viewDidLoad()
}

class AstronomyViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descTextView: UITextView!

    lazy var loadingVC = LoadingViewController()
    var presenter: AstronomyViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension AstronomyViewController: AstronomyViewInput {
    func show(info: AstronomyInfo?) {
        if let info = info {
            DispatchQueue.main.async {
                self.titleLbl.text = info.title
                self.imageView.downloadImage(from: info.image, defaultImage: nil)
                self.descTextView.text = info.description
            }
        }
    }

    func showLoading() {
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve

        DispatchQueue.main.async {
            self.present(self.loadingVC,
                         animated: true,
                         completion: nil)
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingVC.dismiss(animated: true,
                                   completion: nil)
        }
    }

    func showError() {
        // show error
    }
}


