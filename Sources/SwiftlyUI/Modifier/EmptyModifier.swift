public struct EmptyModifier {}

extension EmptyModifier: ViewModifier {
  public func body(content: _ViewModifier_Content<Self>) -> Never {
    fatalError()
  }
}

@_spi(Internals)
extension EmptyModifier: PrimitiveViewModifier {
  public static func _makePrimitiveViewModifier(_ node: Node<Self>) {}
}

extension EmptyModifier: SceneModifier {
  public func body(content: _SceneModifier_Content<Self>) -> Never {
    fatalError()
  }
}

@_spi(Internals)
extension EmptyModifier: PrimitiveSceneModifier {
  public static func _makePrimitiveSceneModifier(_ node: Node<Self>) {}
}
