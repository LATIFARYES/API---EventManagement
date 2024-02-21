import Fluent
import Vapor

struct EventController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
            let event = routes.grouped("event")
        event.post(use: createEvent)
        event.get(":id", use: getEvent)
        event.put(":id", use: updateEvent)
        event.delete(":id", use: deleteEvent)
        event.get(use: index)

        }
    
    //Get all
    func index(req:Request) async throws -> [Event]
    {
        return try await Event.query(on: req.db).all()
    }
    
    //Create
    func createEvent(req: Request) throws -> EventLoopFuture <Event>{
        let event = try req.content.decode(Event.self)
        return event.create(on: req.db).map {event}
    }
    
    //Read by id
    func getEvent(req: Request) throws -> EventLoopFuture <Event>{
        guard let EventID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        return Event.find(EventID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    //Update by id
    func updateEvent(req: Request) throws -> EventLoopFuture <Event>{
        guard let EventID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        let updateEvent = try req.content.decode(Event.self)
        return Event.find(EventID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event -> EventLoopFuture <Event> in
               event.title = updateEvent.title
                return event.save(on: req.db).map {event}
    }
}
    
    //Delete by id
    func deleteEvent(req: Request) throws -> EventLoopFuture <HTTPStatus>{
        guard let EventID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        return Event.find(EventID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                return event.delete(on: req.db)
                        }
            .transform(to: HTTPStatus.noContent)
    }
}
