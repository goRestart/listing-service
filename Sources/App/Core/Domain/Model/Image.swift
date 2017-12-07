import Foundation
import CoreService

struct Image: Codable {
  let id: Identifier<Image>
  let url: URL
}
