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
    
    public func body(content: Content) -> some View {
        fatalError()
    }
}
