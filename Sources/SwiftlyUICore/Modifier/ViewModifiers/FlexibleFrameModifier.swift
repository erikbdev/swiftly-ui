private struct FlexibleFrameModifier: ViewModifier {
  let minWidth: Double?
  let idealWidth: Double?
  let maxWidth: Double?
  let minHeight: Double?
  let idealHeight: Double?
  let maxHeight: Double?
  let alignment: Alignment

  func body(content: Content) -> Never { content.body }
}

@_spi(Internals)
extension FlexibleFrameModifier: PrimitiveViewModifier {
  static func _makeViewModifier<T>(_ modifier: Self, for node: Node<T>) {}
}

extension View {
  func frame(
    minWidth: Double? = nil,
    idealWidth: Double? = nil,
    maxWidth: Double? = nil,
    minHeight: Double? = nil,
    idealHeight: Double? = nil,
    maxHeight: Double? = nil,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FlexibleFrameModifier(
        minWidth: minWidth,
        idealWidth: idealWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        idealHeight: idealWidth,
        maxHeight: maxHeight,
        alignment: alignment
      )
    )
  }
}
