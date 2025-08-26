//
//  ShapeStyle.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol ShapeStyle: Sendable {
  associatedtype Resolved: ShapeStyle = Never

  func resolve(in environment: EnvironmentValues) -> Self.Resolved
}

extension Never: ShapeStyle {
  public typealias Resolved = Never
}

extension ShapeStyle where Resolved == Never {
  public func resolve(in: EnvironmentValues) -> Self.Resolved {
    fatalError()
  }
}

@_spi(Internals)
public protocol PrimitiveShapeStyle: ShapeStyle where Resolved == Never {
  static func _makeShapeStyle(_ node: GraphNode<Self>)
}

public struct AnyShapeStyle: ShapeStyle {
  let base: any ShapeStyle

  public init(_ style: some ShapeStyle) {
    if let style = style as? AnyShapeStyle {
      self.base = style.base
    } else {
      self.base = style
    }
  }
}
