//
//  MyTodosApp.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import SwiftUI

@main
struct MyTodosApp: App {

    init() {
        // go and find all of the shortcuts that are required
        MyTodosShortcuts.updateAppShortcutParameters()
    }

    var body: some Scene {
        WindowGroup {
            TodosListView()
        }
        .modelContainer(Shared.container)
    }
}
