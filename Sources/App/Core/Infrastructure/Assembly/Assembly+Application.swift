import CoreService
import Vapor

extension Assembly {
  public func makeApplication(with config: Config = resolver.defaultConfig) -> Droplet {
    let droplet = try! Droplet(config)
    try! droplet.collection(productRouteCollection)
    return droplet
  }
  
  public var defaultConfig: Config {
    let config = try! Config()
    try! config.setup()
    return config
  }
}
