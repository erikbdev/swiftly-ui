//
//  EnvironmentValues.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct EnvironmentValues {
  private var storage: [ObjectIdentifier: Any] = [:]

  public subscript<T: EnvironmentKey>(_ key: T.Type) -> T.Value {
    get {
      if storage.keys.contains(ObjectIdentifier(T.self)) {
        unsafeBitCast(storage[ObjectIdentifier(T.self)], to: T.Value.self)
      } else {
        T.defaultValue
      }
    }
    set {
      storage[ObjectIdentifier(T.self)] = newValue
    }
  }
}

extension EnvironmentValues: @unchecked Sendable {}
