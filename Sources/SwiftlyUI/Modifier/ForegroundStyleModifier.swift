//
//  ForegroundStyleModifier.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

extension View {
  public nonisolated func foregroundStyle<S: ShapeStyle>(_ primary: S) -> some View {
    modifier(_ForegroundStyleModifier(primary))
  }

  public nonisolated func foregroundStyle<S1: ShapeStyle, S2: ShapeStyle>(
    _ primary: S1,
    _ secondary: S2
  ) -> some View {
    modifier(_ForegroundStyleModifier(primary, secondary))
  }

  public nonisolated func foregroundStyle<S1: ShapeStyle, S2: ShapeStyle, S3: ShapeStyle>(
    _ primary: S1,
    _ secondary: S2,
    _ tertiary: S3
  ) -> some View {
    modifier(_ForegroundStyleModifier(primary, secondary, tertiary))
  }
}

public struct _ForegroundStyleModifier<S: ShapeStyle, each Style: ShapeStyle>: ViewModifier {
  public var primary: S
  public var styles: (repeat each Style)

  public init(_ primary: S, _ styles: repeat each Style) {
    self.primary = primary
    self.styles = (repeat each styles)
  }

  public func body(content: Content) -> Never { fatalError() }
}

@_spi(Internals)
extension _ForegroundStyleModifier: PrimitiveViewModifier {
  public static func _makeView(_ node: Node<Self>) {
    //        repeat (each Style)._makeShapeStyle(<#T##Node<Self>#>)
  }
}

extension ModifierValues where Root: View {
  public var foregroundStyle: _ForegroundStyleModifierKey<Root>.Value? {
    get { self[_ForegroundStyleModifierKey<Root>.self] }
    set { self[_ForegroundStyleModifierKey<Root>.self] = newValue }
  }
}

public struct _ForegroundStyleModifierKey<Root: View>: ModifierKey {
  public typealias Value = AnyShapeStyle?
}
