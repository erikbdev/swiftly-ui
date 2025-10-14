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

struct DynamicPropertyInputs {
  var environmentValues: EnvironmentValues
}

protocol PrimitiveDynamicProperty: DynamicProperty {
  mutating func _makeDynamicProperty(_ field: inout DynamicPropertyBuffer.Field, inputs: DynamicPropertyInputs)
}

struct DynamicPropertyBuffer {
  var fields: [IndexPath: Field] = [:]

  struct Field {
    let type: DynamicProperty.Type
    var context: AnyObject?
  }

  struct IndexPath: Hashable {
    /// Each element is an index
    let indices: [Int]

    static var root: IndexPath { IndexPath(indices: []) }

    func appending(_ index: Int) -> IndexPath {
      IndexPath(indices: indices + [index])
    }
  }
}

struct DynamicPropertyDescriptor {
  let type: DynamicProperty.Type
  let offset: Int
  let name: String
}

extension DynamicPropertyBuffer {
  private static nonisolated(unsafe) var cache: [ObjectIdentifier: [DynamicPropertyDescriptor]] = [:]

  static func descriptors<T>(of type: T.Type) -> [DynamicPropertyDescriptor] {
    if let cached = cache[ObjectIdentifier(type)] {
      return cached
    }
    var fields: [DynamicPropertyDescriptor] = []
    let childCount = _getRecursiveChildCount(type)
    for i in 0..<childCount {
      let offset = _getChildOffset(type, index: i)
      var field = _FieldReflectionMetadata()
      let fieldType = _getChildMetadata(type, index: i, fieldMetadata: &field)
      guard let dynamicPropertyType = fieldType as? DynamicProperty.Type else {
        continue
      }
      let fieldName = field.name.flatMap(String.init(cString:)) ?? ""
      defer { field.freeFunc?(field.name) }
      fields.append(
        DynamicPropertyDescriptor(
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
