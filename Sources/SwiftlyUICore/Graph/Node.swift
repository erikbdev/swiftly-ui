import Foundation

@_spi(Internals)
open class Node<T>: AnyNode {
  private(set) var object: T
  var properties = DynamicPropertyBuffer()
  var built = false
 
  init(_ object: T) {
    self.object = object
  }

 func property<V, R>(_ keyPath: KeyPath<T, Binding<V>>, operation: (Binding<V>) -> R) -> R {
    operation(object[keyPath: keyPath])
  }

  func appendChild<V: View>(_ child: Node<V>) {
    child.parent = self
    self.children.append(child)
    child.build()
  }

  func build() where T: View {
    guard !built else { return }
    built = true
    bindProperties(
      &self.object,
      storage: &properties,
      inputs: DynamicPropertyInputs(environmentValues: self.resolvedEnvironmentValues)
    )
    T.makeView(self)
  }

  func appendChild<V: Scene>(_ child: Node<V>) {
    child.parent = self
    self.children.append(child)
  }
}

extension Node where T: View {
  var view: T {
    get { self.object }
    set { self.object = newValue }
  }
}

extension Node where T: Scene {
  var scene: T {
    get { object }
    set { object = newValue }
  }
}

func bindProperties<T>(
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
        of: descriptor.type,
        descriptor: descriptor,
        storage: &storage,
        indexPath: indexPath,
        inputs: inputs
      )
    }
  }
}

private func bindProperty<D: DynamicProperty>(
  _ ptr: UnsafeMutableRawPointer,
  of type: D.Type,
  descriptor: DynamicPropertyDescriptor,
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
