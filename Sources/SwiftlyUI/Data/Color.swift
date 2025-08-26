public struct Color: Hashable, Sendable, View, ShapeStyle {
  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Color: PrimitiveView {
  public static func _makePrimitiveView(_ node: GraphNode<Self>) {}
}

extension ShapeStyle where Self == Color {
  public static var red: Color { Color() }
  public static var green: Color { Color() }
  public static var blue: Color { Color() }
}
