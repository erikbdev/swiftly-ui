@_spi(Internals)
extension ModifiedContent: PrimitiveView where Content: View, Modifier: ViewModifier, Modifier.Body == Never {
  public static func _makeView(_ node: ViewNode<Self>) {
    node.appendChild(ViewNode(node.view.content))
    // Modifier._makeViewModifier(Node(node.view))
    // let child = node[\.content]
    // Content._makeView(child)
    // let childModifier = Node(node.object.modifier)
    // child.appendChild(childModifier)
    // Modifier._makeViewModifier(childModifier)
  }
}
