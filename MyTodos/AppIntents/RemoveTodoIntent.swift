//
//  RemoveTodoIntent.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import AppIntents
import SwiftData

struct RemoveTodoIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Remove Todo")
    static var description: IntentDescription? = IntentDescription("Select the todo to remove from the list of todos")

    @Parameter(title: "Todo")
    var nameEntity: TodoEntity?

    func perform() async throws -> some ProvidesDialog {
        let suggestedEntities = try await suggestedEntities()
        if suggestedEntities.isEmpty {
            return .result(dialog: "Your todos list is empty.")
        } else {
            let entityToRemove = try await $nameEntity.requestDisambiguation(
                among: suggestedEntities,
                dialog: IntentDialog("Select a todo to remove:")
            )
            // remove todo
            try await removeTodo(name: entityToRemove.id)
            return .result(dialog: "Removed '\(entityToRemove.id)' from the todos list.")
        }
    }

    @MainActor
    func removeTodo(name: String) async throws {
        let todosManager = TodosManager(context: MyTodosApp.container.mainContext)
        let foundTodos = try await todosManager.getTodos(with: name)
        guard let todo = foundTodos.first else { return }
        try? await todosManager.remove(todo: todo)
    }

    @MainActor
    func suggestedEntities() async throws -> [TodoEntity] {
        let todosManager = TodosManager(context: MyTodosApp.container.mainContext)
        let allTodos = try await todosManager.getTodos()
        let allEntities = allTodos.map { todo in
            TodoEntity(id: todo.name)
        }
        return allEntities
    }
}
