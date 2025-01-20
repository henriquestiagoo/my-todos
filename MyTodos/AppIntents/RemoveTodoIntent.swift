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

    func perform() async throws -> some ShowsSnippetView {
        let suggestedEntities = try await suggestedEntities()
        if suggestedEntities.isEmpty {
            return await .result(view: TodosEmptyView())
        } else {
            let entityToRemove = try await $titleEntity.requestDisambiguation(
                among: suggestedEntities,
                dialog: IntentDialog("Select a todo to remove:")
            )
            // remove todo
            try await removeTodo(title: entityToRemove.id)
            return .result(view: TodoActionView(action: .remove, title: entityToRemove.id) )
        }
    }

    @MainActor
    func removeTodo(title: String) async throws {
        let todosManager = TodosManager(context: Shared.container.mainContext)
        let foundTodos = try await todosManager.getTodos(with: title)
        guard let todo = foundTodos.first else { return }
        try? await todosManager.remove(todo: todo)
    }

    @MainActor
    func suggestedEntities() async throws -> [TodoEntity] {
        let todosManager = TodosManager(context: Shared.container.mainContext)
        let allTodos = try await todosManager.getTodos()
        let allEntities = allTodos.map { todo in
            TodoEntity(id: todo.title)
        }
        return allEntities
    }
}
