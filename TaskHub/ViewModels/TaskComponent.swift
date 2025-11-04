//
//  TaskComponent.swift
//  TaskHub
//
//  Created by Marcos Tito
//

import SwiftUI

struct TaskComponent: View {
    let name: String?
    let desc: String?
    let date: Date?

    init(name: String?, desc: String? = nil, date: Date? = nil) {
        self.name = name
        self.desc = desc
        self.date = date
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.component)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 10) {
                Text(name ?? "Tarea sin título")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.text)
                    .multilineTextAlignment(.leading)

                if let desc = desc, !desc.isEmpty {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.text.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }

                Spacer()

                if let date = date {
                    Text(date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
        }
        .frame(width: 250, height: 250)
    }
}

#if DEBUG
struct TaskComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundApp.ignoresSafeArea()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    TaskComponent(
                        name: "Diseñar la vista principal",
                        desc: "Definir colores pastel y ajustar la navegación",
                        date: Date()
                    )

                    TaskComponent(
                        name: "Revisar Core Data",
                        desc: "Probar la persistencia y el fetch de tareas.",
                        date: Date().addingTimeInterval(-3600)
                    )

                    TaskComponent(
                        name: "Publicar la versión inicial",
                        desc: "Enviar build a TestFlight y validar con usuarios.",
                        date: Date().addingTimeInterval(86400)
                    )
                }
                .padding(20)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
