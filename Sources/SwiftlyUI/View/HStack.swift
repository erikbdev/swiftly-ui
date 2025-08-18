//
//  HStack.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct HStack<Content: View>: View {
  public var body: Content

  private var spacing: Int?
  private var alignment: VerticalAlignment

  public init(
    alignment: VerticalAlignment = .center,
    spacing: Int? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.alignment = alignment
    self.body = content()
    self.spacing = spacing
  }
}
