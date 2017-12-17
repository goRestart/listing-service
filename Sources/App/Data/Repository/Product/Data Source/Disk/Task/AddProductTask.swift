import Foundation
import Fluent
import CoreService
import game_service_api
import image_service_api

private let defaultCurrencyCode = "EUR"

struct AddProductTask {
  
  private let getGameById: GetGameById
  private let getGameConsoleById: GetGameConsoleById
  private let getImagesByIds: GetImagesByIds
  
  init(getGameById: GetGameById,
       getGameConsoleById: GetGameConsoleById,
       getImagesByIds: GetImagesByIds)
  {
    self.getGameById = getGameById
    self.getGameConsoleById = getGameConsoleById
    self.getImagesByIds = getImagesByIds
  }
  
  func execute(with request: AddProductRequest) throws -> ProductDiskModel {
    guard let game = try getGameById.execute(with: Identifier(request.gameId)) else {
      throw ProductError.invalidGameId
    }

    guard let _ = try getGameConsoleById.execute(with: Identifier(request.gameConsoleId)) else {
      throw ProductError.invalidGameConsoleId
    }
 
    let product: ProductDiskModel = try TransactionHandler.database!.transaction { connection in
      let product = ProductDiskModel(
        title: game.name,
        description: request.description,
        userId: request.userId
      )
      try product.makeQuery(connection).save()
      return product
    }
    try add(request.price, to: product)
    try add(images: request.imageIds, to: product)
    return product
  }
  
  private func add(_ price: Price, to product: ProductDiskModel) throws {
    let priceDiskModel = PriceDiskModel(
      value: price.value,
      locale: price.locale.currencyCode ?? defaultCurrencyCode
    )
    try priceDiskModel.save()
    try product.prices.add(priceDiskModel)
  }
  
  private func add(images: [String], to product: ProductDiskModel) throws {
    let imageIds = images.map { CoreService.Identifier<image_service_api.Image>($0) }
    let images = try getImagesByIds.execute(with: imageIds)
    
    try images?.forEach { element in
      let image = ImageDiskModel(
        identifier: Fluent.Identifier(element.id.value),
        url: element.url
      )
      try image.save()
      try product.images.add(image)
    }
  }
}
