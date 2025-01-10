//
//  TodoActionView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 09/01/2025.
//

import SwiftUI

enum TodoAction {
    case add, remove, markAsComplete

    var imageName: String {
        switch self {
        case .add: return "plus.circle.fill"
        case .remove: return "trash.slash.circle.fill"
        case .markAsComplete: return "largecircle.fill.circle"
        }
    }

    var name: String {
        switch self {
        case .add: return "added"
        case .remove: return "removed"
        case .markAsComplete: return "completed"
        }
    }
}

struct TodoActionView: View {
    let action: TodoAction
    let title: String

    var body: some View {
        HStack {
            Image(systemName: action.imageName)
                .imageScale(.large)
                .font(.largeTitle)
            Text("'\(title)' \(action.name).")
                .font(.title2)
        }
        .padding()
    }
}

#Preview("Add", traits: .sizeThatFitsLayout) {
    TodoActionView(
        action: .add,
        title: Todo.mocks.first!.title
    )
}

#Preview("Remove", traits: .sizeThatFitsLayout) {
    TodoActionView(
        action: .remove,
        title: Todo.mocks.first!.title
    )
}

#Preview("Mark as Complete", traits: .sizeThatFitsLayout) {
    TodoActionView(
        action: .markAsComplete,
        title: Todo.mocks.first!.title
    )
}
