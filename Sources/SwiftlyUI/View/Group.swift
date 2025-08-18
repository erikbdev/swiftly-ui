//
//  Group.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Group<Content: View>: View {
  public var body: Content

  public init(@ViewBuilder content: () -> Content) {
    self.body = content()
  }
}
