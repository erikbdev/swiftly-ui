// From  https://github.com/philipturner/swift-reflection-mirror/tree/main

@_silgen_name("swift_getMetadataKind")
private func _metadataKind(_: Any.Type) -> UInt

@_silgen_name("swift_reflectionMirror_recursiveCount")
internal func _getRecursiveChildCount(_: Any.Type) -> Int

@_silgen_name("swift_reflectionMirror_recursiveChildMetadata")
internal func _getChildMetadata(
  _: Any.Type,
  index: Int,
  fieldMetadata: UnsafeMutablePointer<_FieldReflectionMetadata>
) -> Any.Type

@_silgen_name("swift_reflectionMirror_recursiveChildOffset")
internal func _getChildOffset(
  _: Any.Type,
  index: Int
) -> Int

internal struct _FieldReflectionMetadata {
  let name: UnsafePointer<CChar>? = nil
  let freeFunc: (@convention(c) (UnsafePointer<CChar>?) -> Void)? = nil
  let isStrong: Bool = false
  let isVar: Bool = false
}

private enum _MetadataKind: UInt {
  case `struct` = 0x200  // 0 | nonHeap

  init?(_ type: Any.Type) {
    let v = _metadataKind(type)
    guard let result = _MetadataKind(rawValue: v) else {
      return nil
    }
    self = result
  }
}
