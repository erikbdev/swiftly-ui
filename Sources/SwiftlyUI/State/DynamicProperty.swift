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

struct _DynamicPropertyBuffer {
  struct PropertyField {
    let type: DynamicProperty.Type
    let offset: Int
  }

  var properties: [PropertyField]
}
