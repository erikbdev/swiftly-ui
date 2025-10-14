public protocol ViewRepresentable: View where Body == Never {
  associatedtype ViewType
  associatedtype Coordinator

  typealias Context = ViewRepresentableContext<Self>

  func makeView(context: Self.Context) -> ViewType
  func updateView(_ view: Self.ViewType, context: Self.Context)

  func makeCoordinator() -> Coordinator
}

extension ViewRepresentable {
  public var body: Never { fatalError() }
  public typealias Coordiator = Void
  public func makeCoordinator() {}
}

public struct ViewRepresentableContext<Representable: ViewRepresentable> {
  let coordinator: Representable.Coordinator
  var transaction: Transaction
  var environment: EnvironmentValues
}
