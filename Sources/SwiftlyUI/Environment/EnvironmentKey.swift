//
//  EnvironmentKey.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol EnvironmentKey {
  associatedtype Value

  static var defaultValue: Value { get }
}
