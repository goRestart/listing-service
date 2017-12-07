import CoreService

extension Assembly {
  var productRouteCollection: ProductRouteCollection {
    return ProductRouteCollection(
      productController: productController
    )
  }
  
  private var productController: ProductController {
    return ProductController(
      addProduct: addProduct
    )
  }
}
