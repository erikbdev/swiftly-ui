private struct FixedFrameModifier: ViewModifier {
  let width: Double?
  let height: Double?
  let alignment: Alignment

  public func body(content: Content) -> Never { content.body }

  public typealias Body = Never
}

@_spi(Internals)
extension FixedFrameModifier: PrimitiveViewModifier {
  static func _makeViewModifier<T>(_ modifier: Self, for node: Node<T>) where T: View {}
}

extension View {
  public func frame(
    width: Double? = nil,
    height: Double? = nil,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(FixedFrameModifier(width: width, height: height, alignment: alignment))
  }
}
