final class Fiber {
  // var implicitId: AnyHashable
  var explicitId: AnyHashable?

  weak var child: Fiber?
  weak var sibling: Fiber?
  var index: Int = 0
}
