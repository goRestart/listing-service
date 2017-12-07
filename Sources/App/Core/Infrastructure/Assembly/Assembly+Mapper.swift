import CoreService

extension Assembly {
  var productMapper: ProductMapper {
    return ProductMapper(
      priceMapper: priceMapper
    )
  }
  
  private var priceMapper: PriceMapper {
    return PriceMapper()
  }
}
