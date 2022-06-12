import Foundation
import SecureNetworking
import UIKit

protocol AstronomyInfoProviding {
    func getInfo(_ completion: @escaping (Result<AstronomyInfo?, Error>) -> Void)
}

final class AstronomyService: AstronomyInfoProviding {
    private var network: NetworkService<AstronomyAPI>

    init(network: NetworkService<AstronomyAPI>) {
        self.network = network
    }

    func getInfo(_ completion: @escaping (Result<AstronomyInfo?, Error>) -> Void) {
        network.fetch(.info) { response in
            switch response {
            case .success(let json):
                if let json = json,
                   let title = json["title"] as? String,
                   let description = json["explanation"] as? String,
                   let image = json["url"] as? String {
                    let info = AstronomyInfo(title: title,
                                             description: description,
                                             image: image)
                    completion(.success(info))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

