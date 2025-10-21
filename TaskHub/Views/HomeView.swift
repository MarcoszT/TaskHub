//
//  HomeView.swift
//  TaskHub
//
//  Created by Marcos Tito on 19/10/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.backgroundApp
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<4, id: \.self) { _ in
                            NavigationLink(destination: DetailTask()) {
                                TaskComponent()
                            }
                        }
                    }
                    .padding(20)
                }
                .frame(height: 280)
                
                Spacer()

                NavigationLink(destination: AddTaskView()) {
                    Label("Nueva tarea", systemImage: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.text)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.backgroundApp.opacity(0.2))
                        .cornerRadius(12)
                }

            }
        }
        .navigationTitle("Tareas")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
