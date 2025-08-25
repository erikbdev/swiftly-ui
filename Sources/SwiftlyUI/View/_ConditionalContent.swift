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
  public static func _makePrimitiveView(_ node: Node<Self>) {}
}
