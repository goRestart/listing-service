import Vapor

private struct Endpoint {
  static let product = "/product"
}

struct ProductRouteCollection: RouteCollection {
  
  private let productController: ProductController
  
  init(productController: ProductController) {
    self.productController = productController
  }
  
  func build(_ builder: RouteBuilder) throws {
    builder.post(Endpoint.product) { request in
      return try self.productController.addProduct(with: request)
    }
  }
}
