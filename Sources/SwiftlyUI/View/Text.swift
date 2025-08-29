//
//  Text.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Text: View {
  var text: String
  var modifiers = ModifierValues<Text>()

  public var body: Never { fatalError() }

  public init(_ text: String) {
    self.text = text
  }

  public nonisolated func foregroundStyle<S: ShapeStyle>(_ style: S) -> Text {
    var base = self
    base.modifiers.foregroundStyle = AnyShapeStyle(style)
    return base
  }
}

@_spi(Internals)
extension Text: PrimitiveView {
  public nonisolated static func _makePrimitiveView(_ node: ViewNode<Self>) {}
}
