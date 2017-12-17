import FluentProvider

final class ImageDiskModel: Model {
  
  let storage = Storage()
  
  var url: String
  
  init(identifier: Identifier, url: String) {
    self.url = url
    self.id = identifier
  }
  
  init(row: Row) throws {
    url = try row.get(Keys.url)
  }

  func makeRow() throws -> Row {
    var row = Row()
    try row.set(Keys.url, url)
    return row
  }
  
  // MARK: - Database keys
  
  struct Keys {
    static let url = "url"
  }
}

// MARK: - Customizations

extension ImageDiskModel: Timestampable {
  static let name = "image"
  static let entity = "images"
}

// MARK: - Preparations

extension ImageDiskModel: Preparation {
  static func prepare(_ database: Database) throws {
    try database.create(ImageDiskModel.self) { builder in
      builder.id()
      builder.string(Keys.url)
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}
