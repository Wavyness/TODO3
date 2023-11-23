//
//  CustomAddButton.swift
//  TODO3
//
//  Created by Dimitri Liauw on 22/11/2023.
//

import SwiftUI

struct CustomAddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    .white.opacity(0.9)
                )
            Image(systemName: "plus")
                .font(.system(size: 30, weight: .black))
                .foregroundColor(.black)
        }
        .frame(width: 50, height: 50)
        .padding(.horizontal, 45)
        .padding(.vertical, 15)
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        CustomAddButton()
    }
}
