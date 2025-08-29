public struct _ConditionalContent<TrueContent: View, FalseContent: View>: View {
  enum Content {
    case trueContent(TrueContent)
    case falseContent(FalseContent)
  }

  var content: Content

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension _ConditionalContent: PrimitiveView {
  public static func _makePrimitiveView(_ node: Node<Self>) {
    switch node.object.content {
    case .trueContent(let view):
      let scope = Node(view)
      node.insertChild(scope)
      TrueContent._makeView(scope)
    case .falseContent(let view):
      let scope = Node(view)
      node.insertChild(scope)
      FalseContent._makeView(scope)
    }
  }
}
