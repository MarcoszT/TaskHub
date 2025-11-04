//
//  AddTaskView.swift
//  TaskHub
//
//  Created by Marcos Tito on 19/10/25.
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var showAlert = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Nueva tarea")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.top, 40)

                    // Campo de nombre
                    TextField("Título de la tarea", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)

                    // Campo de descripción (opcional)
                    TextField("Descripción (opcional)", text: $desc)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)

                    Spacer(minLength: 100)
                }
            }

            Button(action: saveTask) {
                Text("Guardar tarea")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(name.isEmpty ? Color.gray.opacity(0.4) : Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 4)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
            .disabled(name.isEmpty)
            .alert("Tarea guardada", isPresented: $showAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Tu tarea se ha guardado correctamente.")
            }
        }
        .background(Color.backgroundApp.ignoresSafeArea())
        .navigationTitle("Agregar tarea")
    }

    private func saveTask() {
        guard !name.isEmpty else { return }
        _ = createItem(name: name, desc: desc.isEmpty ? nil : desc, in: context)
        showAlert = true
        name = ""
        desc = ""
    }
}

#Preview {
    let container = NSPersistentContainer(name: "TaskHub")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { _, error in
        if let error = error {
            fatalError("Unresolved error setting up preview store: \(error)")
        }
    }
    let context = container.viewContext
    return AddTaskView()
        .environment(\.managedObjectContext, context)
}
