//
//  TaskHubApp.swift
//  TaskHub
//
//  Created by Marcos Tito on 19/10/25.
//

import SwiftUI

@main
struct TaskHubApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()                
            }
        }
    }
}
