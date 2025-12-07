extension Optional: View where Wrapped: View {
  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Optional: PrimitiveView where Wrapped: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    switch node.view {
    case .some(let view):
      node.appendChild(ViewNode(view))
    case .none:
      break
    }
  }
}
