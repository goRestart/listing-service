import CoreService

extension Assembly {
  var productMapper: ProductMapper {
    return ProductMapper(
      priceMapper: priceMapper,
      imageMapper: imageMapper
    )
  }
  
  private var priceMapper: PriceMapper {
    return PriceMapper()
  }
  
  private var imageMapper: ImageMapper {
    return ImageMapper()
  }
}
