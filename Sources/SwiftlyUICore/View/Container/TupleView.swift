#if !hasFeature(Embedded)
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
      repeat (each node.object.content).addNode(node)
    }

    public nonisolated func _visitChildren<V: ViewVisitor>(_ visitor: V) {
      repeat (visitor.visit(each content))
    }
  }
#else
  public struct TupleView<T>: View {
    public var content: T
    public var body: Never { fatalError() }
    public init(_ content: T) {
      self.content = content
    }
  }

  @_spi(Internals)
  extension TupleView: PrimitiveView {
    public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    }

    public nonisolated func _visitChildren<V: ViewVisitor>(_ visitor: V) {
    }
  }
#endif

extension View {
  fileprivate func addNode<T>(_ parent: ViewNode<T>) {
    let child = ViewNode(self)
    parent.insertChild(child)
    Self.makeView(child)
  }
}
