//
//  TodoQuery.swift
//  MyTodos
//
//  Created by Tiago Henriques on 01/01/2025.
//

import AppIntents
import SwiftData

struct TodoQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [TodoEntity] {
        try await suggestedEntities().filter({ identifiers.contains($0.id) })
    }

    @MainActor
    func suggestedEntities() async throws -> [TodoEntity] {
        let container = try! ModelContainer(for: Todo.self)
        let sort = [SortDescriptor(\Todo.title)]
        let descriptor = FetchDescriptor<Todo>(sortBy: sort)
        let allTodos = try? container.mainContext.fetch(descriptor)
        let allEntities = allTodos?.map { todo in
            TodoEntity(id: todo.title)
        }
        return allEntities ?? []
    }
}

extension TodoQuery {
    func defaultResult() async -> TodoEntity? {
        try? await suggestedEntities().first
    }
}
