import FluentProvider

final class ImageDiskModel: Model {
  
  let storage = Storage()
  
  init(row: Row) throws {}
  
  func makeRow() throws -> Row {
    return Row()
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
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}
