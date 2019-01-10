import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    var tapGesture: Observable<UITapGestureRecognizer> {
        let tapGesture = base.addTapGesture()
        return tapGesture.rx.event.asObservable()
    }
    
    var longPressGesture: Observable<UILongPressGestureRecognizer> {
        let longPressGesture = base.addLongPressGesture()
        return longPressGesture.rx.event.asObservable()
    }
}
