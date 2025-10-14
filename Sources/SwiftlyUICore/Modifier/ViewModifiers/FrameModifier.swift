public struct FrameModifier: ViewModifier {
  public func body(content: Content) -> Never { fatalError() }

  public typealias Body = Never
}

@_spi(Internals)
extension FrameModifier: PrimitiveViewModifier {
  public static func _makePrimitiveViewModifier(_ node: Node<FrameModifier>) {

  }
}

extension View {
  public func frame(
    width: Double? = nil,
    height: Double? = nil,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(FrameModifier())
  }

  func frame(
    minWidth: Double? = nil,
    idealWidth: Double? = nil,
    maxWidth: Double? = nil,
    minHeight: Double? = nil,
    idealHeight: Double? = nil,
    maxHeight: Double? = nil,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(FrameModifier())
  }
}
