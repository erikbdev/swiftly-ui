public struct EnvironmentalKeyWritingModifier<Value>: ViewModifier {
  public var keyPath: WritableKeyPath<EnvironmentValues, Value>
  public var value: Value

  public init(keyPath: WritableKeyPath<EnvironmentValues, Value>, value: Value) {
    self.keyPath = keyPath
    self.value = value
  }

  public func body(content: Content) -> Never {
    fatalError()
  }
}

@_spi(Internals)
extension EnvironmentalKeyWritingModifier: PrimitiveViewModifier {
  public static func _makePrimitiveViewModifier(_ node: Node<Self>) {
    node.parent?.environmentValues[keyPath: node.object.keyPath] = node.object.value
  }
}

extension View {
  func environment<Value>(_ keyPath: WritableKeyPath<EnvironmentValues, Value>, _ value: Value) -> some View {
    self.modifier(EnvironmentalKeyWritingModifier(keyPath: keyPath, value: value))
  }
}
