//
//  ContentView.swift
//  TODO3
//
//  Created by Dimitri Liauw on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var todos = TodoListViewModel()
    
    @State var isShowingSheet: Bool = false
    
    func addItem(name: String) async throws {
        let urlString = Constants.baseURL + Endpoints.todos
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let todo = Todo(id: nil, name: name, isTicked: false)
        try await HttpClient.shared.sendData(to: url, object: todo, httpMethod: HttpMethods.POST.rawValue)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .cyan,
                    .black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // MARK: HEADER
                Text("Todo's")
                    .foregroundColor(.white)
                    .font(.system(size: 50, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.top, 30)
                    .shadow(radius: 2, x: 3, y: 5)
                
                // MARK: MAIN
                List {
                    ForEach(todos.todos) { todo in
                        ListItemView(
                            id: todo.id,
                            name: todo.name,
                            isTicked: todo.isTicked
//                            onDelete: {
//                                if let index = todoList.firstIndex(where: { $0.id == item.id }) {
//                                    todoList.remove(at: index)
//                                }
//                            }
                        )
                    }
                }
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 30)
                
                Spacer()
                
                // MARK: BOTTOM
                HStack {
                    Spacer()
                    Button {
                        print("add")
                        isShowingSheet.toggle()
                    } label: {
                        CustomAddButton()
                    }
                    .sheet(isPresented: $isShowingSheet, onDismiss: {
                        Task {
                            do {
                                try await todos.fetchTodos()
                            } catch {
                                print("Error \(error)")
                            }
                        }
                    }) {
                        AdditionView(onSubmit: addItem)
                            .presentationDragIndicator(.visible)
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        try await todos.fetchTodos()
                    } catch {
                        print("Error \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
