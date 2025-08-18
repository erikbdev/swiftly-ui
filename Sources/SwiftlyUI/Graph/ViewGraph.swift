public final class ViewGraph<Root: View> {
  var root: Node<Root>

  public init(_ root: Root) {
    self.root = Node(root)
  }

  func logTree() -> String {
    root.logTree()
  }
}
