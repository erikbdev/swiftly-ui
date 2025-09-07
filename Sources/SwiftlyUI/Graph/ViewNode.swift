/// A View Node that contains the storage of a View.
@_spi(Internals)
public class ViewNode<T: View>: Node<T> {
  var properties = DynamicPropertyBuffer()

  func makeBody(_ operation: () -> Void) {
    // Resolve all properties before accessing body.
    // let fields = DynamicProperties.fields(for: T.self)
  }
}
