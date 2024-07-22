//
//  Todo.swift
//
//
//  Created by Dimitri Liauw on 23/11/2023.
//

import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "isTicked")
    var isTicked: Bool
    
    init () {}
    
    init(id: UUID? = nil, name: String, isTicked: Bool)  {
        self.id = id
        self.name = name
        self.isTicked = isTicked
    }
}
