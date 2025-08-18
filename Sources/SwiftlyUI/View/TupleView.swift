public struct TupleView<each Content: View>: View {
  public var content: (repeat each Content)

  public var body: Never { fatalError() }

  public init(_ content: repeat each Content) {
    self.content = (repeat each content)
  }
}
