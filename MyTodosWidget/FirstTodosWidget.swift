//
//  MyTodosWidget.swift
//  MyTodosWidget
//
//  Created by Tiago Henriques on 10/01/2025.
//

import WidgetKit
import SwiftData
import SwiftUI

struct Provider: TimelineProvider {
    var container: ModelContainer = {
        try! ModelContainer(for: Todo.self)
    }()

    func placeholder(in context: Context) -> FirstTodosEntry {
        FirstTodosEntry(date: Date(), todos: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (FirstTodosEntry) -> ()) {
        let currentDate = Date.now
        Task {
            let allTodos = try await getTodos()
            let entry = FirstTodosEntry(date: currentDate, todos: allTodos)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        Task {
            let allTodos = try await getTodos()
            let entry = FirstTodosEntry(date: currentDate, todos: allTodos)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }

    @MainActor
    func getTodos() throws -> [Todo] {
        let sort = [SortDescriptor(\Todo.title)]
        let descriptor = FetchDescriptor<Todo>(sortBy: sort)
        let allTodos = try? container.mainContext.fetch(descriptor)
        return allTodos ?? []
    }
}

struct FirstTodosEntry: TimelineEntry {
    let date: Date
    let todos: [Todo]
}

struct FirstTodosWidgetEntryView : View {
    var entry: Provider.Entry

    private var todosPrefixIndex: Int {
        guard !entry.todos.isEmpty else { return 0 }
        return min(entry.todos.count, 3)
    }

    var body: some View {
        if entry.todos.isEmpty {
            ContentUnavailableView(
                "No todos yet",
                systemImage: "plus.circle.fill"
            )
        } else {
            // I could not make it work a List {} here, not sure why ... It doesn't compile my preview...
            VStack {
                HStack {
                    Text("My Todos")
                        .bold()
                    Spacer()
                }
                ForEach(0..<todosPrefixIndex, id: \.description) { index in
                    HStack {
                        Button(intent: ConfigurableUpdateIntent(title: entry.todos[index].title)) {
                            Image(systemName: entry.todos[index].isCompleted ? "largecircle.fill.circle" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .buttonStyle(.plain)
                        Text(entry.todos[index].title)
                            .font(.footnote)
                            .opacity(entry.todos[index].isCompleted ? 0.6 : 1)
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}

struct FirstTodosWidget: Widget {
    let kind: String = "FirstTodosWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FirstTodosWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("First Todos")
        .description("This Value of the first todos.")
        .supportedFamilies([.systemSmall])
//        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    FirstTodosWidget()
} timeline: {
//    FirstTodosEntry(date: .now, todos: [])
    FirstTodosEntry(date: .now, todos: Todo.mocks)
}
