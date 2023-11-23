//
//  Todo.swift
//  TODO3
//
//  Created by Dimitri Liauw on 23/11/2023.
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: UUID?
    var name: String
    var isTicked: Bool
}


