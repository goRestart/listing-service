import Foundation
import CoreService

struct Product {
  let identifier: Identifier<Product>
  let title: String
  let description: String
  let price: Price
  let images: [Image]
  let createdAt: Date
  let updatedAt: Date
}
