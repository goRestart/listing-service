import HTTP

extension Response {
  static let invalidGameId = try! Response.error(
    status: .notFound,
    message: "Invalid game id",
    identifier: "game.error.invalid_game_id"
  )
}
