//
//  CreateTodo.swift
//
//
//  Created by Dimitri Liauw on 23/11/2023.
//

import Fluent

struct CreateTodo: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("todos")
            .id()
            .field("name", .string, .required)
            .field("isTicked", .bool, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("todos").delete()
            
    }
    
    
}
