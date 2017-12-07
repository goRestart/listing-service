import CoreService

struct ProductMapper: Mappable {
  
  private let priceMapper: PriceMapper
  
  init(priceMapper: PriceMapper) {
    self.priceMapper = priceMapper
  }
  
  func map(_ from: ProductDiskModel) throws -> Product {
    let price = try priceMapper.map(from.price)
    return Product(
      id: Identifier(from.id!.string!),
      title: from.title,
      description: from.description,
      price: price,
      images: [],
      createdAt: from.createdAt!,
      updatedAt: from.updatedAt!
    )
  }
}
