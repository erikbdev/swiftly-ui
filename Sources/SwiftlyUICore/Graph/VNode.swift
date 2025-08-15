//
//  VNode.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct VNode<Node: View> {
  public var view: Node
}

extension VNode: Sendable where Node: Sendable {}
