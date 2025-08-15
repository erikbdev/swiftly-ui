public struct Window<Content: View>: Scene {
  public var content: Content

  public var body: Never { fatalError() }

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}
