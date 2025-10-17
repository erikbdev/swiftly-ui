public protocol ViewVisitor {
  func visit<V: View>(_ view: V)
}

extension View {
  func visitChildren<V: ViewVisitor>(_ visitor: V) {
    if let prim = self as? any PrimitiveView {
      prim._visitChildren(visitor)
    } else {
      visitor.visit(body)
    }
  }
}
