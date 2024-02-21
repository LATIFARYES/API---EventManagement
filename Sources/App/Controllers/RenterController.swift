import Fluent
import Vapor


struct RenterController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let renter = routes.grouped("renter")
        renter.post(use: createRenter)
        renter.get(":id", use: getRenter)
        renter.put(":id", use: updateRenter)
        renter.delete(":id", use: deleteRenter)
        renter.get(use: index)
        
    }
    //Get all
    func index(req:Request) async throws -> [Renter]
    {
        return try await Renter.query(on: req.db).all()
    }
    //Create
    func createRenter(req: Request) throws -> EventLoopFuture <Renter>{
        let renter = try req.content.decode(Renter.self)
        return renter.create(on: req.db).map {renter}
    }
    // Read by id
    func getRenter(req: Request) throws -> EventLoopFuture <Renter>{
        guard let RenterID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        return Renter.find(RenterID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    //Update by id
    func updateRenter(req: Request) throws -> EventLoopFuture <Renter>{
        guard let RenterID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        let updateRenter = try req.content.decode(Renter.self)
        return Renter.find(RenterID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { renter -> EventLoopFuture <Renter> in
                renter.name = updateRenter.name
                return renter.save(on: req.db).map {renter}
    }
    }
    
    //Delete by id
    func deleteRenter(req: Request) throws -> EventLoopFuture <HTTPStatus>{
        guard let RenterID = req.parameters.get("id", as: UUID.self) else {
            throw Abort (.badRequest)
        }
        return Renter.find(RenterID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { renter in
                return renter.delete(on: req.db)
                        }
            .transform(to: HTTPStatus.noContent)
    }
    
}
