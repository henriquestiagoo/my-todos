//
//  TodosListView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import SwiftUI
import SwiftData

struct TodosListView: View {
    @Query(sort: \Todo.name) var todos: [Todo]
    @Environment(\.modelContext) var context
    @State private var isNewTodoSheetPresented: Bool = false

    var body: some View {
        NavigationStack {
            Group {
                if todos.isEmpty {
                    ContentUnavailableView(
                        "Create your First Todo",
                        systemImage: "plus.circle.fill"
                    )

                } else {
                    List(todos) { todo in
                        Text(todo.name)
                            .swipeActions {
                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    context.delete(todo)
                                    try? context.save()
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
