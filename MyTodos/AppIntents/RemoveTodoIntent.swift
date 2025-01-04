//
//  RemoveTodoIntent.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import AppIntents

struct RemoveTodoIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Remove Todo")
    static var description: IntentDescription? = IntentDescription("Select the todo to remove from the list of todos")

    @Parameter(title: "Todo")
    var titleEntity: TodoEntity?

    func perform() async throws -> some ProvidesDialog {
        let suggestedEntities = try await suggestedEntities()
        if suggestedEntities.isEmpty {
            return .result(dialog: "Your todos list is empty.")
        } else {
            let entityToRemove = try await $titleEntity.requestDisambiguation(
                among: suggestedEntities,
                dialog: IntentDialog("Select a todo to remove:")
            )
            // remove todo
            try await removeTodo(title: entityToRemove.id)
            return .result(dialog: "Removed '\(entityToRemove.id)' from the todos list.")
        }
    }

    @MainActor
    func removeTodo(title: String) async throws {
        let todosManager = TodosManager(context: MyTodosApp.container.mainContext)
        let foundTodos = try await todosManager.getTodos(with: title)
        guard let todo = foundTodos.first else { return }
        try? await todosManager.remove(todo: todo)
    }

    @MainActor
    func suggestedEntities() async throws -> [TodoEntity] {
        let todosManager = TodosManager(context: MyTodosApp.container.mainContext)
        let allTodos = try await todosManager.getTodos()
        let allEntities = allTodos.map { todo in
            TodoEntity(id: todo.title)
        }
        return allEntities
    }
}
