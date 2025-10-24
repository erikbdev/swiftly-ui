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

  #if !hasFeature(Embedded)
    @_disfavoredOverload
    public static func buildBlock<each Content: View>(_ content: repeat each Content) -> TupleView<repeat each Content> {
      TupleView(repeat each content)
    }
  #else
    public static func buildBlock<V0: View, V1: View>(_ v0: V0, _ v1: V1) -> TupleView<(V0, V1)> {
      TupleView((v0, v1))
    }

    public static func buildBlock<V0: View, V1: View, V2: View>(_ v0: V0, _ v1: V1, _ v2: V2) -> TupleView<(V0, V1, V2)> {
      TupleView((v0, v1, v2))
    }

    public static func buildBlock<V0: View, V1: View, V2: View, V3: View>(_ v0: V0, _ v1: V1, _ v2: V2, _ v3: V3) -> TupleView<(V0, V1, V2, V3)> {
      TupleView((v0, v1, v2, v3))
    }

    public static func buildBlock<V0: View, V1: View, V2: View, V3: View, V4: View>(_ v0: V0, _ v1: V1, _ v2: V2, _ v3: V3, _ v4: V4) -> TupleView<
      (V0, V1, V2, V3, V4)
    > {
      TupleView((v0, v1, v2, v3, v4))
    }

    public static func buildBlock<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View>(
      _ v0: V0,
      _ v1: V1,
      _ v2: V2,
      _ v3: V3,
      _ v4: V4,
      _ v5: V5
    ) -> TupleView<
      (V0, V1, V2, V3, V4, V5)
    > {
      TupleView((v0, v1, v2, v3, v4, v5))
    }
  #endif
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

#if !hasFeature(Embedded)
  extension ViewBuilder {
    public static func buildLimitedAvailability<Content: View>(_ content: Content) -> AnyView {
      AnyView(content)
    }
  }
#endif
