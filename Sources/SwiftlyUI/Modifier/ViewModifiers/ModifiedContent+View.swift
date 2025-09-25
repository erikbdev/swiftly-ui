@_spi(Internals)
extension ModifiedContent: PrimitiveView where Content: View, Modifier: ViewModifier, Modifier.Body == Never {
  public static func _makePrimitiveView(_ node: ViewNode<Self>) {
    // let child = node[\.content]
    // Content._makeView(child)
    // let childModifier = Node(node.object.modifier)
    // child.insertChild(childModifier)
    // Modifier._makeViewModifier(childModifier)
  }
}
