extension Optional: View where Wrapped: View {
  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Optional: PrimitiveView where Wrapped: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    // switch node.
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
}
