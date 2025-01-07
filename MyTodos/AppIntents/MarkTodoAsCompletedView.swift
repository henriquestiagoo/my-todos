//
//  MarkTodoAsCompletedView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 07/01/2025.
//

import SwiftUI

struct MarkTodoAsCompletedView: View {
    let title: String

    var body: some View {
        HStack {
            Image(systemName: "largecircle.fill.circle")
                .imageScale(.large)
                .font(.largeTitle)
            Text("'\(title)' completed.")
                .font(.title2)
        }
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MarkTodoAsCompletedView(title: Todo.mocks.first!.title)
}
