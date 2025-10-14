public protocol Shape: Sendable, View {
  nonisolated func path(in rect: SIMD4<Double>)
  nonisolated static var role: ShapeRole { get }
}

public enum ShapeRole: Sendable {
  case fill
  case stroke
  case separator
}

extension Shape {
  public static var role: ShapeRole { .fill }
}
