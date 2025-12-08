public struct EnvironmentalKeyWritingModifier<Value>: ViewModifier {
  public var keyPath: WritableKeyPath<EnvironmentValues, Value>
  public var value: Value

  public init(keyPath: WritableKeyPath<EnvironmentValues, Value>, value: Value) {
    self.keyPath = keyPath
    self.value = value
  }
}

@_spi(Internals)
extension EnvironmentalKeyWritingModifier: PrimitiveViewModifier {
  public static func _makeViewModifier<T: View>(_ modifier: Self, for node: Node<T>) {
    node.environmentValues[keyPath: modifier.keyPath] = modifier.value
  }
}

extension View {
  func environment<Value>(_ keyPath: WritableKeyPath<EnvironmentValues, Value>, _ value: Value) -> some View {
    self.modifier(EnvironmentalKeyWritingModifier(keyPath: keyPath, value: value))
  }
}
