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
