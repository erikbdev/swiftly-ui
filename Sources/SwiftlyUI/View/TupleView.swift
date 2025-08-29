public struct TupleView<each Content: View>: View {
  public var content: (repeat each Content)

  public var body: Never { fatalError() }

  public init(_ content: repeat each Content) {
    self.content = (repeat each content)
  }
}

@_spi(Internals)
extension TupleView: PrimitiveView {
  public nonisolated static func _makePrimitiveView(_ node: ViewNode<Self>) {
    repeat (each node.object.content).addNode(node)
  }
}

extension View {
  fileprivate func addNode<T>(_ parent: ViewNode<T>) {
    let child = ViewNode(self)
    parent.insertChild(child)
    Self._makeView(child)
  }
}
