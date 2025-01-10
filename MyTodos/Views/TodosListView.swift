//
//  TodosListView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import SwiftUI
import SwiftData
import WidgetKit

struct TodosListView: View {
    @Query(sort: \Todo.title) var todos: [Todo]
    @Environment(\.modelContext) var context
    @State private var isNewTodoSheetPresented: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                if todos.isEmpty {
                    ContentUnavailableView(
                        "Create your First Todo",
                        systemImage: "plus.circle.fill"
                    )

                } else {
                    List(todos) { todo in
                        TodoRowView(todo: todo)
                            .swipeActions {
                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    context.delete(todo)
                                    try? context.save()
                                    // reload widgets
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
                            }
                    }
                }
            }
            .navigationTitle("My Todos")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        isNewTodoSheetPresented = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $isNewTodoSheetPresented) {
                NewTodoView()
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

#Preview(traits: .mocks) {
    TodosListView()
}
