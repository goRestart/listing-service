import CoreService

struct ProductMapper: Mappable {
  
  private let priceMapper: PriceMapper
  private let imageMapper: ImageMapper
  
  init(priceMapper: PriceMapper,
       imageMapper: ImageMapper)
  {
    self.priceMapper = priceMapper
    self.imageMapper = imageMapper
  }
  
  func map(_ from: ProductDiskModel) throws -> Product {
    let price = try priceMapper.map(from.prices.all().last!)
    let images = try imageMapper.map(elements: from.images.all())
    
    return Product(
      id: Identifier(from.id!.string!),
      title: from.title,
      description: from.description,
      price: price,
      images: images,
      createdAt: from.createdAt!,
      updatedAt: from.updatedAt!
    )
  }
}
