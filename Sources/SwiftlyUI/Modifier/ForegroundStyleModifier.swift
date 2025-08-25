//
//  ForegroundStyleModifier.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

extension View {
  public nonisolated func foregroundStyle<S: ShapeStyle>(_ style: S) -> some View {
    modifier(_ForegroundStyleModifier(style: style))
  }
}

public struct _ForegroundStyleModifier<Style: ShapeStyle>: ViewModifier {
  public var style: Style

  public init(style: Style) {
    self.style = style
  }

  public func body(content: Content) -> Never { fatalError() }
}

extension ModifierValues where Root: View {
  public var foregroundStyle: _ForegroundStyleModifierKey<Root>.Value? {
    get { self[_ForegroundStyleModifierKey<Root>.self] }
    set { self[_ForegroundStyleModifierKey<Root>.self] = newValue }
  }
}

public struct _ForegroundStyleModifierKey<Root: View>: ModifierKey {
  public typealias Value = AnyShapeStyle
}
