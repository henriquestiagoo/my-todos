//
//  NewTodoView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import SwiftUI
import SwiftData
import WidgetKit

struct NewTodoView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var todos: [Todo]
    @State private var title: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)

                Button("Add") {
                    let newTodo = Todo(title: title)
                    context.insert(newTodo)
                    try? context.save()
                    // reload widgets
                    WidgetCenter.shared.reloadAllTimelines()
                    dismiss()
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(title.isEmpty || todos.map { $0.title }.contains(title))

                Spacer()
            }
            .padding()
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
    }
}

#Preview {
    NewTodoView()
}
