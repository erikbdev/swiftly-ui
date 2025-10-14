extension Optional: View where Wrapped: View {
  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Optional: PrimitiveView where Wrapped: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    // switch node.object {
    // case .some(let view):
    //   let child = Node(view)
    //   node.insertChild(child)
    //   Wrapped._makeView(child)
    // case .none:
    //   break
    // }
    // // Wrapped._makeView(node[\.wrapped])
  }

  public nonisolated func _visitChildren<V>(_ visitor: V) where V: ViewVisitor {
    switch self {
    case .none: break
    case .some(let primitive): visitor.visit(primitive)
    }
  }
}
