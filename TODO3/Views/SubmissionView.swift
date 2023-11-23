//
//  SubmissionView.swift
//  TODO3
//
//  Created by Dimitri Liauw on 23/11/2023.
//

import SwiftUI

struct SubmissionView: View {
    @State var name = ""
    var onSubmit: (String) async throws -> ()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .cyan,
                    .black
                ],
                startPoint: .bottomTrailing,
                endPoint: .topLeading)
            .ignoresSafeArea()
            
            VStack {
                Text("Add Todo")
                    .font(.system(size: 40, weight: .black, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 150)
                    .padding(.bottom, -5)
                
                TextField("Enter todo", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20, weight: .bold))
                    .padding(30)
                    .frame(maxWidth: 330)
                // You can still add empty todo's - need to fix this
                
                Button {
                    print("submit")
                    Task {
                        try await onSubmit(name)
                    }
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Submit")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    .cyan,
                                    .black
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: .black.opacity(0.25), radius: 0.25, x:1, y:2)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 7)
                .background(.white)
                .cornerRadius(35)
                .shadow(radius: 10, x: 4, y: 4)
                
                Spacer()
            }
        }
    }
}

#Preview {
    SubmissionView(onSubmit: { text in
        print("Submitted name: \(text)")
    })
}
