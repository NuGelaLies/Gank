import UIKit
import SnapKit

public protocol NamespaceWrappable {
    associatedtype WrapperType
    var hand: WrapperType { get }
    static var hand: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var hand: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    
    static var hand: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public struct NamespaceWrapper<T> {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

extension UIView: NamespaceWrappable { }
extension NamespaceWrapper where T: UIView {
    
    public func adhere(_ toSuperView: UIView) -> T {
        toSuperView.addSubview(wrappedValue)
        return wrappedValue
    }
    
    @discardableResult
    public func layout(snapKitMaker: (ConstraintMaker) -> Void) -> T {
        wrappedValue.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return wrappedValue
    }
    
    @discardableResult
    public func config(_ config: (T) -> Void) -> T {
        config(wrappedValue)
        return wrappedValue
    }
}
