public struct TupleView<each Content: View>: View {
  public var content: (repeat each Content)

  public var body: Never { fatalError() }

  public init(_ content: repeat each Content) {
    self.content = (repeat each content)
  }
}

@_spi(Internals)
extension TupleView: PrimitiveView {
  public nonisolated static func _makePrimitiveView(_ node: Node<Self>) {
    repeat (each Content)._makeView(node.tuple())
  }
}

extension Node where V: View {
  fileprivate func tuple<T>(_: T.Type = T.self) -> Node<T> {
    let node = Node<T>()
    node.parent = self
    self.children.append(node)
    return node
  }
}
