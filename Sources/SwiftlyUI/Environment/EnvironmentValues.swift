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
      storage[ObjectIdentifier(T.self), default: T.defaultValue] as! T.Value
    }
    set {
      storage[ObjectIdentifier(T.self)] = newValue
    }
  }
}
