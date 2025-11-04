import SwiftUI
import CoreData

struct EditTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var task: TaskHubItem

    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var showAlert = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Editar tarea")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.top, 40)

                    TextField("Título de la tarea", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)

                    TextField("Descripción (opcional)", text: $desc)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)

                    Spacer(minLength: 100)
                }
            }

            Button(action: updateTask) {
                Text("Actualizar tarea")
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
            .alert("Tarea actualizada", isPresented: $showAlert) {
                Button("OK") { dismiss() }
            } message: {
                Text("Los cambios se guardaron correctamente.")
            }
        }
        .background(Color.backgroundApp.ignoresSafeArea())
        .onAppear {
            name = task.name ?? ""
            desc = task.desc ?? ""
        }
    }

    private func updateTask() {
        guard !name.isEmpty else { return }
        let ok = updateItem(item: task, name: name, desc: desc.isEmpty ? nil : desc, in: context)
        if ok {
            showAlert = true
        } else {
            
        }
    }
}

// Preview
#if DEBUG
struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext

        let sample = TaskHubItem(context: context)
        sample.name = "Ejemplo: Editar UI"
        sample.desc = "Descripción de muestra para editar"
        sample.date = Date()

        try? context.save()

        return NavigationStack {
            EditTaskView(task: sample)
                .environment(\.managedObjectContext, context)
        }
    }
}
#endif
