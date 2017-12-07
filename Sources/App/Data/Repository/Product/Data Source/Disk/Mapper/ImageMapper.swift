import CoreService

struct ImageMapper: Mappable {
  func map(_ from: ImageDiskModel) throws -> Image {
    return Image(
      id: Identifier(from.id!.string!),
      url: from.url
    )
  }
}
