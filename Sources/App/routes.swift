import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    try app.register(collection: EventController())
    try app.register(collection: OrganizerController())
    try app.register(collection: RenterController())
}
