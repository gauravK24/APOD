import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: String, defaultImage: UIImage?) {
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.cachePolicy = .returnCacheDataElseLoad
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpURLResponse = response as? HTTPURLResponse,
                   httpURLResponse.statusCode == 200,
                   let data = data, error == nil,
                   let responseImg = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = responseImg
                    }
                } else {
                    print("Image cant be downloaded")
                }
            }.resume()
        } else {
            self.image = defaultImage
        }
    }
}
