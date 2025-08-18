//
//  State.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@propertyWrapper
public struct State<Value>: DynamicProperty {
  var _value: Value

  var _location: AnyLocation<Value>?

  public var wrappedValue: Value {
    get { fatalError() }
    nonmutating set { fatalError() }
  }

  public var projectedValue: Binding<Value> {
    fatalError()
    print(
      "Accessing State's value outside of being installed on a View. This will result in a constant Binding of the initial value and will not update."
    )
  }

  public init(wrappedValue value: Value) {
    self._value = value
  }

  public init(initialValue value: Value) {
    self._value = value
  }
}

extension State where Value: ExpressibleByNilLiteral {
  public init() {
    self.init(wrappedValue: nil)
  }
}

extension State: Sendable where Value: Sendable {}
