import CoreService
import game_service_api
import Foundation

private let defaultCurrencyCode = "EUR"

struct AddProductTask {
  
  private let getGameById: GetGameById
  private let getGameConsoleById: GetGameConsoleById
  
  init(getGameById: GetGameById,
       getGameConsoleById: GetGameConsoleById)
  {
    self.getGameById = getGameById
    self.getGameConsoleById = getGameConsoleById
  }
  
  func execute(with request: AddProductRequest) throws -> ProductDiskModel {
    guard let game = try getGameById.execute(with: Identifier(request.gameId)) else {
      throw ProductError.invalidGameId
    }

    guard let _ = try getGameConsoleById.execute(with: Identifier(request.gameConsoleId)) else {
      throw ProductError.invalidGameConsoleId
    }
    
    return try TransactionHandler.database!.transaction { connection in
      let price = PriceDiskModel(
        value: request.price.value,
        locale: request.price.locale.currencyCode ?? defaultCurrencyCode
      )
      try price.makeQuery(connection).save()
      
      let product = ProductDiskModel(
        title: game.name,
        description: request.description,
        priceId: try price.assertExists()
      )
      try product.makeQuery(connection).save()
      return product
    }
  }
}
