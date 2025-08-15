//
//  Binding.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@propertyWrapper
@dynamicMemberLookup
public struct Binding<Value> {
    public var transaction = Transaction()
    
    public var wrappedValue: Value {
        get { fatalError() }
        nonmutating set { }
    }
    
    public var projectedValue: Self {  fatalError() }
    
    public init(projectedValue: Self) {
        fatalError()
    }
    
    @preconcurrency
    public init(
        get: @escaping @isolated(any) @Sendable () -> Value,
        set: @escaping @isolated(any) @Sendable (Value) -> Void
    ) {
        fatalError()
    }
    
    @preconcurrency
    public init(
        get: @escaping @isolated(any) @Sendable () -> Value,
        set: @escaping @isolated(any) @Sendable (Value, Transaction) -> Void
    ) {
        fatalError()
    }

    /// Creates a binding by projecting the base value to an optional value.
    ///
    /// - Parameter base: A value to project to an optional value.
    public init<V>(_ base: Binding<V>) where Value == V? {
        fatalError()
    }

    /// Creates a binding by projecting the base value to an unwrapped value.
    ///
    /// - Parameter base: A value to project to an unwrapped value.
    ///
    /// - Returns: A new binding or `nil` when `base` is `nil`.
    public init?(_ base: Binding<Value?>) {
        fatalError()
    }

    /// Creates a binding by projecting the base value to a hashable value.
    ///
    /// - Parameters:
    ///   - base: A `Hashable` value to project to an `AnyHashable` value.
    public init<V>(_ base: Binding<V>) where Value == AnyHashable, V : Hashable {
        fatalError()
    }
        
    public subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Value, Subject>) -> Binding<Subject> {
        get { fatalError() }
        nonmutating set { fatalError() }
    }
    
    /// Specifies a transaction for the binding.
    ///
    /// - Parameter transaction  : An instance of a ``Transaction``.
    ///
    /// - Returns: A new binding.
    public func transaction(_ transaction: Transaction) -> Self {
        var copy = self
        copy.transaction = transaction
        return copy
    }

    /// Specifies an animation to perform when the binding value changes.
    ///
    /// - Parameter animation: An animation sequence performed when the binding
    ///   value changes.
    ///
    /// - Returns: A new binding.
    public func animation(_ animation: Animation? = .default) -> Self {
        var copy = self
        copy.transaction.animation = animation
        return copy
    }
}

extension Binding {
    public static func constant(_ value: Value) -> Self {
        fatalError()
    }
}

extension Binding: @unchecked Sendable where Value: Sendable {}
