/// A node that manages a single View
@_spi(Internals)
public class ViewNode<T: View>: Node<T> {
  var properties = DynamicPropertyBuffer()

  override public init(_ object: T) {
    super.init(object)

    /// Bind properties
    bindProperties(
      &self.object,
      storage: &properties,
      inputs: DynamicPropertyInputs(environmentValues: self.parent?.environmentValues ?? self.environmentValues)
    )
    reevaluate()
  }

  func property<V, R>(_ keyPath: KeyPath<T, Binding<V>>, operation: (Binding<V>) -> R) -> R {
    operation(object[keyPath: keyPath])
  }

  func reevaluate() {
    self.children.removeAll(keepingCapacity: true)
    bindProperties(
      &self.object,
      storage: &properties,
      inputs: DynamicPropertyInputs(environmentValues: parent?.environmentValues ?? self.environmentValues)
    )
    T.makeView(self)
  }
}

private func bindProperties<T>(
  _ value: inout T,
  storage: inout DynamicPropertyBuffer,
  indexPath: DynamicPropertyBuffer.IndexPath = .root,
  inputs: DynamicPropertyInputs
) {
  let descriptors = DynamicPropertyBuffer.descriptors(of: T.self)
  guard !descriptors.isEmpty else { return }
  withUnsafeMutablePointer(to: &value) {
    let base = UnsafeMutableRawPointer($0)
    for descriptor in descriptors {
      bindProperty(
        base.advanced(by: descriptor.offset),
        descriptor: descriptor,
        of: descriptor.type,
        storage: &storage,
        indexPath: indexPath,
        inputs: inputs
      )
    }
  }
}

private func bindProperty<D: DynamicProperty>(
  _ ptr: UnsafeMutableRawPointer,
  descriptor: DynamicPropertyDescriptor,
  of type: D.Type,
  storage: inout DynamicPropertyBuffer,
  indexPath: DynamicPropertyBuffer.IndexPath,
  inputs: DynamicPropertyInputs
) {
  let property = ptr.assumingMemoryBound(to: D.self)
  defer { property.pointee.update() }
  let indexPath = indexPath.appending(descriptor.offset)
  guard let primitiveType = D.self as? PrimitiveDynamicProperty.Type else {
    return bindProperties(
      &property.pointee,
      storage: &storage,
      indexPath: indexPath,
      inputs: inputs
    )
  }
  var field = storage.fields[indexPath, default: .init(type: D.self)]
  assert(field.type == D.self)
  _cast(type: primitiveType, pointer: property, field: &field, inputs: inputs)
  storage.fields[indexPath] = field
}

private func _cast<T: PrimitiveDynamicProperty, D: DynamicProperty>(
  type: T.Type,
  pointer: UnsafeMutablePointer<D>,
  field: inout DynamicPropertyBuffer.Field,
  inputs: DynamicPropertyInputs
) {
  pointer.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee._makeDynamicProperty(&field, inputs: inputs) }
}
