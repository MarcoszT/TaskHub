//
//  HomeView.swift
//  TaskHub
//
//  Created by Marcos Tito on 19/10/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var context
    @State private var tasks: [TaskHubItem] = []
    @State private var isListView = false
    @State private var selectedTask: TaskHubItem? = nil
    @State private var navigateToEdit = false

    var body: some View {
        ZStack {
            // MARK: - Fondo base
            Color.backgroundApp
                .ignoresSafeArea()

            // MARK: - Oscurecer fondo si hay tarea seleccionada
            if selectedTask != nil {
                Color.black.opacity(0.45)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedTask = nil
                        }
                    }
            }

            VStack(spacing: 20) {
                // MARK: - Encabezado
                HStack {
                    Text("Tareas")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.text)

                    Spacer()

                    Button {
                        withAnimation(.easeInOut) {
                            isListView.toggle()
                            selectedTask = nil
                        }
                    } label: {
                        Image(systemName: isListView ? "square.grid.2x2.fill" : "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.text)
                            .padding(8)
                            .background(Color.backgroundSelectedComponent.opacity(0.3))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer()

                // MARK: - Lista o Carrusel
                if isListView {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(tasks, id: \.objectID) { task in
                                ZStack(alignment: .trailing) {
                                    TaskListComponent(
                                        name: task.name ?? "",
                                        desc: task.desc ?? "",
                                        date: task.date
                                    )
                                    .blur(radius: selectedTask != nil && selectedTask != task ? 5 : 0)
                                    .onLongPressGesture {
                                        withAnimation(.spring()) {
                                            selectedTask = (selectedTask == task) ? nil : task
                                        }
                                    }

                                    if selectedTask == task {
                                        HStack(spacing: 12) {
                                            Button {
                                                deleteItem(task, in: context)
                                                tasks = getAllItems(in: context)
                                                selectedTask = nil
                                            } label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                                    .background(Color.red.opacity(0.8))
                                                    .clipShape(Circle())
                                            }

                                            // ✅ Navegar a EditTaskView
                                            NavigationLink(
                                                destination: EditTaskView(task: task)
                                                    .environment(\.managedObjectContext, context),
                                                isActive: $navigateToEdit
                                            ) {
                                                Button {
                                                    selectedTask = nil
                                                    navigateToEdit = true
                                                } label: {
                                                    Image(systemName: "pencil")
                                                        .foregroundColor(.white)
                                                        .padding(8)
                                                        .background(Color.blue.opacity(0.8))
                                                        .clipShape(Circle())
                                                }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        .padding(.trailing, 16)
                                        .transition(.opacity.combined(with: .scale))
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(tasks, id: \.objectID) { task in
                                ZStack {
                                    TaskComponent(
                                        name: task.name,
                                        desc: task.desc,
                                        date: task.date
                                    )
                                    .blur(radius: selectedTask != nil && selectedTask != task ? 5 : 0)
                                    .onLongPressGesture {
                                        withAnimation(.spring()) {
                                            selectedTask = (selectedTask == task) ? nil : task
                                        }
                                    }

                                    // ✅ Botones centrados sobre el componente
                                    if selectedTask == task {
                                        HStack(spacing: 30) {
                                            Button {
                                                deleteItem(task, in: context)
                                                tasks = getAllItems(in: context)
                                                selectedTask = nil
                                            } label: {
                                                Image(systemName: "trash")
                                                    .font(.title2)
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .background(Color.red.opacity(0.8))
                                                    .clipShape(Circle())
                                            }

                                            // ✅ Navegar a EditTaskView
                                            NavigationLink(
                                                destination: EditTaskView(task: task)
                                                    .environment(\.managedObjectContext, context),
                                                isActive: $navigateToEdit
                                            ) {
                                                Button {
                                                    selectedTask = nil
                                                    navigateToEdit = true
                                                } label: {
                                                    Image(systemName: "pencil")
                                                        .font(.title2)
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .background(Color.blue.opacity(0.8))
                                                        .clipShape(Circle())
                                                }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        .transition(.opacity.combined(with: .scale))
                                    }
                                }
                            }
                        }
                        .padding(20)
                    }
                    .frame(height: 280)
                }

                Spacer()

                // MARK: - Nueva tarea
                NavigationLink(
                    destination: AddTaskView()
                        .environment(\.managedObjectContext, context)
                ) {
                    Label("Nueva tarea", systemImage: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.text)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.backgroundApp.opacity(0.2))
                        .cornerRadius(12)
                }
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            tasks = getAllItems(in: context)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
