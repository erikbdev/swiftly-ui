//
//  DynamicProperty.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol DynamicProperty {
  mutating func update()
}

extension DynamicProperty {
  public func update() {}
}

// func updateDynamicProperties<T>(
//   _ value: T,
//   environment: EnvironmentValues
// ) {
//     let mirror = Mirror(reflecting: value)
// }
