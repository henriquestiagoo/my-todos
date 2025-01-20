//
//  ConfigurableUpdateTodoIntent.swift
//  MyTodosWidgetExtension
//
//  Created by Tiago Henriques on 10/01/2025.
//

import AppIntents
import WidgetKit

struct ConfigurableUpdateIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Update Todo")
    static var description: IntentDescription? = IntentDescription("Tap the todo to toggle its completion status")

    @Parameter(title: "Todo")
    var title: String

    init() {}

    init(title: String) {
        self.title = title
    }

    func perform() async throws -> some IntentResult {
        let update = try await updateTodo(title: title)
        return .result(value: update)
    }

    @MainActor
    func updateTodo(title: String) async throws -> Bool {
        let todosManager = TodosManager(context: Shared.container.mainContext)
        let foundTodos = try await todosManager.getTodos(with: title)
        guard let todo = foundTodos.first else { return false }
        try? await todosManager.toggleCompleted(todo: todo)
        // reload widgets
        WidgetCenter.shared.reloadAllTimelines()
        return todo.isCompleted
    }
}
