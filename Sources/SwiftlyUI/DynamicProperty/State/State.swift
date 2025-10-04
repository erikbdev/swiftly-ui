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
    get {
      guard let _location else {
        logger.critical(
          """
          Accessing State's value outside of being installed on a View. \
          This will result in a constant Binding of the initial value and will not update.
          """
        )
        return _value
      }
      return _location.get()
    }
    nonmutating set {
      guard let _location else {
        return
      }

      _location.set(newValue, transaction: Transaction())
    }
  }

  public var projectedValue: Binding<Value> {
    guard let _location else {
      logger.critical(
        """
        Accessing State's value outside of being installed on a View. \
        This will result in a constant Binding of the initial value and will not update.
        """
      )
      return .constant(_value)
    }

    return Binding(value: _value, location: _location)
  }

  public init(wrappedValue value: Value) {
    self._value = value
    self._location = nil
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

extension State: PrimitiveDynamicProperty {
  mutating func _makeDynamicProperty(_ field: inout DynamicPropertyBuffer.Field, inputs: DynamicPropertyInputs) {
    if let context = field.context as? AnyLocation<Value> {
      self._location = context
      self._value = context.get()
    } else {
      let location = self._location ?? AnyLocation(StoredLocation(value: self._value))
      self._location = location
      field.context = location
    }
  }
}
