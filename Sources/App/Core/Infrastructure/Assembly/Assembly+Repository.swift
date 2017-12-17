import CoreService

extension Assembly {
  var productRepository: ProductRepository {
    return ProductRepository(
      diskDataSource: diskDataSource
    )
  }
  
  private var diskDataSource: ProductDiskDataSource {
    return ProductDiskDataSource(
      addProductTask: addProductTask,
      productMapper: productMapper
    )
  }
}
