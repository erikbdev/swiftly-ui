//
//  Environment.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@propertyWrapper
public struct Environment<Value>: DynamicProperty {
  fileprivate enum Storage {
    case keyPath(KeyPath<EnvironmentValues, Value>)
    case value(Value)
  }

  private var storage: Storage

  public var wrappedValue: Value {
    switch storage {
    case .value(let value):
      return value
    case .keyPath(let keyPath):
      // TODO: not set yet, accessed outside of environment?
      logger.warning(
        """
        Accessing value outside of View's body.
        """
      )
      return EnvironmentValues()[keyPath: keyPath]
    }
  }

  public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
    self.storage = .keyPath(keyPath)
  }

  mutating func update(with value: Value) {
    self.storage = .value(value)
  }
}
