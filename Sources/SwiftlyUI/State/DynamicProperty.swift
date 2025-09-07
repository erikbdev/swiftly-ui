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

  static func makeProperty(_ field: inout DynamicPropertyBuffer.Field) {
    // TODO: also map all other properties in extension
  }
}

protocol PrimitiveDynamicProperty: DynamicProperty {
  static func makePrimitiveProperty(_ field: inout DynamicPropertyBuffer.Field)
}

struct DynamicPropertyBuffer {
  var fields: [Field] = []

  struct FieldDescriptor {
    let type: DynamicProperty.Type
    let offset: Int
    let name: String
  }

  struct Field {
    let descriptor: FieldDescriptor
    var context: AnyObject?
  }

  private static nonisolated(unsafe) var cache: [ObjectIdentifier: [FieldDescriptor]] = [:]

  static func fields<T>(of type: T.Type) -> [FieldDescriptor] {
    if let cached = cache[ObjectIdentifier(type)] {
      return cached
    }
    var fields: [FieldDescriptor] = []
    let childCount = _getRecursiveChildCount(type)
    for i in 0..<childCount {
      let offset = _getChildOffset(type, index: i)
      var field = _FieldReflectionMetadata()
      let fieldType = _getChildMetadata(type, index: i, fieldMetadata: &field)
      let fieldName = field.name.flatMap(String.init(cString:)) ?? ""
      defer { field.freeFunc?(field.name) }
      guard let dynamicPropertyType = fieldType as? DynamicProperty.Type else {
        continue
      }
      fields.append(
        FieldDescriptor(
          type: dynamicPropertyType,
          offset: offset,
          name: fieldName
        )
      )
    }
    cache[ObjectIdentifier(type)] = fields
    return fields
  }
}
