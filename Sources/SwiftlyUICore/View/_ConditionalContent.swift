public struct _ConditionalContent<TrueContent: View, FalseContent: View>: View {
  public enum Content {
    case trueContent(TrueContent)
    case falseContent(FalseContent)
  }

  public var content: Content

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension _ConditionalContent: PrimitiveView {
  public static func _makeView(_ node: ViewNode<Self>) {
    switch node.view.content {
    case .trueContent(let view):
      node.appendChild(ViewNode(view))
    case .falseContent(let view):
      node.appendChild(ViewNode(view))
    }
  }
}
