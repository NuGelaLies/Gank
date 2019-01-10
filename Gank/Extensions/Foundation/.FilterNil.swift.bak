import Foundation


// Github: https://github.com/devxoul/Immutable


extension RangeReplaceableCollection {
    /// Returns a new collection by appending a new element.
    public func appending(_ newElement: Self.Iterator.Element) -> Self {
        var copy = self
        copy.append(newElement)
        return copy
    }
    
    /// Returns a new collection by appending new elements.
    public func appending<S>(contentsOf newElements: S) -> Self where S: Sequence, S.Iterator.Element == Self.Iterator.Element {
        var copy = self
        copy.append(contentsOf: newElements)
        return copy
    }
    
    /// Returns a new collection by inserting a new element.
    public func inserting(_ newElement: Self.Iterator.Element, at i: Self.Index) -> Self {
        var copy = self
        copy.insert(newElement, at: i)
        return copy
    }
    
    /// Returns a new collection by inserting new elements.
    public func inserting<C>(contentsOf newElements: C, at i: Self.Index) -> Self where C: Collection, C.Iterator.Element == Self.Iterator.Element {
        var copy = self
        copy.insert(contentsOf: newElements, at: i)
        return copy
    }
    
    /// Returns a new collection by removing an element at specified index.
    public func removing(at i: Self.Index) -> Self {
        var copy = self
        copy.remove(at: i)
        return copy
    }
    
    /// Returns a new collection by removing all elements.
    public func removingAll(keepingCapacity: Bool = false) -> Self {
        var copy = self
        copy.removeAll(keepingCapacity: keepingCapacity)
        return copy
    }
    
    /// Returns a new collection by removing first element.
    public func removingFirst(_ n: Int = 1) -> Self {
        var copy = self
        copy.removeFirst(n)
        return copy
    }
    
    /// Returns a new collection by replacing given subrange with new elements.
    public func replacingSubrange<C>(_ subrange: Range<Self.Index>, with newElements: C) -> Self where C : Collection, C.Iterator.Element == Self.Iterator.Element {
        var copy = self
        copy.replaceSubrange(subrange, with: newElements)
        return copy
    }
}

extension Dictionary {
    /// Initialize dictionary with a collection of key-value tuples.
    public init<C>(elements: C) where C: Collection, C.Iterator.Element == (Key, Value) {
        self.init()
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    /// `map()` that returns `Dictionary`.
    public func map<T, U>(_ transform: (Key, Value) throws -> (T, U)) rethrows -> [T: U] where T: Hashable {
        return Dictionary<T, U>(elements: try self.map(transform))
    }
    
    /// `flatMap()` that returns `Dictionary`.
    public func flatMap<T, U>(_ transform: (Key, Value) throws -> (T, U)?) rethrows -> [T: U] where T: Hashable {
        return Dictionary<T, U>(elements: try self.compactMap(transform))
    }
    
    /// Returns a new dictionary by updating a value for key.
    public func updatingValue(_ value: Value, forKey key: Key) -> Dictionary {
        var copy = self
        copy.updateValue(value, forKey: key)
        return copy
    }
    
    /// Returns a new dictionary by removing a value for key.
    public func removingValue(forKey key: Key) -> Dictionary {
        var copy = self
        copy.removeValue(forKey: key)
        return copy
    }
    
    /// returns a new directory by merging all values for respective keys.
    public func merging(_ dictionary: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var copy = self
        dictionary.forEach { copy.updateValue($1, forKey: $0) }
        return copy
    }
}

/// A protocol for making generic type constraints of Optionals.
public protocol _OptionalType {
    associatedtype _Wrapped
    
    func flatMap<U>(_ transform: (_Wrapped) throws -> U?) rethrows -> U?
}

extension Optional: _OptionalType {
    public typealias _Wrapped = Wrapped
}

extension Collection where Iterator.Element: _OptionalType {
    /// Returns nil-excluded array.
    public func filterNil() -> [Iterator.Element._Wrapped] {
        return self.compactMap { $0.flatMap { $0 } }
    }
}

extension Dictionary where Value: _OptionalType {
    public func filterNil() -> [Key: Value._Wrapped] {
        return self.flatMap { key, value in
            return value.flatMap { (key, $0) }
        }
    }
}

public func filterNil<T>(_ array: [T?]) -> [T] {
    return array.filterNil()
}

public func filterNil<K, V>(_ dictionary: [K: V?]) -> [K: V] {
    return dictionary.filterNil()
}
