import HTTP
import CoreService
import Foundation

private struct Parameter {
  static let gameId = "game_id"
  static let gameConsoleId = "game_console_id"
  static let description = "description"
  static let imageIds = "image_ids"
  
  struct Price {
    static let root = "price"
    static let value = "value"
    static let currencyLocale = "currency_locale"
  }
}

struct ProductController {
  
  func addProduct(with request: Request) throws -> ResponseRepresentable {
    guard let json = request.json else {
      return Response.missingParameters
    }
    guard let gameId = json[Parameter.gameId]?.string,
      let gameConsoleId = json[Parameter.gameConsoleId]?.string,
      let description = json[Parameter.description]?.string,
      let imageIds = json[Parameter.imageIds]?.array,
      let productPrice = json[Parameter.Price.root]?.object,
      let priceValue = productPrice[Parameter.Price.value]?.double,
      let priceCurrencyLocale = productPrice[Parameter.Price.currencyLocale]?.string,
      !description.trim().isEmpty, !imageIds.isEmpty else {
        return Response.missingParameters
    }
    
    let price = Price(
      value: priceValue,
      locale: Locale(identifier: priceCurrencyLocale)
    )
    let images = imageIds.flatMap { $0.string }

    let addProductRequest = AddProductRequest(
      gameId: gameId,
      gameConsoleId: gameConsoleId,
      description: description,
      imageIds: images,
      price: price
    )
    
    return "{add product request: \(addProductRequest)}"
  }
}
