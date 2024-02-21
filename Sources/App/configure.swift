import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.postgres(hostname: "localhost" ,
                                username: "postgres" ,
                                password: "" ,
                                database: "eventsdb")
                      , as: .psql)
    
    
    //Migrations
    app.migrations.add(CreateEventTableMigration())
    app.migrations.add(CreateOrganizerTableMigration())
    app.migrations.add(CreateRenterTableMigration())
    try await app.autoMigrate()
    
    // register routes
    try routes(app)
    
}
