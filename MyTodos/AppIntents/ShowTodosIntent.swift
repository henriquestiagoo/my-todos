//
//  ShowTodosIntent.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import AppIntents

struct ShowTodosIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Show Todos")
    static var description: IntentDescription? = IntentDescription("Show all todos.")

    func perform() async throws -> some ProvidesDialog {
        let todos = try await getTodos()
        let dialogMessage = todos.isEmpty
                    ? "Your todos list is empty."
                    : "Here are your todos: \n\(todos.map(\.title).joined(separator: ", "))."
        return .result(dialog: IntentDialog(stringLiteral: dialogMessage))
    }

    @MainActor
    func getTodos() async throws -> [Todo] {
        let todosManager = TodosManager(context: Shared.container.mainContext)
        return try await todosManager.getTodos()
    }
}
