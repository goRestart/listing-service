import FluentProvider

final class ProductDiskModel: Model {
  
  let storage = Storage()
  
  var title: String
  var description: String
  var userId: String
  
  init(title: String,
       description: String,
       userId: String)
  {
    self.title = title
    self.description = description
    self.userId = userId
  }
  
  init(row: Row) throws {
    title = try row.get(Keys.title)
    description = try row.get(Keys.description)
    userId = try row.get(Keys.userId)
  }
  
  func makeRow() throws -> Row {
    var row = Row()
    try row.set(Keys.title, title)
    try row.set(Keys.description, description)
    try row.set(Keys.userId, userId)
    return row
  }
  
  // MARK: - Database keys
  
  struct Keys {
    static let title = "title"
    static let description = "description"
    static let userId = "user_id"
  }
}

// MARK: - Relations

extension ProductDiskModel {
  var prices: Siblings<ProductDiskModel, PriceDiskModel, Pivot<ProductDiskModel, PriceDiskModel>> {
    return siblings()
  }
  
  var images: Siblings<ProductDiskModel, ImageDiskModel, Pivot<ProductDiskModel, ImageDiskModel>> {
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
      builder.string(Keys.title)
      builder.text(Keys.description)
      builder.string(Keys.userId)
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}
