//
//  TodosEmptyView.swift
//  MyTodos
//
//  Created by Tiago Henriques on 07/01/2025.
//

import SwiftUI

struct TodosEmptyView: View {
    var body: some View {
        Text("You don't have items to mark as completed.")
            .font(.title2)
            .padding()
    }
}

#Preview {
    TodosEmptyView()
}
