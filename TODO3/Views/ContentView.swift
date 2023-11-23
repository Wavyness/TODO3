//
//  ContentView.swift
//  TODO3
//
//  Created by Dimitri Liauw on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var todoList = TodoViewModel()
    @State var isShowingSheet: Bool = false
    
    // MARK: - FUNCTIONS
    func addItem(name: String) async throws {
        let urlString = Constants.baseURL + Endpoints.todos
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let todo = Todo(id: nil, name: name, isTicked: false)
        try await HttpClient.shared.sendData(to: url, object: todo, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func deleteItem(id: UUID?) async throws {
        let urlString = Constants.baseURL + Endpoints.todos + "/\(id!)"
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        Task {
            do {
                try await HttpClient.shared.delete(at: id!, url: url)
            } catch {
                print("Error \(error)")
            }
            
            do {
                try await todoList.fetchTodos()
            } catch {
                print("Error \(error)")
            }
        }
        
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
                // MARK: - HEADER
                Text("Todo's")
                    .foregroundColor(.white)
                    .font(.system(size: 50, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.top, 30)
                    .shadow(radius: 2, x: 3, y: 5)
                
                // MARK: - MAIN
                if todoList.todos.isEmpty {
                    VStack {
                        Spacer()
                        Text("Nothing to do")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.bottom, 70)
                        Spacer()
                        HStack {
                            Text("Add a todo")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.leading, 50)
                            Image(systemName: "arrowshape.turn.up.left")
                                .padding(.horizontal, 30)
                                .foregroundColor(.white)
                                .scaleEffect(x: -2, y: 1.5)
                                .rotationEffect(.degrees(45))
                        }
                    }
                } else {
                    List {
                        ForEach(todoList.todos) { todo in
                            TodoListView(
                                id: todo.id,
                                name: todo.name,
                                isTicked: todo.isTicked,
                                onDelete: deleteItem
                            )
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 30)
                }
                Spacer()
                
                // MARK: - FOOTER
                HStack {
                    Spacer()
                    Button {
                        print("Add button is pressed")
                        isShowingSheet.toggle()
                    } label: {
                        CustomAddButton()
                    }
                    .sheet(
                        isPresented: $isShowingSheet,
                        onDismiss: {
                            Task {
                                do {
                                    try await todoList.fetchTodos()
                                } catch {
                                    print("Error \(error)")
                                }
                            }
                        }
                    ) {
                        SubmissionView(onSubmit: addItem)
                            .presentationDragIndicator(.visible)
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        try await todoList.fetchTodos()
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
