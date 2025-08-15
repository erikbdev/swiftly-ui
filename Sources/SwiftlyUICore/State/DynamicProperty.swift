//
//  DynamicProperty.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol DynamicProperty {
    mutating func update()
}

extension DynamicProperty {
    public func update() {}
}
