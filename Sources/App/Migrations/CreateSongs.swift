//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 18/02/24.
//

import Foundation
import Fluent

struct CreateSongs: AsyncMigration{
    
    
    func prepare(on database: FluentKit.Database) async throws {
        return try await database.schema("Songs")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        return try await database.schema("Songs")
            .delete()
    }
    
//    func prepare(on database: FluentKit.Database) -> EventLoopFuture<Void> {
//        return database.schema("Songs")
//            .id()
//            .field("title", .string, .required)
//            .create()
//    }
//    
//    func revert(on database: FluentKit.Database) -> EventLoopFuture<Void> {
//        return database.schema("Songs")
//            .delete()
//    }
    
    
}
