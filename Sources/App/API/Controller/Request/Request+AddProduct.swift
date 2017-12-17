import Vapor
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

extension Request {
  func extract() throws -> AddProductRequest {
    guard let json = json else {
      throw AddProductRequestError.missingParameters
    }
    
    guard let gameId = json[Parameter.gameId]?.string,
      let gameConsoleId = json[Parameter.gameConsoleId]?.string,
      let description = json[Parameter.description]?.string,
      let imageIds = json[Parameter.imageIds]?.array,
      let productPrice = json[Parameter.Price.root]?.object,
      let priceValue = productPrice[Parameter.Price.value]?.double,
      let priceCurrencyLocale = productPrice[Parameter.Price.currencyLocale]?.string,
      !description.trim().isEmpty, !imageIds.isEmpty else
    {
      throw AddProductRequestError.missingParameters
    }
    
    let price = Price(
      value: priceValue,
      locale: Locale(identifier: priceCurrencyLocale)
    )
    let images = imageIds.flatMap { $0.string }
    
    return AddProductRequest(
      userId: "User ID", // TODO: Extract user id from JWT token
      gameId: gameId,
      gameConsoleId: gameConsoleId,
      description: description,
      imageIds: images,
      price: price
    )
  }
}
