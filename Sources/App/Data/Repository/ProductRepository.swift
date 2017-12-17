import Foundation

struct ProductRepository {
  
  private let diskDataSource: ProductDataSource
  
  init(diskDataSource: ProductDataSource) {
    self.diskDataSource = diskDataSource
  }
  
  func add(with request: AddProductRequest) throws -> Product {
    return try diskDataSource.add(with: request)
  }
}
