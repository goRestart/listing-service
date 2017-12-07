import CoreService
import Foundation

struct PriceMapper: Mappable {
  func map(_ from: PriceDiskModel) throws -> Price {
    return Price(
      value: from.value,
      locale: Locale(identifier: from.locale)
    )
  }
}
