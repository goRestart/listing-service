import FluentProvider

final class PriceDiskModel: Model {
  
  let storage = Storage()
  
  var value: Double
  var locale: String
  
  init(value: Double, locale: String) {
    self.value = value
    self.locale = locale
  }
  
  init(row: Row) throws {
    value = try row.get(Keys.value)
    locale = try row.get(Keys.locale)
  }
  
  func makeRow() throws -> Row {
    var row = Row()
    try row.set(Keys.value, value)
    try row.set(Keys.locale, locale)
    return row
  }
  
  // MARK: - Database keys
  
  struct Keys {
    static let value = "value"
    static let locale = "locale"
  }
}

// MARK: - Customizations

extension PriceDiskModel: Timestampable {
  static let name = "price"
  static let entity = "prices"
}

// MARK: - Preparations

extension PriceDiskModel: Preparation {
  static func prepare(_ database: Database) throws {
    try database.create(PriceDiskModel.self) { builder in
      builder.id()
      builder.double(Keys.value, optional: false)
      builder.string(Keys.locale, optional: false)
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}
