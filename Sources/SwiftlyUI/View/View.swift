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

  nonisolated static func _makeView(_ view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs
}

extension View {
  public nonisolated static func _makeView(_ view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs {
    _ViewOutputs()
  }
}

extension Never: View {
  public nonisolated var body: Never { self }
}
