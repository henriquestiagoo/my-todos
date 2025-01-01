//
//  MyTodosShortcuts.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import AppIntents

struct MyTodosShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: ShowTodosIntent(),
            phrases: [
                "Show \(.applicationName)",
                "Show my \(.applicationName)",
                "Show \(.applicationName) items"
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "Show MyTodos"),
            systemImageName: "list.clipboard.fill"
        )

        AppShortcut(
            intent: AddTodoIntent(),
            phrases: [
                "Add an item to \(.applicationName)",
                "Add item to \(.applicationName)",
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "Add an item to todos list"),
            systemImageName: "plus.circle.fill"
        )

        AppShortcut(
            intent: RemoveTodoIntent(),
            phrases: [
                "Remove an item from \(.applicationName)",
                "Remove item from \(.applicationName)"
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "Remove an item from the todos list"),
            systemImageName: "minus.circle.fill"
        )
    }
}
