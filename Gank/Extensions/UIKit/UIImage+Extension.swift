import UIKit

extension UIImage {
    /// Resizes the image by a given rate for a given interpolation quality.
    ///
    /// - Parameters:
    ///   - rate: The resize rate. Positive to enlarge, negative to shrink. Defaults to medium.
    ///   - quality: The interpolation quality.
    /// - Returns: The resized image.
    public func resized(by rate: CGFloat, quality: CGInterpolationQuality = .medium) -> UIImage {
        let width = self.size.width * rate
        let height = self.size.height * rate
        let size = CGSize(width: width, height: height)

        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = quality
        self.draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return resized
    }
    
    
}

