//
//  Environment.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@propertyWrapper
public struct Environment<Value>: DynamicProperty {
  private enum Storage {
    case keyPath(KeyPath<EnvironmentValues, Value>)
    case value(Value)
  }

  private var storage: Storage

  public var wrappedValue: Value {
    switch storage {
    case .value(let value):
      return value
    case .keyPath(let keyPath):
      logger.critical(
        """
        Accessing Environment<\(Value.self)>'s value outside of \
        being installed on a View. \
        This will always read the default value \
        and will not update.
        """
      )
      return EnvironmentValues()[keyPath: keyPath]
    }
  }

  public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
    self.storage = .keyPath(keyPath)
  }
}

extension Environment: PrimitiveDynamicProperty {
  mutating func _makeDynamicProperty(_ field: inout DynamicPropertyBuffer.Field, inputs: DynamicPropertyInputs) {
    guard case .keyPath(let keyPath) = storage else {
      return
    }

    self.storage = .value(inputs.environmentValues[keyPath: keyPath])
  }
}

internal final class EnvironmentValuesBox {
  var environmentValues = EnvironmentValues()

  init() {}
}
