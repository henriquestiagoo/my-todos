//
//  Shared.swift
//  MyTodos
//
//  Created by Tiago Henriques on 20/01/2025.
//

import Foundation
import SwiftData

struct Shared {
    static var container: ModelContainer = {
        try! ModelContainer(for: Todo.self)
    }()
}
