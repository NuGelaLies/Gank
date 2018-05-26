import Kingfisher
import RxCocoa
import RxSwift
import UIView_Positioning

enum ImageResult {
    case success(UIImage)
    case failure(Error)
    
    var image: UIImage? {
        if case .success(let image) = self {
            return image
        } else {
            return nil
        }
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            return error
        } else {
            return nil
        }
    }
}

extension UIImageView {
    @discardableResult
    func setImage(
        with resource: Resource?,
        placeholder: UIImage? = nil,
        progress: ((Int64, Int64) -> Void)? = nil,
        completion: ((ImageResult) -> Void)? = nil
        ) -> RetrieveImageTask {
        // GIF will only animates in the AnimatedImageView
        let options: KingfisherOptionsInfo? = nil//(self is AnimatedImageView) ? nil : [.onlyLoadFirstFrame]
        let completionHandler: CompletionHandler = { image, error, cacheType, url in
            if let image = image {
                completion?(.success(image))
            } else if let error = error {
                completion?(.failure(error))
            }
        }
        return self.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: options,
            progressBlock: progress,
            completionHandler: completionHandler
        )
    }
}

public extension UIImageView {
    
    func setImage(url : URL?, placeholder: UIImage? = UIImage(named: "placeholder"), animated: Bool = true) {
        //        kf.indicatorType = .activity
        guard let imageURL = url else { return }
        
        if animated {
            kf.setImage(with: imageURL, placeholder: placeholder, options: [.backgroundDecode, .transition(.fade(1))])
        } else {
            kf.setImage(with: imageURL, placeholder: placeholder)
        }
    }
    
    func setRefresh(url: URL? ,placeholder: UIImage? = nil) {
        guard let urlString = url else {
            log.error("URL wrong ", url?.absoluteString ?? "")
            return
        }
        kf.setImage(with: urlString, placeholder: placeholder, options: [.forceRefresh])
    }
    
    func setImage(urlString URLString: String?, placeholder: UIImage? = nil, animated: Bool = true) {
        guard let urlString = URLString, let URL = URL(string: urlString) else {
            log.error("URL wrong ", URLString ?? "")
            return
        }
        setImage(url: URL, placeholder: placeholder, animated: animated)
    }
}
