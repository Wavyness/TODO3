//
//  SubmissionView.swift
//  TODO3
//
//  Created by Dimitri Liauw on 23/11/2023.
//

import SwiftUI

struct SubmissionView: View {
    var oldName = ""
    @State var name = ""
    var onSubmit: (String) async throws -> ()?
    var isNew: Bool = true
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
                Text(isNew ? "Add Todo" : "Edit Todo")
                    .font(.system(size: 40, weight: .black, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 150)
                    .padding(.bottom, -5)
                
                if !isNew {
                    Text("'\(oldName)'")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                }
                
                TextField(isNew ? "Enter todo" : "New name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20, weight: .bold))
                    .padding(30)
                    .frame(maxWidth: 330)
                
                HStack {
                    if !isNew {
                        Button {
                            print("Cancel")
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
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
                    }
                    
                    Button {
                        print(isNew ? "Submit" : "Update")
                        Task {
                            try await onSubmit(name)
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(isNew ? "Submit" : "Update")
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
                }

                Spacer()
            }
        }
    }
}

#Preview {
    SubmissionView(onSubmit: { text in
        print("Submitted name: \(text)")
    }, isNew: false)
}
