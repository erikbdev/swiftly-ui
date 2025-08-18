public struct _ConditionalContent<TrueContent: View, FalseContent: View>: View {
  enum Content {
    case trueContent(TrueContent)
    case falseContent(FalseContent)
  }

  var content: Content

  public var body: Never { fatalError() }
}
