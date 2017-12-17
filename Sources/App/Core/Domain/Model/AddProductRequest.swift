import CoreService

struct AddProductRequest {
  let userId: String
  let gameId: String
  let gameConsoleId: String
  let description: String
  let imageIds: [String]
  let price: Price
}
