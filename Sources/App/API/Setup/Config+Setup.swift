import FluentProvider
import PostgreSQLProvider
import CoreService

extension Config {
  public func setup() throws {
    Node.fuzzy = [Row.self, JSON.self, Node.self]

    try setupProviders()
    try setupPreparations()
  }
  
  // MARK: - Providers
  
  private func setupProviders() throws {
    try addProvider(FluentProvider.Provider.self)
    try addProvider(PostgreSQLProvider.Provider.self)
  }
  
  // MARK: - Preparations
  
  private func setupPreparations() throws {
    preparations = [
      TransactionHandler.self,
      
      ImageDiskModel.self,
      PriceDiskModel.self,
      ProductDiskModel.self,
      
      Pivot<ProductDiskModel, ImageDiskModel>.self,
      Pivot<ProductDiskModel, PriceDiskModel>.self
    ]
  }
}
