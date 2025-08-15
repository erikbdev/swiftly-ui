//
//  ViewModifier.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

extension View {
    public nonisolated func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
        ModifiedContent(content: self, modifier: modifier)
    }
}

public protocol ViewModifier {
    associatedtype Body: View
    
    @ViewBuilder
    func body(content: Self.Content) -> Self.Body
    
    typealias Content = _ViewModifier_Content<Self>
}

public struct _ViewModifier_Content<Modifier: ViewModifier>: View {
    public typealias Body = Never
    
    public var body: Never { fatalError() }
}

public struct ModifiedContent<Content, Modifier> {
    public typealias Body = Never
    
    public var content: Content
    public var modifier: Modifier
    
    public nonisolated init(content: Content, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }
}

extension ModifiedContent: Equatable where Content: Equatable, Modifier: Equatable {}

extension ModifiedContent: View where Content: View, Modifier: ViewModifier {
    public var body: Never { fatalError() }
}

//extension ModifiedContent: ViewModifier where Content: ViewModifier, Modifier: ViewModifier {
//    public func body(content: Content) -> Never {
//        fatalError()
//    }
//}

public struct EmptyModifier: ViewModifier {
    public typealias Body = Never
    
    public func body(content: Content) -> Never { fatalError() }
}

extension Never: ViewModifier {
    public typealias Body = Never
    
    public func body(content: Content) -> Never { fatalError() }
}
