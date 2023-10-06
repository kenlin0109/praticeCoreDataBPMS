//
//  praticeApp.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import SwiftUI

final class Theme: ObservableObject {
    @Published var isDarkMode : Bool = false
}

final class LanguageTheme: ObservableObject {
    @Published var isZhorEn : Bool = false
}

@main
struct praticeApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var currentTheme = Theme()
    @StateObject var currentLanguage = LanguageTheme()
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(currentTheme)
                .environmentObject(currentLanguage)
        }
    }
}
