//
//  TaskHubApp.swift
//  TaskHub
//
//  Created by Marcos Tito on 19/10/25.
//

import SwiftUI
import CoreData

@main
struct TaskHubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

