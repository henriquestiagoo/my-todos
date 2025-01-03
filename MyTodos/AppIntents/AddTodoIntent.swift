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

    @Parameter(title: "Todo title")
    var todoTitle: String?

    func perform() async throws -> some ProvidesDialog {
        guard let todoTitle else {
            let dialog = IntentDialog("What todo item you would like to add?")
            throw $todoTitle.needsValueError(dialog)
        }

        let newTodo = Todo(title: todoTitle)
        do {
            try await insert(todo: newTodo)
            let dialog = IntentDialog("'\(todoTitle)' was added to your todos list.")
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
