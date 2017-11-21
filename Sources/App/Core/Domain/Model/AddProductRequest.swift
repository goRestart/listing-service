import CoreService

struct AddProductRequest {
  let gameId: String
  let gameConsoleId: String
  let description: String
  let imageIds: [String]
  let price: Price
}
