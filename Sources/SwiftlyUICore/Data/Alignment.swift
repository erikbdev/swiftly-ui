//
//  VerticalAlignment.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct VerticalAlignment: Sendable, Hashable {
  public static let top = VerticalAlignment()
  public static let center = VerticalAlignment()
  public static let bottom = VerticalAlignment()
}

public struct HorizontalAlignment: Sendable, Hashable {
  public static let leading = HorizontalAlignment()
  public static let center = HorizontalAlignment()
  public static let trailing = HorizontalAlignment()
}

public struct Alignment: Sendable, Hashable {
  public static let top = Alignment()
  public static let bottom = Alignment()
  public static let leading = Alignment()
  public static let trailing = Alignment()
  public static let topLeading = Alignment()
  public static let topTrailing = Alignment()
  public static let bottomLeading = Alignment()
  public static let bottomTrailing = Alignment()
  public static let center = Alignment()
}
