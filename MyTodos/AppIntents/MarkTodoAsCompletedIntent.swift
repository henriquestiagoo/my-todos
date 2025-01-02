//
//  MarkTodoAsCompletedIntent.swift
//  MyTodos
//
//  Created by Tiago Henriques on 02/01/2025.
//

import AppIntents
import SwiftData

struct MarkTodoAsCompletedIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Mark Todo as completed")
    static var description: IntentDescription? = IntentDescription("Select the todo to mark as completed from the list of todos")

    @Parameter(title: "Todo")
    var nameEntity: TodoEntity?

    func perform() async throws -> some ProvidesDialog {
        let suggestedEntities = try await suggestedEntities()
        if suggestedEntities.isEmpty {
            return .result(dialog: "You don't have items to mark as completed.")
        } else {
            let entityToUpdate = try await $nameEntity.requestDisambiguation(
                among: suggestedEntities,
                dialog: IntentDialog("Select the todo you wish to mark as completed:")
            )
            // mark todo as completed
            try await markAsCompleted(name: entityToUpdate.id)
            return .result(dialog: "Todo '\(entityToUpdate.id)' marked as completed.")
        }
    }

    @MainActor
    func markAsCompleted(name: String) async throws {
        let todosManager = TodosManager(context: MyTodosApp.container.mainContext)
        let foundTodos = try await todosManager.getTodos(with: name)
        guard let todo = foundTodos.first else { return }
        try? await todosManager.markAsCompleted(todo: todo)
    }

    @MainActor
    func suggestedEntities() async throws -> [TodoEntity] {
        let todosManager = TodosManager(context: MyTodosApp.container.mainContext)
        let allTodos = try await todosManager.getNotCompletedTodos()
        let allEntities = allTodos.map { todo in
            TodoEntity(id: todo.name)
        }
        return allEntities
    }
}
