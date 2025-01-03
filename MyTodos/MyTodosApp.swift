//
//  MyTodosApp.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import SwiftUI
import SwiftData

@main
struct MyTodosApp: App {

    static var container: ModelContainer = {
        try! ModelContainer(for: Todo.self)
    }()

    init() {
        // go and find all of the shortcuts that are required
        MyTodosShortcuts.updateAppShortcutParameters()
    }

    var body: some Scene {
        WindowGroup {
            TodosListView()
        }
        .modelContainer(Self.container)
    }
}
