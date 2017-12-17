import Foundation

struct ProductDiskDataSource: ProductDataSource {
  
  private let addProductTask: AddProductTask
  private let productMapper: ProductMapper
  
  init(addProductTask: AddProductTask,
       productMapper: ProductMapper)
  {
    self.addProductTask = addProductTask
    self.productMapper = productMapper
  }
  
  func add(with request: AddProductRequest) throws -> Product {
    return try productMapper.map(
      try addProductTask.execute(with: request)
    )
  }
}
