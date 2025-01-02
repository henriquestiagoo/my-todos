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
            ZStack {
                if todos.isEmpty {
                    ContentUnavailableView(
                        "Create your First Todo",
                        systemImage: "plus.circle.fill"
                    )

                } else {
                    List(todos) { todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "largecircle.fill.circle" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    todo.toggleCompleted()
                                    try? context.save()
                                }
                            Text(todo.name)
                                .opacity(todo.isCompleted ? 0.6 : 1)
                        }
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
