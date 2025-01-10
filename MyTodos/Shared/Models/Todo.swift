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
    var title: String
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
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
        Todo(title: "Implement Todos App", isCompleted: true),
        Todo(title: "Introduced AppIntents", isCompleted: true),
        Todo(title: "Write article")
    ]
}
