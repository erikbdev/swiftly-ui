public struct Window<Content: View>: Scene {
  public var content: Content
  public var identifier: String
  public var title: Text

  public var body: Never { sceneBodyNever() }

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
    self.identifier = ""
    self.title = Text("")
  }
}

@_spi(Internals)
extension Window: PrimitiveScene {
  public static func _makePrimitiveScene(_ node: Node<Self>) {
    Content._makeView(node[\.content])
  }
}
