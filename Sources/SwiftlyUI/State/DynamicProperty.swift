//
//  DynamicProperty.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol DynamicProperty {
  mutating func update()

  // static func _makeProperty<Value>(
  // in buffer: inout _DynamicPropertyBuffer,
  // container: _GraphValue<Value>,
  // fieldOffset: Int,
  // inputs: inout _GraphInputs
  // )
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
