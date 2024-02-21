//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 18/02/24.
//

import Foundation
import Vapor
import Fluent

struct SongController: RouteCollection{
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let songs = routes.grouped("songs")
        songs.get(use: index)
        songs.post(use: create)
        songs.put(use: update)
        songs.delete(":songID",use: delete)
        
    }
    func index(req: Request) async throws -> [Song] {
        return try await Song.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        
        let song = try req.content.decode(Song.self)
        
        try await song.save(on: req.db)
        return .ok
    }
    
    func update(req: Request) async throws -> HTTPStatus {
        
        let newSong = try req.content.decode(Song.self)
        
        guard let songToUpdate = try await Song.find(newSong.id, on: req.db) else {
            throw Abort(.notFound)
        }
        songToUpdate.title = newSong.title
        try await songToUpdate.update(on: req.db)
        return .ok
        
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        
        guard let songToDelete = try await Song.find(req.parameters.get("songID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await songToDelete.delete(on: req.db)
        return .ok
        
    }
    
}
