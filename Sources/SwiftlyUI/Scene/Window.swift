public struct Window<Content: View>: Scene {
  public var content: Content
  public var identifier: String
  public var title: Text

  public var body: Never { fatalError() }

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
    self.identifier = ""
    self.title = Text("")
  }
}
