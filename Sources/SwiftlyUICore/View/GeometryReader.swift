//
//  GeometryReader.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct GeometryReader<Content: View>: View {
  public var body: Never { fatalError() }
  public var content: (GeometryProxy) -> Content

  @inlinable
  public init(@ViewBuilder content: @escaping (GeometryProxy) -> Content) {
    self.content = content
  }
}

/// TODO: get view size?
public struct GeometryProxy {
  public var size: SIMD2<Int> {
    fatalError()
  }

  public subscript<T>(anchor: Anchor<T>) -> T {
    fatalError()
  }

  public var safeAreaInsets: EdgeInsets {
    fatalError()
  }
}

public struct Anchor<Value> {}

public struct EdgeInsets: Hashable {
  public var top: Int
  public var bottom: Int
  public var leading: Int
  public var trailing: Int

  public init(top: Int = 0, bottom: Int = 0, leading: Int = 0, trailing: Int = 0) {
    self.top = top
    self.bottom = bottom
    self.leading = leading
    self.trailing = trailing
  }
}

@_spi(Internals)
extension GeometryReader: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {}
  public nonisolated func _visitChildren<V>(_ visitor: V) where V: ViewVisitor {}
}
