public struct TupleView<each Content: View>: View {
  public var content: (repeat each Content)

  public var body: Never { fatalError() }

  public init(_ content: repeat each Content) {
    self.content = (repeat each content)
  }
}

@_spi(Internals)
extension TupleView: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    repeat (each node.view.content).addNode(node)
  }
}

extension View {
  fileprivate func addNode<T>(_ parent: ViewNode<T>) {
    parent.appendChild(ViewNode(self))
  }
}
