//
//  State.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct State<Value>: DynamicProperty {}

extension State: Sendable where Value: Sendable {}
