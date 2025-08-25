extension Optional: View where Wrapped: View {
  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Optional: PrimitiveView where Wrapped: PrimitiveView {
  public nonisolated static func _makeView(_ node: Node<Self>) {
    Wrapped._makeView(node[\.wrapped])
  }

  private var wrapped: Wrapped { fatalError() }
}