//
//  NewTodoView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import SwiftUI
import SwiftData

struct NewTodoView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var todos: [Todo]
    @State private var name: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)

                Button("Add") {
                    let newTodo = Todo(name: name)
                    context.insert(newTodo)
                    try? context.save()
                    dismiss()
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty || todos.map { $0.name }.contains(name))

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
