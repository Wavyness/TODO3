//
//  TodoListView.swift
//  TODO3
//
//  Created by Dimitri Liauw on 22/11/2023.
//

import SwiftUI

struct TodoListView: View {
    @State var id: UUID?
    @State var name: String
    @State var isTicked: Bool
    var onDelete: (UUID?) async throws -> Void
    
    func updateTodo(todo: Todo) async throws {
        let urlString = Constants.baseURL + Endpoints.todos
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let todoUpdate = todo
        try await HttpClient.shared.sendData(to: url, object: todoUpdate, httpMethod: HttpMethods.PUT.rawValue)
    }
    
    var body: some View {
        HStack {
            Button {
                print("check/uncheck")
                withAnimation() {
                    isTicked.toggle()
                }
                let updatedTodo = Todo(id: id, name: name, isTicked: isTicked)
                Task {
                    try await updateTodo(todo: updatedTodo)
                }
            } label: {
                Image(systemName: isTicked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22, weight: .bold))
            }
            
            Text(name)
                .padding(.vertical, 8)
                .font(.system(size: 20, weight: .bold))
                .strikethrough(isTicked, color: .black)
        }
        .foregroundColor(isTicked ? .black.opacity(0.3) : .black)
        .swipeActions {
            Button {
                print("delete")
                Task {
                    try await onDelete(id)
                }
            } label: {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        .buttonStyle(.borderless) // assures that button works correctly (before you could press anywhere)
    }
}

#Preview {
    NavigationView {
        List {
            TodoListView(id: UUID(), name: "Visit booking.com", isTicked: false, onDelete: mockFunction)
            TodoListView(id: UUID(), name: "Make to-do app", isTicked: true, onDelete: mockFunction)
        }
    }
    .navigationTitle("Todos")
}

func mockFunction(id: UUID?) async throws {
    print("Nothing here")
}
