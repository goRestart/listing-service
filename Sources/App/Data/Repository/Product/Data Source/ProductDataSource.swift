import Foundation

protocol ProductDataSource {
  func add(with request: AddProductRequest) throws -> Product
}
