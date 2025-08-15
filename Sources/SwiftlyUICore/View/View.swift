//
//  Untitled.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

//@MainActor
//@preconcurrency
public protocol View {
    associatedtype Body: View
    
    @ViewBuilder
//    @MainActor
//    @preconcurrency
    var body: Self.Body { get }

    nonisolated static func _makeView(_ view: Self)
}

extension View {
    @_spi(Backend)
    public nonisolated static func _makeView(_ view: Self) {}
}

extension Never: View {
    public nonisolated var body: Never { self }
}
