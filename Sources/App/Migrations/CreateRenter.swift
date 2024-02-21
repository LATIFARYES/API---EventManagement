import FluentPostgresDriver
import Fluent
import Foundation

struct CreateRenterTableMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("renter")
            .id()
            .field("name", .string)
            .field("ContactInfo", .string)
            .field("Rented", .bool)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("renter")
            .delete()
    }
}

