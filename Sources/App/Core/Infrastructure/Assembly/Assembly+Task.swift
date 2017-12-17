import CoreService
import game_service_api
import image_service_api

extension Assembly {
  var addProductTask: AddProductTask {
    return AddProductTask(
      getGameById: getGameById,
      getGameConsoleById: getGameConsoleById,
      getImagesByIds: getImagesByIds
    )
  }
  
  private var getGameById: GetGameById {
    return GetGameById()
  }
  
  private var getGameConsoleById: GetGameConsoleById {
    return GetGameConsoleById()
  }
  
  private var getImagesByIds: GetImagesByIds {
    return GetImagesByIds()
  }
}
