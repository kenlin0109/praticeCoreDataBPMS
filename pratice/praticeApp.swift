//
//  praticeApp.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import SwiftUI

@main
struct praticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
