import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(
        DatabaseConfigurationFactory.postgres(
            configuration: .init(
                hostname: Environment.get("dpg-cndht56n7f5s73ble00g-a") ?? "localhost",
                port: Environment.get("5432").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
                username: Environment.get("yt_vapor_database_user") ?? "vapor_username",
                password: Environment.get("YCsLsZPlr320gf7BlR1b8maok67JvKk2") ?? "vapor_password",
                database: Environment.get("yt_vapor_database") ?? "vapor_database",
                tls: .prefer(try .init(configuration: .clientDefault)))),
        as: .psql
    )

    app.migrations.add(CreateSongs())
    //try await app.autoMigrate()

    // register routes
    try routes(app)
}
