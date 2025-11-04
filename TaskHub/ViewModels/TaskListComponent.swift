//
// TaskListComponent.swift
// TaskHub
//
// Created by Marcos Tito
//

import SwiftUI

/// Componente independiente: recibe valores primitivos (String?, String?, Date?)
struct TaskListComponent: View {
    let name: String?
    let desc: String?
    let date: Date?

    init(name: String?, desc: String? = nil, date: Date? = nil) {
        self.name = name
        self.desc = desc
        self.date = date
    }

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name ?? "Sin título")
                    .font(.headline)
                    .foregroundColor(.primary)

                if let desc = desc, !desc.isEmpty {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }

                if let date = date {
                    Text(date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray.opacity(0.7))
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.horizontal, 10)
    }
}

#if DEBUG
struct TaskListComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            TaskListComponent(
                name: "Diseñar la vista principal",
                desc: "Definir colores pastel y navegación",
                date: Date()
            )
            TaskListComponent(
                name: "Probar persistencia",
                desc: nil,
                date: Date().addingTimeInterval(-86400)
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
