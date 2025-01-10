//
//  TodoRowView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 07/01/2025.
//

import SwiftUI

struct TodoRowView: View {
    @Environment(\.modelContext) var context
    let todo: Todo

    var body: some View {
        HStack {
            Image(systemName: todo.isCompleted ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    todo.toggleCompleted()
                    try? context.save()
                }
            Text(todo.title)
                .opacity(todo.isCompleted ? 0.6 : 1)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TodoRowView(todo: Todo.mocks.first!)
}
