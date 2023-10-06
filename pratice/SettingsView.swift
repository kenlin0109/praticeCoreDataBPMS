//
//  SettingsView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/26.
//

import Foundation
import SwiftUI
import CoreData

struct SettingsView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var language: LanguageTheme
    @State var isDarkMode: Bool = false
    @State var isZhorEn: Bool = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text(language.isZhorEn ? "Display" : "顯示")
                    //footer: Text("System settings will override Dark Mode are use the current device theme")
                ) {
                    Toggle(language.isZhorEn ? "Dark mode" : "暗黑模式",isOn: $theme.isDarkMode)
                    //Toggle("Use system settings",isOn: $isSystemSettings)
                    Toggle(language.isZhorEn ? "Language ch/en" : "語言 中文/英文",isOn: $language.isZhorEn)
                }
                Section {
                    Label("Follow me on twitter", systemImage: "link")
                }
                //Text(colorScheme == .dark ? "In dark Mode" : "In light Mode")
            }
            .navigationTitle(language.isZhorEn ? "Setting" : "設定")
        }
        //        .foregroundColor(.black)
        //        .font(.system(size: 16, weight: .semibold))
    }
}

