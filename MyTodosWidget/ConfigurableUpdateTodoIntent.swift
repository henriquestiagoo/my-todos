//
//  ConfigurableUpdateTodoIntent.swift
//  MyTodosWidgetExtension
//
//  Created by Tiago Henriques on 10/01/2025.
//

import AppIntents
import SwiftData
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
        let update = await updateTodo(title: title)
        return .result(value: update)
    }

    @MainActor
    func updateTodo(title: String) -> Bool {
        let container = try! ModelContainer(for: Todo.self)
        let predicate = #Predicate<Todo> { $0.title == title }
        let descriptor = FetchDescriptor<Todo>(predicate: predicate)
        let foundTodos = try? container.mainContext.fetch(descriptor)
        if let todo = foundTodos?.first {
            todo.toggleCompleted()
            try? container.mainContext.save()
            // reload widgets
            WidgetCenter.shared.reloadAllTimelines()
            return todo.isCompleted
        }
        return false
    }
}
