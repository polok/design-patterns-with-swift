import Foundation

// Solution 3

public protocol Builder {}

public extension Builder where Self: AnyObject {
    
    @discardableResult
    func set<T>(_ property: ReferenceWritableKeyPath<Self, T>, with value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}
