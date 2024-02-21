import FluentPostgresDriver
import Fluent
import Foundation

struct CreateEventTableMigration: Migration {
    func prepare(on database: Database)  -> EventLoopFuture<Void> {
        return database.schema("event")
            .id()
            .field("title", .string)
            .field("date", .string)
            .field("location", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("event")
            .delete()
    }
}

