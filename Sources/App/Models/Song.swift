//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 18/02/24.
//

import Foundation
import Vapor
import Fluent

final class Song: Model, Content{
    
    static let schema = "Songs"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title:String
    
    init(){}
    
    init(id: UUID?, title: String) {
        
        self.id = id
        self.title = title
        
    }
    
    
}

