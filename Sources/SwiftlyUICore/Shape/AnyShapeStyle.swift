public struct AnyShapeStyle: ShapeStyle {
  let base: any ShapeStyle

  public init(_ style: some ShapeStyle) {
    if let style = style as? AnyShapeStyle {
      self.base = style.base
    } else {
      self.base = style
    }
  }
}
