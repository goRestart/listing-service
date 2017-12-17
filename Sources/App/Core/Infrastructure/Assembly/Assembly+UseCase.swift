import CoreService

extension Assembly {
  var addProduct: AddProduct {
    return AddProduct(
      productRepository: productRepository
    )
  }
}
