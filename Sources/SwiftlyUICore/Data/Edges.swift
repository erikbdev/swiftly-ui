//
//  Edge.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct HorizontalEdge: Sendable, Codable {
  public static let leading = HorizontalEdge()
  public static let trailing = HorizontalEdge()

  public struct Set: Sendable {
    public static let leading = HorizontalEdge.Set()
    public static let trailing = HorizontalEdge.Set()
    public static let all = HorizontalEdge.Set()

    public init(_ edge: HorizontalEdge) {}

    init() {}
  }
}

public struct VerticalEdge: Sendable, Codable {
  public static let top = VerticalEdge()
  public static let bottom = VerticalEdge()

  public struct Set: Sendable {
    public static let top = VerticalEdge.Set()
    public static let bottom = VerticalEdge.Set()
    public static let all = VerticalEdge.Set()

    public init(_ edge: VerticalEdge) {}

    init() {}
  }
}
