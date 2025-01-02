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
    var id: UUID
    var name: String
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        name: String,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
    }

    func toggleCompleted() {
        self.isCompleted.toggle()
    }

    func markAsCompleted() {
        self.isCompleted = true
    }
}

extension Todo {
    static var mocks: [Todo] = [
        Todo(name: "Implement Todos App", isCompleted: true),
        Todo(name: "Introduced AppIntents", isCompleted: true),
        Todo(name: "Write article")
    ]
}
