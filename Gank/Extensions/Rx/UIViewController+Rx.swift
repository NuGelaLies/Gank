import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    
    public var viewDidLoad: ControlEvent<Void> {
        let source = self.sentMessage(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    
    public var viewWillAppear: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    public var viewDidAppear: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    public var viewWillDisappear: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    public var viewDidDisappear: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    public var viewWillLayoutSubviews: ControlEvent<Void> {
        let source = self.sentMessage(#selector(Base.viewWillLayoutSubviews)).map { _ in }
        return ControlEvent(events: source)
    }
    public var viewDidLayoutSubviews: ControlEvent<Void> {
        let source = self.sentMessage(#selector(Base.viewDidLayoutSubviews)).map { _ in }
        return ControlEvent(events: source)
    }
    
    public var willMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.sentMessage(#selector(Base.willMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    public var didMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.sentMessage(#selector(Base.didMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    
    public var didReceiveMemoryWarning: ControlEvent<Void> {
        let source = self.sentMessage(#selector(Base.didReceiveMemoryWarning)).map { _ in }
        return ControlEvent(events: source)
    }
}

public extension Reactive where Base: UIViewController {
    
    func push(_ viewController: @escaping @autoclosure () -> UIViewController,
              animated: Bool = true)
        -> Binder<Void>
    {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewController(viewController(), animated: animated)
        }
    }
    
    func pop(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popToRoot(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func present(_ viewController: @escaping @autoclosure () -> UIViewController,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil)
        -> Binder<Void>
    {
        return Binder(base) { this, _ in
            this.present(viewController(), animated: animated, completion: completion)
        }
    }
    
    func dismiss(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.dismiss(animated: animated, completion: nil)
        }
    }
}


