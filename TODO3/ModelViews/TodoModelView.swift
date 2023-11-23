//
//  TodoViewModel.swift
//  TODO3
//
//  Created by Dimitri Liauw on 23/11/2023.
//

import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var todos = [Todo]()
    
    func fetchTodos() async throws {
        let urlString = Constants.baseURL + Endpoints.todos
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let todoResponse: [Todo] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.todos = todoResponse
        }
    }
}

