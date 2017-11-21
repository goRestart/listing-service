import FluentProvider

final class ProductDiskModel: Model {
  
  let storage = Storage()
  
  var title: String
  var description: String
  var priceId: Identifier
  
  init(title: String, description: String, priceId: Identifier) {
    self.title = title
    self.description = description
    self.priceId = priceId
  }
  
  init(row: Row) throws {
    title = try row.get(Keys.title)
    description = try row.get(Keys.description)
    priceId = try row.get(Keys.priceId)
  }
  
  func makeRow() throws -> Row {
    var row = Row()
    try row.set(Keys.title, title)
    try row.set(Keys.description, description)
    try row.set(Keys.priceId, priceId)
    return row
  }
  
  // MARK: - Database keys
  
  struct Keys {
    static let title = "title"
    static let description = "description"
    static let priceId = "price_id"
  }
}

// MARK: - Relations

extension ProductDiskModel {
  var price: PriceDiskModel {
    return try! parent(id: priceId).get()!
  }
  
  var imageIds: Siblings<ProductDiskModel, ImageDiskModel, Pivot<ProductDiskModel, ImageDiskModel>> {
    return siblings()
  }
}

// MARK: - Customizations

extension ProductDiskModel: Timestampable {
  static let name = "product"
  static let entity = "products"
}

// MARK: - Preparations

extension ProductDiskModel: Preparation {
  static func prepare(_ database: Database) throws {
    try database.create(ProductDiskModel.self) { builder in
      builder.id()
      builder.string(Keys.title, optional: false)
      builder.text(Keys.description, optional: false)
      builder.parent(PriceDiskModel.self, optional: false, foreignIdKey: Keys.priceId)
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}
