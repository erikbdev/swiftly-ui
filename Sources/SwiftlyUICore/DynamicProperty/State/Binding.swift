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
  var _location: AnyLocation<Value>
  var _value: Value

  public var wrappedValue: Value {
    get { _location.get() }
    nonmutating set {
      _location.set(newValue, transaction: transaction)
    }
  }

  public var projectedValue: Self { self }

  public subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Value, Subject>) -> Binding<Subject> {
    let location = _location
    return Binding<Subject> {
      location.get()[keyPath: keyPath]
    } set: { newValue, transaction in
      var enclosingValue = location.get()
      enclosingValue[keyPath: keyPath] = newValue
      location.set(enclosingValue, transaction: transaction)
    }
  }

  /// Specifies a transaction for the binding.
  ///
  /// - Parameter transaction  : An instance of a ``Transaction``.
  ///
  /// - Returns: A new binding.
  public func transaction(_ transaction: Transaction) -> Self {
    var base = self
    base.transaction = transaction
    return base
  }

  /// Specifies an animation to perform when the binding value changes.
  ///
  /// - Parameter animation: An animation sequence performed when the binding
  ///   value changes.
  ///
  /// - Returns: A new binding.
  public func animation(_ animation: Animation? = .default) -> Self {
    var base = self
    base.transaction.animation = animation
    return base
  }

  public init(projectedValue: Self) {
    self = projectedValue
  }

  public init(
    get: @escaping () -> Value,
    set: @escaping (Value) -> Void
  ) {
    self.init(get: get) { value, _ in set(value) }
  }

  public init(
    get: @escaping () -> Value,
    set: @escaping (Value, Transaction) -> Void
  ) {
    self.init(value: get(), location: AnyLocation(FunctionLocation(getValue: get, setValue: set)))
  }

  init(value: Value, location: AnyLocation<Value>) {
    self._location = location
    self._value = value
  }

  public init<V>(_ base: Binding<V>) where Value == V? {
    let location = base._location

    self.init {
      location.get()
    } set: { newValue, transaction in
      guard let newValue else { return }
      location.set(newValue, transaction: transaction)
    }
  }

  public init?(_ base: Binding<Value?>) {
    guard let value = base.wrappedValue else {
      return nil
    }

    let location = base._location

    self.init {
      location.get() ?? value
    } set: {
      location.set($0, transaction: $1)
    }
  }

  #if !hasFeature(Embedded)
    public init<V>(_ base: Binding<V>) where Value == AnyHashable, V: Hashable {
      let location = base._location
      self.init {
        AnyHashable(location.get())
      } set: {
        location.set($0.base as! V, transaction: $1)
      }
    }
  #endif

  public static func constant(_ value: Value) -> Self {
    Binding(value: value, location: AnyLocation(ConstantLocation(value: value)))
  }
}

extension Binding: PrimitiveDynamicProperty {
  mutating func _makeDynamicProperty(_ field: inout DynamicPropertyBuffer.Field, inputs: DynamicPropertyInputs) {
    if let context = field.context as? AnyLocation<Value> {
      self._location = context
      self._value = context.get()
    } else {
      let location = self._location
      self._value = location.get()
      field.context = location
    }
  }
}

extension Binding: @unchecked Sendable where Value: Sendable {}

extension Binding: Identifiable where Value: Identifiable {
  public var id: Value.ID { wrappedValue.id }

  public typealias ID = Value.ID
}

extension Binding: Sequence where Value: MutableCollection {
  public typealias Element = Binding<Value.Element>
  public typealias Iterator = IndexingIterator<Binding<Value>>
  public typealias SubSequence = Slice<Binding<Value>>
}

extension Binding: Collection where Value: MutableCollection {
  public typealias Index = Value.Index
  public typealias Indices = Value.Indices

  public var startIndex: Index { wrappedValue.startIndex }

  public var endIndex: Index { wrappedValue.endIndex }

  public var indices: Indices { wrappedValue.indices }

  public func index(after i: Index) -> Index {
    wrappedValue.index(after: i)
  }

  public func formIndex(after i: inout Index) {
    wrappedValue.formIndex(after: &i)
  }

  public subscript(position: Index) -> Element {
    Binding<Value>.Element {
      wrappedValue[position]
    } set: {
      wrappedValue[position] = $0
    }
  }
}

extension Binding: BidirectionalCollection where Value: BidirectionalCollection, Value: MutableCollection {
  public func index(before index: Binding<Value>.Index) -> Binding<Value>.Index {
    wrappedValue.index(before: index)
  }

  public func formIndex(before index: inout Binding<Value>.Index) {
    wrappedValue.formIndex(before: &index)
  }
}

extension Binding: RandomAccessCollection where Value: MutableCollection, Value: RandomAccessCollection {}
