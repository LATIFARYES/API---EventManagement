import Vapor
import Fluent


struct OrganizerController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let organizer = routes.grouped("organizer")
        
        organizer.post(use: createOranizer)
        organizer.get(use: getOranizer)
        organizer.put(":id", use: updateOrganizer)
        organizer.delete(":id", use: deleteOrganizer)
        organizer.get(use: index)
        
    }
    //Get all
    func index(req:Request) async throws -> [Organizer]
    {
        return try await Organizer.query(on: req.db).all()
    }
    
    //Create
    func createOranizer(req: Request) async throws -> Organizer{
        let newOrganizer = try req.content.decode(Organizer.self)
        try await newOrganizer.create(on: req.db)
        return newOrganizer
    }
    
    // Read by id
    func getOranizer(req: Request) throws -> EventLoopFuture <Organizer>{
        guard let OrganizerID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        return Organizer.find(OrganizerID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // Update by id
    func updateOrganizer(req: Request) async throws -> Organizer{
        let newOrganizer = try req.content.decode(Organizer.self)
        guard let organizerInDB = try await Organizer.find(newOrganizer.id, on: req.db) else{
            throw Abort (.notFound)
        }
        organizerInDB.name = newOrganizer.name
        try await organizerInDB.save(on: req.db)
        return newOrganizer
    }
    
    //Delete by id
    func deleteOrganizer(req: Request)  throws -> EventLoopFuture <HTTPStatus>{
        guard let OrganizerID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        return Organizer.find(OrganizerID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { organizer in
                return organizer.delete(on: req.db)
                        }
            .transform(to: HTTPStatus.noContent)
    }
    
    
}
