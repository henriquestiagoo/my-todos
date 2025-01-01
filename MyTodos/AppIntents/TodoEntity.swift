//
//  TodoEntity.swift
//  MyTodos
//
//  Created by Tiago Henriques on 01/01/2025.
//

import AppIntents

struct TodoEntity: AppEntity {
    var id: String
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(name: "Selected Todo")
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    static var defaultQuery = TodoQuery()
}
