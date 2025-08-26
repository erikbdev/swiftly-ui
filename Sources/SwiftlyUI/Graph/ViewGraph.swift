public final class ViewGraph<Root: View> {
  var root: GraphNode<Root>

  public init(_ root: Root) {
    self.root = GraphNode(root)
  }

  func logTree() -> String {
    root.logTree()
  }
}
