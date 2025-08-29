extension Optional: View where Wrapped: View {
  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Optional: PrimitiveView where Wrapped: PrimitiveView {
  public nonisolated static func _makePrimitiveView(_ node: Node<Self>) {
    switch node.object {
    case .some(let view):
      let child = Node(view)
      node.insertChild(child)
      Wrapped._makeView(child)
    case .none:
      break
    }
    // Wrapped._makeView(node[\.wrapped])
  }

  private var wrapped: Wrapped { fatalError() }
}
