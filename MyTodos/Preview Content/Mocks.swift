//
//  Mocks.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import SwiftData
import SwiftUI

struct Mocks: PreviewModifier {

    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }

    static func makeSharedContext() async throws -> ModelContainer {
        let container = try! ModelContainer(
            for: Todo.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )

        // Insert objects here
        Todo.mocks.forEach { todo in
            container.mainContext.insert(todo)
        }

        return container
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mocks: Self = .modifier(Mocks())
}
