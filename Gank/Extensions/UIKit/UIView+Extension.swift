import UIKit

extension UIView {

    var layoutGuide: UILayoutGuide {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide
        } else {
            return layoutMarginsGuide
        }
    }

    var layoutInsets: UIEdgeInsets {
        if #available(iOS 11, *) {
            return safeAreaInsets
        } else {
            return layoutMargins
        }
    }

    /// 给View加上圆角
    @IBInspectable var setCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }

    /// 根据类查找视图
    ///
    /// - Parameter superViewClass: 类
    /// - Returns: View
    func findSuperView<T>(cls superViewClass : T.Type) -> T? {
        
        var xsuperView: UIView! = self.superview!
        var foundSuperView: UIView!
        
        while (xsuperView != nil && foundSuperView == nil) {
            
            if xsuperView.self is T {
                foundSuperView = xsuperView
            } else {
                xsuperView = xsuperView.superview
            }
        }
        return foundSuperView as? T
    }


    @discardableResult
    public func addSubviews(_ subviews: UIView...) -> UIView{
        subviews.forEach(addSubview)
        return self
    }
    
    @discardableResult
    public func addSubviews(_ subviews: [UIView]) -> UIView{
        subviews.forEach (addSubview)
        return self
    }
    
    func addTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
        return tapGesture
    }
    
    func addLongPressGesture() -> UILongPressGestureRecognizer {
        let longPressGesture = UILongPressGestureRecognizer()
        addGestureRecognizer(longPressGesture)
        isUserInteractionEnabled = true
        return longPressGesture
    }
    
    /// 删除所有View
    public func removeAllSubviews() {
        while subviews.count != 0 {
            subviews.last?.removeFromSuperview()
        }
    }
    
    public func responderViewController() -> UIViewController {
        var responder: UIResponder!
        var nextResponder = superview?.next
        repeat {
            responder = nextResponder
            nextResponder = nextResponder?.next
            
        } while !(responder.isKind(of: UIViewController.self))
        return responder as! UIViewController
    }

    public func shake() {
        self.transform = CGAffineTransform(translationX: 10, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.transform = .identity
        }, completion: nil)
    }
    
    /// Create a shake effect.
    ///
    /// - Parameters:
    ///   - count: Shakes count. Default is 2.
    ///   - duration: Shake duration. Default is 0.15.
    ///   - translation: Shake translation. Default is 5.
    func shake(count: Float = 2, duration: TimeInterval = 0.15, translation: Float = 5) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = count
        animation.duration = (duration) / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation
        
        self.layer.add(animation, forKey: "shake")
    }
    

    /// 使用视图的alpha创建一个淡出动画
    public func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }

    /// 使用视图的alpha创建一个淡入动画
    public func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
}

/// :nodoc:
public extension UICollectionView {
    
    /// Register given `UICollectionViewCell` in collectionView.
    /// Cell will be registered with the name of it's class as identifier.
    public func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    /// Register `UICollectionViewCell` from given nib in collectionView.
    /// Cell will be registered with the name of it's class as identifier.
    public func registerNib<T: UICollectionViewCell>(_:T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    /// Dequeue cell of given class from tableView.
    public func dequeue<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
}

/// :nodoc:
public extension UITableView {
    
    /// Register given `UITableViewCell` in tableView.
    /// Cell will be registered with the name of it's class as identifier.
    public func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    /// Register given `UITableViewCell` in tableView.
    /// Cell will be registered with the name of it's class as identifier.
    public func registerNib<T: UITableViewCell>(_:T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    /// Dequeue cell of given class from tableView.
    public func dequeue<T: UITableViewCell>(_: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T ?? T()
    }
    
    /// Dequeue HeaderFooterView of given class from tableView.
    public func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T ?? T()
    }
}

/// :nodoc:
public extension UINib {
    /// AwakeFromNib load View From Nib
    class func viewFromNib<T: UIView>(_: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.last as? T ?? T()
    }
}

public extension UIStoryboard {
    
    func loadStoryBoard(storyBoard: String) -> UIStoryboard {
        return UIStoryboard.init(name: storyBoard, bundle: nil)
    }
    
    /// load ViewController From StoryBoard
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as? T ?? T()
    }
}

/// :nodoc:
public extension UIEdgeInsets {
    
    /// Initialize UIEdgeInsets with given value for all the sides.
    /// UIEdgeInsets(15) == UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    public init(_ padding: CGFloat) {
        top = CGFloat(padding)
        bottom = CGFloat(padding)
        left = CGFloat(padding)
        right = CGFloat(padding)
    }
    
    /// Initialize UIEdgeInsets with given values for top & bottom, left & right sides.
    /// UIEdgeInsets(padding: 15, sidePadding: 16) == UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
    public init(padding: CGFloat, sidePadding: CGFloat = 0) {
        top = padding; bottom = padding
        left = sidePadding; right = sidePadding
    }
    
    /// Initialize UIEdgeInsets with inset on desired side.
    /// UIEdgeInsets(top: 20) == UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    /// UIEdgeInsets(top: 20, otherSides: 15) == UIEdgeInsets(top: 20, left: 15, bottom: 15, right: 15)
    public init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil, otherSides: CGFloat? = nil) {
        self.top = top ?? otherSides ?? 0
        self.left = left ?? otherSides ?? 0
        self.bottom = bottom ?? otherSides ?? 0
        self.right = right ?? otherSides ?? 0
    }
    
}



extension UIView {
    
    func screenshotForCroppingRect(croppingRect:CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.main.scale);
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: -croppingRect.origin.x, y: -croppingRect.origin.y)
        self.layoutIfNeeded()
        self.layer.render(in: context)
        
        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    var screenshot: UIImage? {
        return screenshotForCroppingRect(croppingRect: bounds)
    }
}
