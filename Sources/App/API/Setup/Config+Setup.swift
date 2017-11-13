import FluentProvider

extension Config {
  public func setup() throws {
    Node.fuzzy = [Row.self, JSON.self, Node.self]

    try setupProviders()
    try setupPreparations()
  }
  
  // MARK: - Providers
  
  private func setupProviders() throws {
    try addProvider(FluentProvider.Provider.self)
  }
  
  // MARK: - Preparations
  
  private func setupPreparations() throws {
    preparations = []
  }
}
