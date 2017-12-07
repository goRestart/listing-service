import CoreService
import game_service_api

extension Assembly {
  var addProductTask: AddProductTask {
    return AddProductTask(
      getGameById: getGameById,
      getGameConsoleById: getGameConsoleById
    )
  }
  
  private var getGameById: GetGameById {
    return GetGameById()
  }
  
  private var getGameConsoleById: GetGameConsoleById {
    return GetGameConsoleById()
  }
}
