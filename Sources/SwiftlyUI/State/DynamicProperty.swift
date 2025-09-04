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

func updateDynamicProperties<T>(
  of value: T,
  environment: EnvironmentValues
) {
  let mirror = Mirror(reflecting: value)
  for child in mirror.children {
    guard let property = child.value as? DynamicProperty else {
      continue
    }

    property.update()
  }
}
