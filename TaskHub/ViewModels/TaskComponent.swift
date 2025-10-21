import SwiftUI

struct TaskComponent: View {
    var body: some View {
        ZStack {
            // Fondo del componente
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.component)
                .shadow(radius: 10)
            
            // Contenido dentro del rectángulo
            VStack {
                // Título arriba izquierda
                HStack {
                    Text("Task")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.text)
                    Spacer()
                }

                Spacer()

                // Descripción abajo izquierda
                HStack {
                    Text("Descripción de la tarea o algo similar")
                        .font(.subheadline)
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .padding(20)
        }
        .frame(width: 250, height: 250)
    }
}

#Preview {
    ZStack {
        Color.backgroundApp.ignoresSafeArea()
        TaskComponent()
    }
}
