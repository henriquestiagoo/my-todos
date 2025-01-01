//
//  AddTodoIntent.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import AppIntents

struct AddTodoIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource(stringLiteral: "Add item to todos list")
    static var description: IntentDescription? = IntentDescription(stringLiteral: "Add an item to todos list")

    @Parameter(title: "Todo name")
    var todoName: String?

    func perform() async throws -> some ProvidesDialog {
        guard let todoName else {
            let dialog = IntentDialog("What todo item you would like to add?")
            throw $todoName.needsValueError(dialog)
        }

        let newTodo = Todo(name: todoName)
        do {
            try await insert(todo: newTodo)
            let dialog = IntentDialog("'\(todoName)' is added to your todos list.")
            return .result(dialog: dialog)
        } catch {
            throw error
        }
    }

    @MainActor
    func insert(todo: Todo) async throws {
        let todosManager = TodosManager(context: MyTodosApp.container.mainContext)
        try await todosManager.insert(todo: todo)
    }
}
