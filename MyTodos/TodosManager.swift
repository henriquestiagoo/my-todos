//
//  TodosManager.swift
//  MyTodos
//
//  Created by Tiago Henriques on 30/12/2024.
//

import Foundation
import SwiftData

class TodosManager {
    private let context: ModelContext

    public init(context: ModelContext) {
        self.context = context
    }

    func getTodos() async throws -> [Todo] {
        let sort = [SortDescriptor(\Todo.name)]
        let descriptor = FetchDescriptor<Todo>(sortBy: sort)
        return try context.fetch(descriptor)
    }

    func getTodos(with name: String) async throws -> [Todo] {
        let predicate = #Predicate<Todo> { $0.name == name }
        let descriptor = FetchDescriptor(predicate: predicate)
        return try context.fetch(descriptor)
    }

    func getNotCompletedTodos() async throws -> [Todo] {
        let predicate = #Predicate<Todo> { !$0.isCompleted }
        let descriptor = FetchDescriptor(predicate: predicate)
        return try context.fetch(descriptor)
    }

    func insert(todo: Todo) async throws {
        context.insert(todo)
        try context.save()
    }

    func remove(todo: Todo) async throws {
        context.delete(todo)
        try context.save()
    }

    func markAsCompleted(todo: Todo) async throws {
        todo.markAsCompleted()
        try context.save()
    }
}
