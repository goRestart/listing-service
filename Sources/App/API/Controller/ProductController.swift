import HTTP
import CoreService

struct ProductController {
  
  private let addProduct: AddProduct
  
  init(addProduct: AddProduct) {
    self.addProduct = addProduct
  }
  
  func addProduct(with request: Request) throws -> ResponseRepresentable {
    do {
      let addProductRequest = try request.extract()
      return try addProduct
        .execute(with: addProductRequest)
        .makeResponse(status: .created)
    } catch AddProductRequestError.missingParameters {
      return Response.missingParameters
    } catch ProductError.invalidGameConsoleId {
      return Response.invalidGameConsoleId
    } catch ProductError.invalidGameId {
      return Response.invalidGameId
    }
  }
}
