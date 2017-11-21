import Vapor

private struct Endpoint {
  static let product = "/product"
}

struct ProductRouteCollection: RouteCollection {
  
  func build(_ builder: RouteBuilder) throws {
    builder.post(Endpoint.product) { request in
      return "ok"
    }
  }
}
