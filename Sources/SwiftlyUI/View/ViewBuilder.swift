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

  public static func buildEither<TrueContent: View, FalseContent: View>(first content: TrueContent) -> _ConditionalContent<TrueContent, FalseContent>
  {
    _ConditionalContent(content: .trueContent(content))
  }

  public static func buildEither<TrueContent: View, FalseContent: View>(second content: FalseContent) -> _ConditionalContent<
    TrueContent, FalseContent
  > {
    _ConditionalContent(content: .falseContent(content))
  }
}

extension ViewBuilder {
  public static func buildLimitedAvailability<Content: View>(_ content: Content) -> AnyView {
    AnyView(content)
  }
}
