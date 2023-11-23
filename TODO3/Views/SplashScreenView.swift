//
//  SplashScreenView.swift
//  TODO3
//
//  Created by Dimitri Liauw on 22/11/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scale = 0.4
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                LinearGradient(
                    colors: [
                        .black,
                        .cyan
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                VStack {
                    VStack (spacing: -60) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                        Text("TODO3")
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.bottom, 60)
                    }
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.smooth(duration: 0.6)) {
                            self.scale = 0.9
                            self.opacity = 1
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
                
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SplashScreenView()
}
