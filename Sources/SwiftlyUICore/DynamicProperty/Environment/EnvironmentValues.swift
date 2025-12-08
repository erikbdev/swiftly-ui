//
//  EnvironmentValues.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct EnvironmentValues {
  private var storage: [ObjectIdentifier: Any?] = [:]

  public subscript<T: EnvironmentKey>(_ key: T.Type) -> T.Value {
    get {
      if storage.keys.contains(ObjectIdentifier(T.self)) {
        storage[ObjectIdentifier(T.self)] as! T.Value
      } else {
        T.defaultValue
      }
    }
    set {
      storage.updateValue(newValue, forKey: ObjectIdentifier(T.self))
    }
  }

  func merging(_ other: EnvironmentValues) -> EnvironmentValues {
    EnvironmentValues(storage: storage.merging(other.storage, uniquingKeysWith: { $1 }))
  }
}