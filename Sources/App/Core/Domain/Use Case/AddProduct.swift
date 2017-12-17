import Foundation

struct AddProduct {
  
  private let productRepository: ProductRepository
  
  init(productRepository: ProductRepository) {
    self.productRepository = productRepository
  }
  
  func execute(with request: AddProductRequest) throws -> Product {
    return try productRepository.add(with: request)
  }
}
