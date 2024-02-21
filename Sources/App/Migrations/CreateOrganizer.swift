import FluentPostgresDriver
import Fluent
import Foundation

struct CreateOrganizerTableMigration : Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("organizer")
        
            .id()
            .field("name", .string)
            .field("ContactInfo", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("organizer")
            .delete()
    }
}

