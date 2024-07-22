//
//  TodoController.swift
//
//
//  Created by Dimitri Liauw on 23/11/2023.
//

import Fluent
import Vapor

struct TodoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: retrieve)
        todos.post(use: create)
        todos.put(use: update)
        todos.group(":todoID") { song in
            song.delete(use: delete)
        }
    }
    
    // GET REQUEST /todos route
    func retrieve(req: Request) throws -> EventLoopFuture<[Todo]> {
        return Todo.query(on: req.db).all()
    }
    
    // POST REQUEST /todos route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let todo = try req.content.decode(Todo.self)
        return todo.save(on: req.db).transform(to: .ok)
    }
    
    // PUT REQUEST /todos route
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let todo = try req.content.decode(Todo.self)
        
        return Todo.find(todo.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.isTicked = todo.isTicked
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // DEL REQUEST /todos/id route
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
