public struct EmptyModifier: Sendable {}

extension EmptyModifier: ViewModifier {
  public func body(content: _ViewModifier_Content<Self>) -> Never {
    content.body
  }
}

@_spi(Internals)
extension EmptyModifier: PrimitiveViewModifier {
  public static func _makeViewModifier<T>(_ modifier: EmptyModifier, for node: Node<T>) {}
}

extension EmptyModifier: SceneModifier {
  public func body(content: _SceneModifier_Content<Self>) -> Never {
    content.body
  }
}

@_spi(Internals)
extension EmptyModifier: PrimitiveSceneModifier {
  public static func _makeSceneModifier(_ node: Node<Self>) {}
}
