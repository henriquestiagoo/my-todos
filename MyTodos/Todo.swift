//
//  Todo.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import Foundation
import SwiftData

@Model
class Todo {
    var name: String

    init(name: String) {
        self.name = name
    }
}

extension Todo {
    static var mocks: [Todo] = [
        Todo(name: "Implement Todos App"),
        Todo(name: "Write article")
    ]
}
