//
//  ViewBuilder.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@resultBuilder
public enum ViewBuilder {
    public static func buildExpression<Content: View>(_ content: Content) -> Content {
        content
    }
    
    @available(*, unavailable, message: "this expression does not conform to 'View'")
    @_disfavoredOverload
    @_alwaysEmitIntoClient
    public static func buildExpression(_ invalid: Any) -> some View { fatalError() }
  
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }
    
    public static func buildBlock<Content: View>(_ content: Content) -> Content {
        content
    }
    
    @_disfavoredOverload
    public static func buildBlock<each Content: View>(_ content: repeat each Content) -> TupleView<repeat each Content> {
        TupleView(repeat each content)
    }
}

extension ViewBuilder {
    public static func buildIf<Content: View>(_ content: Content?) -> Content? {
        content
    }
    
    public static func buildEither<TrueContent: View, FalseContent: View>(first content: TrueContent) -> _ConditionalContent<TrueContent, FalseContent> {
        .trueContent(content)
    }
    
    public static func buildEither<TrueContent: View, FalseContent: View>(second content: FalseContent) -> _ConditionalContent<TrueContent, FalseContent> {
        .falseContent(content)
    }
}

extension ViewBuilder {
    // TODO: Convert response to AnyView
    public static func buildLimitedAvailability<Content: View>(_ content: Content) -> Content {
        content
    }
}

public struct TupleView<each Content: View>: View {
    public var content: (repeat each Content)
    
    public var body: Never { fatalError() }
    
    @inlinable public init(_ content: repeat each Content) {
        self.content = (repeat each content)
    }
}

public enum _ConditionalContent<TrueContent: View, FalseContent: View>: View {
    case trueContent(TrueContent)
    case falseContent(FalseContent)

    public var body: Never { fatalError() }
}

extension Optional: View where Wrapped: View {
    public var body: Never { fatalError() }
}
